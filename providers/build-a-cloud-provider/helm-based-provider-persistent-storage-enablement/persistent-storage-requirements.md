# Persistent Storage Requirements

## Environment Requirements

For hosting of persistent storage please note the following, strict requirements for production use:

* Minimum three bare metal storage nodes with the following OSD configuration per node:
  * HDD disks: minimum 2 OSD&#x20;
  * SSD disks: minimum 3 OSD
  * NVME disks: minimum 5 OSD
* Minimum two Ceph managers
* Minimum three Ceph monitors
* Minimum recommended disk space at /`var/lib/ceph/` is greater than `60 GiB` as each Ceph Monitor (ceph mon) requires `60 GiB` of disk space
* Additional Ceph minimum hardware requirements may be reviewed in the following document:
  * [Ceph Minimum Hardware Recommendations](https://docs.ceph.com/en/quincy/start/hardware-recommendations/#minimum-hardware-recommendations)
* Running multiple OSDs on a single SAS / SATA drive is NOT a good idea. NVMe drives, however, can achieve improved performance by being split into two or more OSDs.
* Running an OSD and a monitor or a metadata server on a single drive is also NOT a good idea.

## Ceph Prerequisites <a href="#ceph-prerequisites" id="ceph-prerequisites"></a>

In order to configure the Ceph storage cluster, at least one of these local storage options are required:

* Raw devices (no partitions or formatted filesystems)
* Raw partitions (no formatted filesystem)
* PVs available from a storage class in `block` mode

\
