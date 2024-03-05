# Apply NVIDIA Runtime Engine

## Create RuntimeClass

> _**NOTE**_ - conduct these steps on the control plane node that Helm was installed on via the previous step

#### Create the NVIDIA Runtime Config

```
cat > nvidia-runtime-class.yaml << EOF
kind: RuntimeClass
apiVersion: node.k8s.io/v1
metadata:
  name: nvidia
handler: nvidia
EOF
```

#### Apply the NVIDIA Runtime Config

```
kubectl apply -f nvidia-runtime-class.yaml
```

## Upgrade/Install the NVIDIA Device Plug In Via Helm - GPUs on All Nodes

> _**NOTE**_ - in some scenarios a provider may host GPUs only on a subset of Kubernetes worker nodes.  Use the instructions in this section if ALL Kubernetes worker nodes have available GPU resources.  If only a subset of worker nodes host GPU resources - use the section `Upgrade/Install the NVIDIA Device Plug In Via Helm - GPUs on Subset of Nodes` instead.  Only one of these two sections should be completed.

<pre><code>helm repo add nvdp https://nvidia.github.io/k8s-device-plugin

helm repo update
<strong>
</strong><strong>helm upgrade -i nvdp nvdp/nvidia-device-plugin \
</strong>  --namespace nvidia-device-plugin \
  --create-namespace \
  --version 0.14.5 \
  --set runtimeClassName="nvidia" \
  --set deviceListStrategy=volume-mounts
</code></pre>

#### Expected/Example Output

```
root@ip-172-31-8-172:~# helm upgrade -i nvdp nvdp/nvidia-device-plugin \
  --namespace nvidia-device-plugin \
  --create-namespace \
  --version 0.14.5 \
  --set runtimeClassName="nvidia" \
  --set deviceListStrategy=volume-mounts
  
Release "nvdp" does not exist. Installing it now.
NAME: nvdp
LAST DEPLOYED: Thu Apr 13 19:11:28 2023
NAMESPACE: nvidia-device-plugin
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## Upgrade/Install the NVIDIA Device Plug In Via Helm - GPUs on Subset of Nodes

> _**NOTE**_ - use the instructions in this section if only a subset of Kubernetes worker nodes have available GPU resources.

* By default, the nvidia-device-plugin DaemonSet may run on all nodes in your Kubernetes cluster. If you want to restrict its deployment to only GPU-enabled nodes, you can leverage Kubernetes node labels and selectors.&#x20;
* Specifically, you can use the `allow-nvdp=true label` to limit where the DaemonSet is scheduled.

#### STEP 1: Label the GPU Nodes

* First, identify your GPU nodes and label them with `allow-nvdp=true`. You can do this by running the following command for each GPU node
* Replace `node-name` of the node you're labeling

> _**NOTE**_ - if you are unsure of the `<node-name>` to be used in this command - issue `kubectl get nodes` from one of your Kubernetes control plane nodes to obtain via the `NAME` column of this command output

```
kubectl label nodes <node-name> allow-nvdp=true
```

#### STEP 2: Update Helm Chart Values

* By setting the node selector, you are ensuring that the `nvidia-device-plugin` DaemonSet will only be scheduled on nodes with the `allow-nvdp=true` label.

```
helm repo add nvdp https://nvidia.github.io/k8s-device-plugin

helm repo update

helm upgrade -i nvdp nvdp/nvidia-device-plugin \
  --namespace nvidia-device-plugin \
  --create-namespace \
  --version 0.14.5 \
  --set runtimeClassName="nvidia" \
  --set deviceListStrategy=volume-mounts \
  --set-string nodeSelector.allow-nvdp="true"
```

#### &#x20;STEP 3: Verify

```
kubectl -n nvidia-device-plugin get pods -o wide
```

_**Expected/Example Output**_

* In this example only nodes: node1, node3 and node4 have the `allow-nvdp=true` labels and that's where `nvidia-device-plugin` pods spawned at:

```
root@node1:~# kubectl -n nvidia-device-plugin get pods -o wide

NAME                              READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
nvdp-nvidia-device-plugin-gqnm2   1/1     Running   0          11s   10.233.75.1   node2   <none>           <none>
```

## Verification - Applicable to all Environments

```
kubectl -n nvidia-device-plugin logs -l app.kubernetes.io/instance=nvdp
```

#### Example/Expected Output

```
 root@node1:~# kubectl -n nvidia-device-plugin logs -l app.kubernetes.io/instance=nvdp
  "sharing": {
    "timeSlicing": {}
  }
}
2023/04/14 14:18:27 Retreiving plugins.
2023/04/14 14:18:27 Detected NVML platform: found NVML library
2023/04/14 14:18:27 Detected non-Tegra platform: /sys/devices/soc0/family file not found
2023/04/14 14:18:27 Starting GRPC server for 'nvidia.com/gpu'
2023/04/14 14:18:27 Starting to serve 'nvidia.com/gpu' on /var/lib/kubelet/device-plugins/nvidia-gpu.sock
2023/04/14 14:18:27 Registered device plugin for 'nvidia.com/gpu' with Kubelet
  "sharing": {
    "timeSlicing": {}
  }
}
2023/04/14 14:18:29 Retreiving plugins.
2023/04/14 14:18:29 Detected NVML platform: found NVML library
2023/04/14 14:18:29 Detected non-Tegra platform: /sys/devices/soc0/family file not found
2023/04/14 14:18:29 Starting GRPC server for 'nvidia.com/gpu'
2023/04/14 14:18:29 Starting to serve 'nvidia.com/gpu' on /var/lib/kubelet/device-plugins/nvidia-gpu.sock
2023/04/14 14:18:29 Registered device plugin for 'nvidia.com/gpu' with Kubelet
```

## Test GPUs

> _**NOTE**_ - conduct the steps in this section on a Kubernetes control plane node

### Launch GPU Test Pod

#### Create the GPU Test Pod Config

```
cat > gpu-test-pod.yaml << EOF
apiVersion: v1
kind: Pod
metadata:
  name: gpu-pod
spec:
  restartPolicy: Never
  runtimeClassName: nvidia
  containers:
    - name: cuda-container
    # Nvidia cuda compatibility https://docs.nvidia.com/deploy/cuda-compatibility/
    # for nvidia 510 drivers
    ## image: nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda10.2
    # for nvidia 525 drivers use below image
      image: nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda11.6.0
      resources:
        limits:
          nvidia.com/gpu: 1 # requesting 1 GPU
  tolerations:
  - key: nvidia.com/gpu
    operator: Exists
    effect: NoSchedule
EOF
```

#### Apply the GPU Test Pod Config

```
kubectl apply -f gpu-test-pod.yaml
```

### Verification of GPU Pod

```
kubectl logs gpu-pod
```

#### Expected/Example Output

```
root@node1:~# kubectl logs gpu-pod
[Vector addition of 50000 elements]
Copy input data from the host memory to the CUDA device
CUDA kernel launch with 196 blocks of 256 threads
Copy output data from the CUDA device to the host memory
Test PASSED
Done
```
