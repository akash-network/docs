# Confirm Kubernetes Cluster

A couple of quick Kubernetes cluster checks are in order before moving into next steps.

## SSH into Kubernetes Master Node

> _**NOTE**_ - the verifications in this section must be completed on a master node with Kubectl access to the cluster.

## Confirm Kubernetes Nodes

```
kubectl get nodes
```

### **Example output from a healthy Kubernetes cluster**

```
root@node1:~# kubectl get nodes

NAME    STATUS   ROLES           AGE   VERSION
node1   Ready    control-plane   18m   v1.25.6
node2   Ready    <none>          17m   v1.25.6
node3   Ready    <none>          17m   v1.25.6
```

## **Confirm Kubernetes Pods**

```
kubectl get pods -n kube-system
```

### Example output of the pods that are the brains of the cluster

```
root@node1:~# kubectl get pods -n kube-system

NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-75748cc9fd-vv84p   1/1     Running   0          17m
calico-node-ns4ps                          1/1     Running   0          17m
calico-node-ttwzt                          1/1     Running   0          17m
calico-node-wxlsj                          1/1     Running   0          17m
coredns-588bb58b94-hbk94                   1/1     Running   0          17m
coredns-588bb58b94-vr8j5                   1/1     Running   0          17m
dns-autoscaler-5b9959d7fc-g4jmj            1/1     Running   0          17m
kube-apiserver-node1                       1/1     Running   1          19m
kube-controller-manager-node1              1/1     Running   1          19m
kube-proxy-6vs5w                           1/1     Running   0          18m
kube-proxy-czqfr                           1/1     Running   0          18m
kube-proxy-k52bw                           1/1     Running   0          18m
kube-scheduler-node1                       1/1     Running   1          19m
nginx-proxy-node2                          1/1     Running   0          17m
nginx-proxy-node3                          1/1     Running   0          18m
nodelocaldns-75mn2                         1/1     Running   0          17m
nodelocaldns-cj6gq                         1/1     Running   0          17m
nodelocaldns-tnkmd                         1/1     Running   0          17m
```

## Verify etcd Status and Health

> &#x20;Commands should be run on the control plane node to ensure health of the Kubernetes `etcd` database

```
export $(grep -v '^#' /etc/etcd.env | xargs -d '\n')
etcdctl -w table member list
etcdctl endpoint health --cluster -w table
etcdctl endpoint status --cluster -w table
etcdctl check perf
```

### Example/Expected Output of etcd Health Check

```
root@node1:~# export $(grep -v '^#' /etc/etcd.env | xargs -d '\n')
root@node1:~# etcdctl -w table member list
+------------------+---------+-------+--------------------------+--------------------------+------------+
|        ID        | STATUS  | NAME  |        PEER ADDRS        |       CLIENT ADDRS       | IS LEARNER |
+------------------+---------+-------+--------------------------+--------------------------+------------+
| e9bba4ecf3734bea | started | etcd1 | https://10.128.0.21:2380 | https://10.128.0.21:2379 |      false |
+------------------+---------+-------+--------------------------+--------------------------+------------+
root@node1:~# etcdctl endpoint health --cluster -w table
+--------------------------+--------+-------------+-------+
|         ENDPOINT         | HEALTH |    TOOK     | ERROR |
+--------------------------+--------+-------------+-------+
| https://10.128.0.21:2379 |   true | 11.767326ms |       |
+--------------------------+--------+-------------+-------+
root@node1:~# etcdctl endpoint status --cluster -w table
+--------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
|         ENDPOINT         |        ID        | VERSION | DB SIZE | IS LEADER | IS LEARNER | RAFT TERM | RAFT INDEX | RAFT APPLIED INDEX | ERRORS |
+--------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
| https://10.128.0.21:2379 | e9bba4ecf3734bea |   3.5.6 |  7.7 MB |      true |      false |         3 |       3348 |               3348 |        |
+--------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
root@node1:~# etcdctl check perf
 59 / 60 Booooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooom   !  98.33%PASS: Throughput is 150 writes/s
PASS: Slowest request took 0.011899s
PASS: Stddev is 0.000805s
PASS
```
