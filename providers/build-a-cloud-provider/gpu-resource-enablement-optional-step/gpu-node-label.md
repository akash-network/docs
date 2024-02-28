# GPU Node Label

### Overview

In this section we verify that necessary Kubernetes node labels have been applied for your GPUs.  The labeling of nodes is an automated process and here we only verify proper labels have been applied.

### Verification of Node Labels

* Replace `<node-name>` with the node of interest

```
kubectl describe node <node-name> | grep -A10 Labels
```

#### Expected Output using Example

* Note the presence of the GPU model, interface, and ram expected values.

```
root@node1:~# kubectl describe node node2 | grep -A10 Labels
Labels:             akash.network=true
                    akash.network/capabilities.gpu.vendor.nvidia.model.t4=1
                    akash.network/capabilities.gpu.vendor.nvidia.model.t4.interface.PCIe=1
                    akash.network/capabilities.gpu.vendor.nvidia.model.t4.ram.16Gi=1
                    akash.network/capabilities.storage.class.beta2=1
                    akash.network/capabilities.storage.class.default=1
                    allow-nvdp=true
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node2
```
