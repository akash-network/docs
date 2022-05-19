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
loop0    squashfs 4.0                                                              0   100% /snap/amazon-ssm-agent/5163
loop1    squashfs 4.0                                                              0   100% /snap/core18/2344
loop2    squashfs 4.0                                                              0   100% /snap/core20/1405
loop3    squashfs 4.0                                                              0   100% /snap/core20/1434
loop4    squashfs 4.0                                                              0   100% /snap/lxd/22923
loop5    squashfs 4.0                                                              0   100% /snap/snapd/15177
loop6    squashfs 4.0                                                              0   100% /snap/snapd/15534
loop7    squashfs 4.0                                                              0   100% /snap/core18/2409
xvda
├─xvda1  ext4     1.0   cloudimg-rootfs e7879b8a-f914-4210-998a-d47604682e59   39.4G    18% /
├─xvda14
└─xvda15 vfat     FAT32 UEFI            594C-4810                              99.1M     5% /boot/efi
xvdf
```
