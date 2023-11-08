# GPU Provider Troubleshooting

## Overview

Should your Akash Provider encounter issues during the installation process or in post install hosting of GPU resources, follow the troubleshooting steps in this guide to isolate the issue.

> _**NOTE**_ - these steps should be conducted on each Akask Provider/Kubernetes worker nodes that host GPU resources unless stated otherwise within the step

* [Basic GPU Resource Verifications](gpu-provider-troubleshooting.md#basic-gpu-resource-verifications)
* [Examine Linux Kernel Logs for GPU Resource Errors and Mismatches](gpu-provider-troubleshooting.md#examine-linux-kernel-logs-for-gpu-resource-errors-and-mismatches)
* [Ensure Correct Version/Presence of NVIDIA Device Plugin](gpu-provider-troubleshooting.md#ensure-correct-version-presence-of-nvidia-device-plugin)
* [CUDA Drivers Fabric Manager](gpu-provider-troubleshooting.md#cuda-drivers-fabric-manager)

## Basic GPU Resource Verifications

* Conduct the steps in this section for basic verification and to ensure the host has access to GPU resources

### Prep/Package Installs

```
apt update && apt -y install python3-venv

python3 -m venv /venv
source /venv/bin/activate
pip install torch
```

### Confirm GPU Resources Available on Host

> _**NOTE**_ - example verification steps were conducted on a host with a single NVIDIA T4 GPU resource.  Your output will be different based on the type and number of GPU resources on the host.

```
nvidia-smi -L
```

#### Example/Expected Output

```
# nvidia-smi -L

GPU 0: Tesla T4 (UUID: GPU-faa48437-7587-4bc1-c772-8bd099dba462)
```

### Confirm CUDA Install & Version

```
python3 -c "import torch;print(torch.version.cuda)"
```

#### Example/Expected Output

```
# python3 -c "import torch;print(torch.version.cuda)"

11.7
```

### Confirm CUDA GPU Support iis Available for Hosted GPU Resources

```
python3 -c "import torch; print(torch.cuda.is_available())"
```

#### Example/Expected Output

```
# python3 -c "import torch; print(torch.cuda.is_available())"

True
```

## Examine Linux Kernel Logs for GPU Resource Errors and Mismatches

```
dmesg -T | grep -Ei 'nvidia|nvml|cuda|mismatch'
```

#### Example/Expected Output

> _**NOTE**_ - example output is from a healthy host which loaded NVIDIA drivers successfully and has no version mismatches.  Your output may look very different if there are issues within the host.

```
# dmesg -T | grep -Ei 'nvidia|nvml|cuda|mismatch'

[Thu Sep 28 19:29:02 2023] nvidia: loading out-of-tree module taints kernel.
[Thu Sep 28 19:29:02 2023] nvidia: module license 'NVIDIA' taints kernel.
[Thu Sep 28 19:29:02 2023] nvidia-nvlink: Nvlink Core is being initialized, major device number 237
[Thu Sep 28 19:29:02 2023] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  535.104.05  Sat Aug 19 01:15:15 UTC 2023
[Thu Sep 28 19:29:02 2023] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  535.104.05  Sat Aug 19 00:59:57 UTC 2023
[Thu Sep 28 19:29:02 2023] [drm] [nvidia-drm] [GPU ID 0x00000004] Loading driver
[Thu Sep 28 19:29:03 2023] audit: type=1400 audit(1695929343.571:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=300 comm="apparmor_parser"
[Thu Sep 28 19:29:03 2023] audit: type=1400 audit(1695929343.571:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=300 comm="apparmor_parser"
[Thu Sep 28 19:29:04 2023] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:00:04.0 on minor 0
[Thu Sep 28 19:29:05 2023] nvidia_uvm: module uses symbols nvUvmInterfaceDisableAccessCntr from proprietary module nvidia, inheriting taint.
[Thu Sep 28 19:29:05 2023] nvidia-uvm: Loaded the UVM driver, major device number 235.
```

## Ensure Correct Version/Presence of NVIDIA Device Plugin

> _**NOTE**_ - conduct this verification step on the Kubernetes control plane node on which Helm was installed during your Akash Provider build

```
helm -n nvidia-device-plugin list
```

#### Example/Expected Output

```
# helm -n nvidia-device-plugin list

NAME    NAMESPACE               REVISION    UPDATED                                    STATUS      CHART                          APP VERSION
nvdp    nvidia-device-plugin    1           2023-09-23 14:30:34.18183027 +0200 CEST    deployed    nvidia-device-plugin-0.14.1    0.14.1 
```

## CUDA Drivers Fabric Manager

* In rare circumstances it has been found that the CUDA Drivers Fabric Manager needs to be installed on worker nodes hosting GPU resources
* If the output of the `torch.cuda.is_available()` command - covered in prior section in this doc - is an error condition, consider installing the CUDA Drivers Fabric Manager to resolve issue
* Frequently encountered error message encounter when issue exists:\
  \
  `torch.cuda.is_available() function: Error 802: system not yet initialized (Triggered internally at ../c10/cuda/CUDAFunctions.cpp:109.)`
* Further details on the CUDA Drivers Fabric Manager are available [here](https://forums.developer.nvidia.com/t/error-802-system-not-yet-initialized-cuda-11-3/234955)

> _**NOTE**_ - replace `525` in the following command with the NVIDIA driver version used on your host

```
apt-get install cuda-drivers-fabricmanager-525
```
