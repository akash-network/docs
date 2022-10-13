# Persistent Storage Requirements



## Environment Overview

When planning persistent storage, take into account the network (between the storage nodes) as a factor which will cause the latency, causing slower disk throughput / IOPS. This might not be suitable for heavy IOPS applications such as Solana validator.&#x20;

In this case the "all-in-one" provider configuration might be desirable to avoid the network affecting the storage performance. I.e. for the best disk performance, the pods should run where persistent storage has been deployed.&#x20;

It is advised to run control-plane / etcd separately, for sake of performance and security. We recommend to benchmark your storage with this [script](https://github.com/masonr/yet-another-bench-script) before and after deploying Persistent Storage. This will help know the difference before starting to advertising your provider on the Akash network.

## Environment Requirements

For hosting of persistent storage please note the following, strict requirements for production use.

At least three Ceph OSDs are normally required for redundancy and high availability.

**Single storage node configuration**

* At least 3 HDD or SSD disks with 1 OSD per disk; (which makes a total 3 of OSDs)
* At least 2 NVME disks with 2 OSDs per disk; (which makes a total 4 of OSDs)

**Three storage nodes configuration**

* At least 1 HDD/SSD/NVME disk with 1 OSD per disk over 3 storage nodes; (which makes a total 3 of OSDs)

#### Maximum OSDs per single drive&#x20;

* HDD 1 OSD
* SSD 1 OSD
* NVME 2 OSDs

#### Additional Requirements

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
