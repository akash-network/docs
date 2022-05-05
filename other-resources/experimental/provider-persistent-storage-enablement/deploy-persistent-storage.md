# Deploy Persistent Storage

## Ensure Unformatted Drives

* Rook-Ceph will automatically discover free, raw partitions.  Use the following command on the host that will serve persistent storage to ensure the partition as no file system.

```
lsblk -f
```

## **Execute Rook Deployment**

* Deployment typically takes approximately 10 minutes to complete**.**
* Note - if any issues are encountered during the Rook deployment, tear down the Rook-Ceph components via the steps listed [here](broken-reference) and begin anew.

```
cd ~/akash

ROOK_PATH=${AKASH_ROOT}/_docs/rook/test ./script/rook.sh deploy
```
