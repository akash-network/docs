# AMD GPU Support Documentation

## Introduction

Welcome to the specialized guide designed to assist Akash Providers in enabling AMD GPU support within their Kubernetes clusters. This documentation is particularly crafted for system administrators, developers, and DevOps professionals who manage and operate their Akash Providers. The focus here is to guide you through the process of integrating AMD GPUs into your Kubernetes/Akash setup, ensuring that they can be utilized in the Akash Network.

Throughout this guide, you will find step-by-step instructions on installing the necessary AMD drivers, configuring Kubernetes to acknowledge and leverage AMD GPUs.

This documentation is vital for Akash Providers and Clients who aim to deploy advanced workloads such as machine learning models, high-performance computing tasks, or any applications that benefit from GPU acceleration. By following this guide, you will be able to enhance your service offerings on the Akash Network, catering to a wider range of computational needs with AMD GPU support.

> **NOTE**: To effectively enable AMD GPU support, ensure that your `akash-provider` and `provider-services` (CLI) are updated to version `0.4.9-rc0` or higher. This is a prerequisite for proper integration and functionality of AMD GPUs on your Akash Provider.

## Limitations

Current constraints dictate that combining NVIDIA and AMD GPU vendors within the same Kubernetes worker node is not allowed. However, it is permissible to have different GPU vendors within the same Kubernetes cluster, as long as each individual worker node exclusively uses GPUs from a single vendor, be it NVIDIA or AMD.

- **Vendor Constraint:** Combining NVIDIA and AMD GPUs within the same Kubernetes worker node is not permitted.
- **Vendor Homogeneity:** It is permissible to mix different GPU vendors on the same Kubernetes cluster. However, this mixing is not allowed within a single worker node.
- **Vendor Exclusivity:** Each worker node must exclusively use GPUs from a single vendor, either NVIDIA or AMD. This means a single node cannot have a mix of NVIDIA and AMD GPUs, but different nodes within the same cluster can use different vendors.

## Installing the AMD Driver and ROCM

Follow these steps to install the AMD driver and ROCM:

1. Update package lists:
    ```bash
    apt update
    ```

2. Download the AMD GPU installation package:
    ```bash
    wget -c https://repo.radeon.com/amdgpu-install/5.7.1/ubuntu/jammy/amdgpu-install_5.7.50701-1_all.deb
    ```

3. Install the downloaded package:
    ```bash
    apt install -y ./amdgpu-install_5.7.50701-1_all.deb
    ```

4. Install ROCM:
    ```bash
    amdgpu-install -y --usecase=rocm
    ```

5. Install the required package for running rccl-test:
    ```bash
    apt install -y libstdc++-12-dev
    ```

## Enabling AMD GPU Support in Akash Provider

### 1. Install `RadeonOpenCompute/k8s-device-plugin` helm-chart

- Add the helm repository and install the chart:
    ```bash
    helm repo add amd-gpu-helm https://radeonopencompute.github.io/k8s-device-plugin/
    helm install --create-namespace --namespace amd-device-plugin --set namespace=amd-device-plugin amd-gpu amd-gpu-helm/amd-gpu --version 0.12.0
    ```

- Verify the installation:
    > NOTE: replace `node1` with the node name of your worker node (`kubectl get nodes`)
    ```bash
    kubectl -n amd-device-plugin logs ds/amd-gpu-device-plugin-daemonset
    kubectl describe node node1 | grep -B1 -Ei 'nvidia.com/gpu|amd.com/gpu'
    ```

- Example output:
    ```bash
    # kubectl -n amd-device-plugin logs ds/amd-gpu-device-plugin-daemonset
    I1222 11:59:36.830615       1 main.go:305] AMD GPU device plugin for Kubernetes
    I1222 11:59:36.830754       1 main.go:305] ./k8s-device-plugin version v1.18.1-27-g5eb0a0f
    I1222 11:59:36.830762       1 main.go:305] hwloc: _VERSION: 2.9.2, _API_VERSION: 0x00020800, _COMPONENT_ABI: 7, Runtime: 0x00020800
    I1222 11:59:36.830777       1 manager.go:42] Starting device plugin manager
    ...
    I1222 11:59:46.834386       1 plugin.go:128] gpu: Registering the DPI with Kubelet
    I1222 11:59:46.835364       1 plugin.go:140] gpu: Registration for endpoint amd.com_gpu
    I1222 11:59:46.840807       1 amdgpu.go:100] /sys/module/amdgpu/drivers/pci:amdgpu/0000:1b:00.0
    I1222 11:59:46.921498       1 main.go:149] Watching GPU with bus ID: 0000:1b:00.0 NUMA Node: [0]

    # kubectl describe node node1 | grep -B1 -Ei 'nvidia.com/gpu|amd.com/gpu'
    Capacity:
      amd.com/gpu:        1
    --
    Allocatable:
      amd.com/gpu:        1
    --
      hugepages-2Mi      0 (0%)         0 (0%)
      amd.com/gpu        1              1
    ```

### 2. Label AMD GPU Node

- Label your AMD GPU node (replace `mi210` with your AMD GPU model):
    ```bash
    kubectl label node node1 akash.network/capabilities.gpu.vendor.amd.model.mi210=true
    ```

### 3. Test AMD GPU with TensorFlow in Pod

Before proceeding with the deployment, be aware of the following:

> **NOTE:** Starting the `alexnet-gpu` may take a considerable amount of time, especially over slow network connections. This delay is due to the large size of the image, approximately `10 GiB`, as detailed on [Docker Hub](https://hub.docker.com/r/rocm/tensorflow/tags).

To deploy and test the TensorFlow environment on AMD GPUs, follow these steps:

1. Create the pod using the provided YAML file:
    ```bash
    kubectl create -f https://raw.githubusercontent.com/RadeonOpenCompute/k8s-device-plugin/master/example/pod/alexnet-gpu.yaml
    ```

2. Check the logs to verify successful deployment and operation:
    ```bash
    kubectl logs alexnet-tf-gpu-pod
    # Expected output includes:
    # TensorFlow version information, list of devices (e.g., '/gpu:0'), and performance metrics (e.g., total images/sec).
    ```
    Example output:
    ```
    $ kubectl logs alexnet-tf-gpu-pod
    TensorFlow:  2.13
    ...
    Devices:     ['/gpu:0']
    ...
    total images/sec: 5876.64
    ```

3. Once testing is complete, delete the pod:
    ```bash
    kubectl delete pod alexnet-tf-gpu-pod
    ```

## Update bid pricing parameters for your AMD GPU card

Make sure you are using the latest bid pricing script. You can follow [these](https://docs.akash.network/providers/akash-provider-troubleshooting/provider-bid-script-migration-gpu-models) instructions.

- Add the pricing for your AMD GPU model (replace `mi210` with your model) to `provider.yaml` file:
    ```yaml
    price_target_gpu_mappings: "mi210=190,*=200"
    ```

This sets `$190`/month for AMD GPU MI 210 card and defaults to `$200`/month when the GPU model was [not](https://github.com/akash-network/support/issues/166) explicitly set.

## Testing AMD GPU with TensorFlow in Akash Deployment

To test TensorFlow with AMD GPU in Akash Deployment:

- Base your deployment on the image & command/args from the provided YAML file.
- Use image: `rocm/tensorflow`.
- Override the `command` & `args` in the SDL.
- Execute the benchmarking command:
    ```bash
    python3 benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model=alexnet
    ```

### Example SDL

Use the following SDL configuration to deploy `rocm/tensorflow` image:

> Make sure to replace `SSH_PUBKEY` with your public SSH key should you want to be able ssh to your deployment instead of `lease-shell` into it.

```yaml
---
version: "2.0"

services:
  app:
    image: rocm/tensorflow:latest
    env:
      - 'SSH_PUBKEY=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNFxqDbY0BlEjJ2y9B2IKUUoimOq6oAC7WcsQT8qmII andy'
    command:
      - "sh"
      - "-c"
    args:
      - 'apt-get update;
      apt-get install -y --no-install-recommends -- ssh speedtest-cli netcat-openbsd curl wget ca-certificates jq less iproute2 iputils-ping vim bind9-dnsutils nginx;
      mkdir -p -m0755 /run/sshd;
      mkdir -m700 ~/.ssh;
      echo "$SSH_PUBKEY" | tee ~/.ssh/authorized_keys;
      chmod 0600 ~/.ssh/authorized_keys;
      ls -lad ~ ~/.ssh ~/.ssh/authorized_keys;
      md5sum ~/.ssh/authorized_keys;
      exec /usr/sbin/sshd -D'
    expose:
      - port: 80
        as: 80
        to:
          - global: true
      - port: 22
        as: 22
        to:
          - global: true


profiles:
  compute:
    app:
      resources:
        cpu:
          units: 2
        memory:
          size: 8Gi
        storage:
          size: 25Gi
        gpu:
          units: 1
          attributes:
            vendor:
              amd:
                - model: mi210
  placement:
    akash:
      attributes:
        host: akash
      pricing:
        app:
          denom: uakt
          amount: 1000000

deployment:
  app:
    akash:
      profile: app
      count: 1
```

## Additional material

- Exploring Integration of `rocm-smi` in AMD GPU Pods for Enhanced Compatibility

We are [exploring](https://github.com/ROCm/k8s-device-plugin/issues/44) the possibility of including the `rocm-smi` tool by default in AMD GPU Pods, analogous to how `nvidia-smi` is available in NVIDIA GPU Pods. This inclusion in NVIDIA pods is facilitated by the NVIDIA device plugin, which mounts necessary host paths and utilizes environment variables like `NVIDIA_DRIVER_CAPABILITIES`. For more detailed examples and information, refer to the NVIDIA Container Toolkit documentation [here](https://github.com/NVIDIA/nvidia-container-toolkit/blob/a2262d00cc6d98ac2e95ae2f439e699a7d64dc17/cmd/nvidia-container-runtime/README.md?plain=1#L147-L161). Our goal is to achieve similar functionality for AMD GPUs, enhancing user experience.
