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
root@node1:/home/ubuntu# kubectl get nodes

NAME    STATUS   ROLES                  AGE     VERSION
node1   Ready    control-plane,master   5m48s   v1.22.5
node2   Ready    control-plane,master   5m22s   v1.22.5
node3   Ready    control-plane,master   5m12s   v1.22.5
node4   Ready    <none>                 4m7s    v1.22.5
```

## **Confirm Kubernetes Pods**

```
kubectl get pods -n kube-system
```

### Example output of the pods that are the brains of the cluster

```
root@node1:/home/ubuntu# kubectl get pods -n kube-system

NAME                                      READY   STATUS    RESTARTS        AGE
calico-kube-controllers-5788f6558-mzm64   1/1     Running   1 (4m53s ago)   4m54s
calico-node-2g4pr                         1/1     Running   0               5m29s
calico-node-6hrj4                         1/1     Running   0               5m29s
calico-node-9dqc4                         1/1     Running   0               5m29s
calico-node-zt8ls                         1/1     Running   0               5m29s
coredns-8474476ff8-9sgm5                  1/1     Running   0               4m32s
coredns-8474476ff8-x67xd                  1/1     Running   0               4m27s
dns-autoscaler-5ffdc7f89d-lnpmm           1/1     Running   0               4m28s
kube-apiserver-node1                      1/1     Running   1               7m30s
kube-apiserver-node2                      1/1     Running   1               7m13s
kube-apiserver-node3                      1/1     Running   1               7m3s
kube-controller-manager-node1             1/1     Running   1               7m30s
kube-controller-manager-node2             1/1     Running   1               7m13s
kube-controller-manager-node3             1/1     Running   1               7m3s
kube-proxy-75s7d                          1/1     Running   0               5m56s
kube-proxy-kpxtm                          1/1     Running   0               5m56s
kube-proxy-stgwd                          1/1     Running   0               5m56s
kube-proxy-vndvs                          1/1     Running   0               5m56s
kube-scheduler-node1                      1/1     Running   1               7m37s
kube-scheduler-node2                      1/1     Running   1               7m13s
kube-scheduler-node3                      1/1     Running   1               7m3s
nginx-proxy-node4                         1/1     Running   0               5m58s
nodelocaldns-7znkj                        1/1     Running   0               4m28s
nodelocaldns-g8dqm                        1/1     Running   0               4m27s
nodelocaldns-gf58m                        1/1     Running   0               4m28s
nodelocaldns-n88fj                        1/1     Running   0               4m28s
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
