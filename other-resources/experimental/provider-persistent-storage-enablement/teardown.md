# Teardown



If a problem is experienced during persistent storage enablement, follow these steps to begin anew.

## **Rook-Ceph Teardown**

```
cd ~/akash

ROOK_PATH=${AKASH_ROOT}/_docs/rook/test ./script/rook.sh teardown
```

## Resetting Persistent Storage Drives

Disks on nodes used by Rook for osds can be reset to a usable, unformatted state with the following method.

Execute the following script on each node that participated in Rook cluster with a list of comma separated devices that need to be wiped.  Example drives sda,sdc, and sdg used in example below.

### **Script**

Create a local file with the following script:

```
#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
	echo "Illegal number of parameters"
fi

# Zap the disk to a fresh, usable state (zap-all is important, b/c MBR has to be clean)
IFS=","
for disk in ${$1}; do
	dev=/dev/${disk}
	sgdisk --zap-all /dev/${disk}
	
	if [[ $(cat /sys/block/${disk}/queue/rotational) == "1" ]]; then
		# Clean hdds with dd
		dd if=/dev/zero of=${dev} bs=1M count=100 oflag=direct,dsync
	else
		# Clean disks such as ssd with blkdiscard instead of dd
		blkdiscard ${dev}
	fi
	
	# Inform the OS of partition table changes
partprobe ${dev}
done

# These steps only have to be run once on each node
# If rook sets up osds using ceph-volume, teardown leaves some devices mapped that lock the disks.
ls /dev/mapper/ceph-* | xargs -I% -- dmsetup remove %

# ceph-volume setup can leave ceph-<UUID> directories in /dev and /dev/mapper (unnecessary clutter)
rm -rf /dev/ceph-*
rm -rf /dev/mapper/ceph--*
```

* Execute the script with target drives to be wiped specified
* Example:

```
./zap.sh sda,sdc,sdg
```
