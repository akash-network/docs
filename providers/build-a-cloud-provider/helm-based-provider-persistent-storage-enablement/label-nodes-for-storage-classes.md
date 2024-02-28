# Verify Node Labels For Storage Classes

## Overview

Each node serving persistent storage should have `akash.network/storageclasses` label set.  These labels are automatically applied and this section we will verify proper labeling.

> _**NOTE**_ - currently the Helm Charts for persistent storage support only a single storageclass per cluster.  All nodes in the cluster should be marked as `beta2` - as an example - and cannot have a mix of `beta2` and `beta3` nodes.



## Node Label Verification

### Verification Template

* Replace `<node-name>` with actual node name as gathered via `kubectl get nodes`

```
kubectl describe node <node-name> | grep -A10 Labels
```

### Example/Expected Output

```
root@node1:~# kubectl describe node node2 | grep -A10 Labels
Labels:             akash.network=true
                    akash.network/capabilities.storage.class.beta2=1
                    akash.network/capabilities.storage.class.default=1
                    allow-nvdp=true
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node2
```

