---
description: Configure provider to offer sufficient ephemeral storage
---

# STEP 6 - Provider Ephemeral Storage Config (OPTIONAL)

## Overview

Ensure that the provider is configured to offer more ephemeral storage than is available at the OS root partition.

Objective of this guide - move /var/lib/kubelet (nodefs) and /var/lib/containerd (imagefs) onto the RAID0 NVME disk mounted over the /data directory.

* _**nodefs**_: The node's main filesystem, used for local disk volumes, emptyDir, log storage, and more. For example - nodefs contains /var/lib/kubelet/.
* _**imagefs**_: An optional filesystem that container runtimes use to store container images and container writable layers.

## Ephemeral and Persistent Storage Considerations

Notes to consider when planning your provider storage allocations:

* Ephemeral storage is faster (in terms of IOPS) and persistent storage can be slower (in terms of IOPS).  This is due to network latency associated with persistent storage and as the storage nodes (or the pods to storage nodes) are connected over the network.
* Some types of deployments - such as Chia workloads - do not need persistent storage and need just ephemeral storage

## Observations

Stopping `kubelet` alone does not clear the `/var/lib/kubelet` open file handles locked by pods using it. Hence, `kubelet` should be disabled, node restarted.

`kubectl drain` (& `kubectl uncordon` after) is not sufficient as `Ceph OSD` can't be evicted due to PDB (Pod's Disruption Budget).

Associated error when attempting to stop/start `kubelet`:

```
error when evicting pods/"rook-ceph-osd-60-5fb688f86b-9hzt2" -n "rook-ceph" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
```

```
$ kubectl -n rook-ceph describe pdb
Name:             rook-ceph-osd
Namespace:        rook-ceph
Max unavailable:  1
Selector:         app=rook-ceph-osd
Status:
    Allowed disruptions:  0
    Current:              119
    Desired:              119
    Total:                120
Events:                   <none>
```

## Recommended Steps

### STEP 1 - Stop and disable `Kubelet` & `containerd`

```
systemctl stop kubelet
systemctl disable kubelet

systemctl stop containerd
systemctl disable containerd
```

### STEP 2 - Reboot the node

* Have to reboot the node so it will release the `/var/lib/kubelet` and `/var/lib/containerd`

_**Verify**_

```
root@k8s-node-1:~# lsof -Pn 2>/dev/null |grep -E '/var/lib/kubelet|/var/lib/containerd'
# should be no response here, this will indicate /var/lib/kubelet and /var/lib/containerd are not used.
```

### STEP 3 - Find 2 free NVME disks

```
root@k8s-node-0:~# lsblk
...
nvme0n1                                                                                               259:0    0   1.5T  0 disk 
nvme1n1                                                                                               259:1    0   1.5T  0 disk 
```

### STEP 4 - Create RAID0 over 2 NVME

```
root@k8s-node-0:~# mdadm --create /dev/md0 --level=raid0 --metadata=1.2 --raid-devices=2 /dev/nvme0n1 /dev/nvme1n1
mdadm: array /dev/md0 started.
```

_**Verify:**_

```
root@k8s-node-0:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid0 nvme1n1[1] nvme0n1[0]
      3125626880 blocks super 1.2 512k chunks
      
unused devices: <none>
```

### STEP 5 - Format /dev/md0

```
root@k8s-node-0:~# mkfs.ext4 /dev/md0
```

### STEP 6 - Move old kubelet data

```
mv /var/lib/kubelet /var/lib/kubelet-backup
```

### STEP 7 - Update fstab with the new /dev/md0

#### **Backup fstab**

```
cp -p /etc/fstab /etc/fstab.1
```

#### Update fstab

> Remove ,discard after defaults if you are NOT using SSD/NVME disks!

```
cat >> /etc/fstab << EOF
UUID="$(blkid /dev/md0 -s UUID -o value)"  /data        ext4   defaults,discard  0 0
EOF
```

#### Verify

```
diff -Nur /etc/fstab.1 /etc/fstab
```

### STEP 8- Mount /dev/md0 as /data

```
mkdir /data
mount /data
```

#### Verify

```
root@k8s-node-0:~# df -Ph /data
Filesystem      Size  Used Avail Use% Mounted on
/dev/md0        2.9T   89M  2.8T   1% /data
```

### STEP 9 - Generate mdadm.conf so it gets detected on boot

```
root@k8s-node-0:~# /usr/share/mdadm/mkconf > /etc/mdadm/mdadm.conf
```

#### Verify

```
root@k8s-node-0:~# cat /etc/mdadm/mdadm.conf | grep -v ^\#


HOMEHOST <system>

MAILADDR root

ARRAY /dev/md/0  metadata=1.2 UUID=a96501a3:955faf1e:06f8087d:503e8c36 name=k8s-node-0.mainnet-1.ca:0
```

### STEP 10 - Regenerate initramfs so the new mdadm.conf gets there

```
root@k8s-node-0:~# update-initramfs -c -k all
```

### STEP 11 - Move kubelet data onto RAID0

```
mv /var/lib/kubelet-backup /data/kubelet
```

#### Verify

```
root@k8s-node-0:~# df -Ph /data
Filesystem      Size  Used Avail Use% Mounted on
/dev/md0        2.9T   43G  2.7T   2% /data
```

### STEP 12 - Move the containerd to the new path

```
mv /var/lib/containerd /data/containerd
```

### STEP 13 - kubespray the cluster with the following config

```
containerd_storage_dir: "/data/containerd"
kubelet_custom_flags:
  "--root-dir=/data/kubelet"
```

### STEP 14 - Start and enable containerd

```
systemctl start containerd
systemctl enable containerd
```

### STEP 15 - Start and enable kubelet

```
systemctl start kubelet
systemctl enable kubelet
```

#### Verify

```
journalctl -u kubelet -f
```

### STEP 16 - Wait until all pods are Running

```
kubectl get pods -A -o wide | grep <your node>
```

## Make applications aware of the new nodefs location

> If you aren't using `rook-ceph` / `velero`, then skip this section

### Ceph's rook-ceph-operator

```
csi:
  kubeletDirPath: /data/kubelet
```

### Velero restic

> velero helm-chart config

```
restic:
  podVolumePath: /data/kubelet/pods
```
