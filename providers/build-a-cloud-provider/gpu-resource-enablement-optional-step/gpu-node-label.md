# GPU Node Label

## Overview

Each node that provides GPUs must be labeled correctly.

> _**NOTE**_ - these configurations should be completed on a Kubernetes master/control plane node

## Label Template

* Use this label template in the `kubectl label` command in the subsequent Label Appliction sub-section below

> _**NOTE**_ - this section is information only.  The template displayed will be used in a subsequent sections.

```
akash.network/capabilities.gpu.vendor.<vendor name>.model.<model name>=true
```

### Label Application

#### Template

> _**NOTE**_ - if you are unsure of the `<node-name>` to be used in this command - issue `kubectl get nodes` from one of your Kubernetes control plane nodes to obtain via the `NAME` column of this command output

```
kubectl label node <node-name> <label>
```

#### Example

> _**NOTE**_ - issue this command/label application for all nodes hosting GPU resources

```
kubectl label node node1 akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true
```

#### Expected Output using Example

```
root@node1:~/provider# kubectl label node node1 akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true

node/node1 labeled
```

### Verification of Node Labels

* Replace `<node-name>` with the node of interest

```
kubectl describe node <node-name> | grep -A10 Labels
```

#### Expected Output using Example

```
kubectl describe node node2 | grep -A10 Labels

Labels:             akash.network/capabilities.gpu.vendor.nvidia.model.a4000=true
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node2
                    kubernetes.io/os=linux
```
