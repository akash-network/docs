# Environment Review

## Retrieve Node Names

Gather the Kubernetes names of all nodes within your cluster.  We will use the node names in a subsequent step.

```
kubectl get nodes -ojson | jq -r '.items[].metadata.labels."kubernetes.io/hostname"'
```

#### **Example Output**

```
root@node1:~/akash# kubectl get nodes -ojson | jq -r '.items[].metadata.labels."kubernetes.io/hostname"'

node1
node2
node3
```

## Ensure Unformatted Drives

* Rook-Ceph will automatically discover free, raw partitions.  Use the following command on the host that will serve persistent storage to ensure the intended partition as no file system.

```
lsblk -f
```

### Example/Expected Output

* In this example we have can see that the `xvdf` is unformatted and ready for persistent storage use

```
root@node2:~# lsblk -f
NAME     FSTYPE   FSVER LABEL           UUID                                 FSAVAIL FSUSE% MOUNTPOINTS

xvda
├─xvda1  ext4     1.0   cloudimg-rootfs e7879b8a-f914-4210-998a-d47604682e59   39.4G    18% /
├─xvda14
└─xvda15 vfat     FAT32 UEFI            594C-4810                              99.1M     5% /boot/efi
xvdf
```

## LVM Package <a href="#lvm-package" id="lvm-package"></a>

Ceph OSDs have a dependency on LVM in the following scenarios:

* OSDs are created on raw devices or partitions
* If encryption is enabled (`encryptedDevice: true` in the cluster CR)
* A `metadata` device is specified

For persistent storage use the OSDs are created on raw partitions.  Issue the following command on each node serving persistent storage.

```
apt-get install -y lvm2
```
