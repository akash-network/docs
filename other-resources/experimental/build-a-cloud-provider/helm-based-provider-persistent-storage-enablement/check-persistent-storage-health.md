# Check Persistent Storage Health

## Persistent Storage Status Check

```
kubectl -n rook-ceph get cephclusters
```

### **Expected Output**

```
root@node1:~/akash# kubectl -n rook-ceph get cephclusters

NAME        DATADIRHOSTPATH   MONCOUNT   AGE     PHASE   MESSAGE                        HEALTH      EXTERNAL
rook-ceph   /var/lib/rook     1          5m18s   Ready   Cluster created successfully   HEALTH_OK
```
