# Label Nodes For Storage Classes

Each node serving persistent storage should have `akash.network/storageclasses` label set.&#x20;

The labels allow different nodes to serve different storage classes.

In our example with a single node serving persistent storage with the storage class of beta2, the following label syntax would be applied.

```
kubectl label node <node-name> akash.network/storageclasses=<beta1|beta2|beta3> --overwrite
```
