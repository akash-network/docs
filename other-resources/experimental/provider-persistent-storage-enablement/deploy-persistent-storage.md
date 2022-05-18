# Deploy Persistent Storage

## Ensure Unformatted Volume Exist

* Rook-Ceph will automatically discover free, raw partitions.  Use the following command on the host that will serve persistent storage to ensure the intended partition as no file system.

```
lsblk -f
```

### Example/Expected Output

* In this example we find the unformatted partition of `xvdf` which would be used as the persistent storage volume

```
root@node2:~# lsblk -f
NAME     FSTYPE   FSVER LABEL           UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
loop0    squashfs 4.0                                                              0   100% /snap/core18/2344
loop1    squashfs 4.0                                                              0   100% /snap/amazon-ssm-agent/5163
loop2    squashfs 4.0                                                              0   100% /snap/core20/1405
loop3    squashfs 4.0                                                              0   100% /snap/lxd/22923
loop4    squashfs 4.0                                                              0   100% /snap/snapd/15177
loop5    squashfs 4.0                                                              0   100% /snap/snapd/15534
loop6    squashfs 4.0                                                              0   100% /snap/core20/1434
loop7    squashfs 4.0                                                              0   100% /snap/core18/2409
loop8    squashfs 4.0                                                              0   100% /snap/amazon-ssm-agent/5656
xvda
├─xvda1  ext4     1.0   cloudimg-rootfs e7879b8a-f914-4210-998a-d47604682e59   39.5G    18% /
├─xvda14
└─xvda15 vfat     FAT32 UEFI            594C-4810                              99.1M     5% /boot/efi
xvdf
```

## **Execute Rook Deployment**

* Step in this section should be conducted from the Kubernetes master node on which the Akash repo was downloaded and where the cluster.yaml file was customized.
* Deployment typically takes approximately 10 minutes to complete**.**
* Note - if any issues are encountered during the Rook deployment, tear down the Rook-Ceph components via the steps listed [here ](teardown.md)and begin anew.

```
cd ~/akash

ROOK_PATH=${AKASH_ROOT}/_docs/rook/test ./script/rook.sh deploy
```
