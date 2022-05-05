# Retrieve Nodes

Gather the Kubernetes names of all nodes within your cluster.  We will use the node names in a subsequent step.

```
kubectl get nodes -ojson | jq -r '.items[].metadata.labels."kubernetes.io/hostname"'
```

#### **Example Output**

```
root@node1:~/akash# kubectl get nodes -ojson | jq -r '.items[].metadata.labels."kubernetes.io/hostname"'

node1
node2
```
