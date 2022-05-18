# Label Nodes For Storage Classes

Each node serving persistent storage should have `akash.network/storageclasses` label set.&#x20;

The labels allow different nodes to serve different storage classes.

* Ensure that this command is issued - one at a time - for all nodes serving persistent storage
* Replace the `storageclasses` value with the proper storage class and as clarified in the example command

```
kubectl label node <node-name> akash.network/storageclasses=<beta1|beta2|beta3> --overwrite
```

#### Example Label Command

*   In our example with a single node serving persistent storage with the storage class of beta2, the following label syntax would be applied.

    ```
    kubectl label node node2 akash.network/storageclasses=beta2 --overwrite
    ```
