# STEP 7 - Inventory Operator Install

_**NOTE**_ - the Inventory Operator is now required on ALL Akash Providers.  Previously this operator was only required when the Provider hosted persistent storage.  But the operator is now mandated on all providers.

```
helm install inventory-operator akash/akash-inventory-operator -n akash-services
```

#### Expected Output

```
root@node1:~/helm-charts/charts# helm install inventory-operator akash/akash-inventory-operator -n akash-services

NAME: inventory-operator
LAST DEPLOYED: Thu May  5 18:15:57 2022
NAMESPACE: akash-services
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## **Inventory Operator Confirmation**

```
kubectl get pods -n akash-services -o wide
```

#### **Expected output (pod names will differ)**

> _**NOTE**_ - a pod should exist for the Inentory Operator itself (I.e. `operator-inventory-7d97d54b7f-sjz5v` in the example below) and one Hardware Discovery pod per Kubernetes host.

```
root@node1:~# kubectl get pods -n akash-services -o wide
NAME                                          READY   STATUS    RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
operator-hostname-84875c8df7-rzfct            1/1     Running   0          4m31s   10.233.71.2      node3   <none>           <none>
operator-inventory-7d97d54b7f-sjz5v           1/1     Running   0          3m54s   10.233.75.2      node2   <none>           <none>
operator-inventory-hardware-discovery-node1   1/1     Running   0          3m49s   10.233.102.131   node1   <none>           <none>
operator-inventory-hardware-discovery-node2   1/1     Running   0          3m49s   10.233.75.3      node2   <none>           <none>
operator-inventory-hardware-discovery-node3   1/1     Running   0          3m49s   10.233.71.3      node3   <none>           <none>
```
