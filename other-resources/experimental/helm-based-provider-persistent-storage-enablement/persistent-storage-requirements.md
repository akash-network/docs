# Persistent Storage Requirements

For hosting of persistent storage please note the following, strict requirements for production use:

* Minimum three bare metal storage nodes with the following OSD configuration per node:
  * HDD disks: minimum 2 OSD&#x20;
  * SSD disks: minimum 3 OSD
  * NVME disks: minimum 5 OSD
* Minimum three CEPH managers
* Minimum three CEPH monitors
