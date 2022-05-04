# STEP 9 - Review Firewall Policies

If local firewall instances are running on Kubernetes control-plane and worker nodes, add the following policies.

## **Etcd Key Value Store Policies**

Ensure the following ports are open inbound on all Kubernetes etcd instances:

```
- 2379/tcp for client requests; (Kubernetes control plane to etcd)
- 2380/tcp for peer communication; (etcd to etcd communication)
```

## **API Server Policies**



Ensure the following ports are open inbound on all Kubernetes API server instances:

```
- 6443/tcp - Kubernetes API server
```

## Worker Node Policies

Ensure the following ports are open inbound on all Kubernetes worker nodes:

```
- 10250/tcp - Kubelet API server; (Kubernetes control plane to kubelet)
```
