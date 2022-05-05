# Deploy Persistent Storage

## Ensure Unformatted Drives

* Rook-Ceph will automatically discover free, raw partitions.  Use the following command on the host that will serve persistent storage to ensure the intended partition as no file system.

```
lsblk -f
```

## **Execute Rook Deployment**

* Step in this section should be conducted from the Kubernetes master node on which the Akash repo was downloaded and where the cluster.yaml file was customized.
* Deployment typically takes approximately 10 minutes to complete**.**
* Note - if any issues are encountered during the Rook deployment, tear down the Rook-Ceph components via the steps listed [here ](teardown.md)and begin anew.

```
cd ~/akash

ROOK_PATH=${AKASH_ROOT}/_docs/rook/test ./script/rook.sh deploy
```
