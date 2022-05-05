# Check Persistent Storage Health

```
ROOK_PATH=${AKASH_ROOT}/_docs/rook/test ./script/rook.sh health
```

### **Expected Output**

```
root@node1:~/akash# ROOK_PATH=${AKASH_ROOT}/_docs/rook/test ./script/rook.sh health

Wait for rook deploy... 0s
Checking CEPH cluster state: [Created]
Creating CEPH cluster is done. [HEALTH_OK]
```
