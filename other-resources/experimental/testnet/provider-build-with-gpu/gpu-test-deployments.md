# GPU Test Deployments

## Overview

Test your provider's ability to host GPU related deployments via the SDLs provided in this section.

## Example GPU SDL #1

```
---
version: "2.0"

services:
  gpu-test:
    # Nvidia cuda compatibility https://docs.nvidia.com/deploy/cuda-compatibility/
    # for nvidia 510 drivers
    ## image: nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda10.2
    # for nvidia 525 drivers use below image
    image: nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda11.6.0
    command:
      - "sh"
      - "-c"
    args:
      - 'sleep infinity'
    expose:
      - port: 3000
        as: 80
        to:
          - global: true
profiles:
  compute:
    gpu-test:
      resources:
        cpu:
          units: 1
        memory:
          size: 1Gi
        gpu:
          units: 1
        storage:
          - size: 512Mi
  placement:
    westcoast:
      pricing:
        gpu-test:
          denom: uakt
          amount: 100000
deployment:
  gpu-test:
    westcoast:
      profile: gpu-test
      count: 1
```

### Testing of Deployment/GPU Example #1

Conduct the following tests from the deployment's shell.

#### Test 1

```
/tmp/sample
```

#### Expected/Example Output

```
root@gpu-test-6d4f545b6f-f95zk:/# /tmp/sample

[Vector addition of 50000 elements]
Copy input data from the host memory to the CUDA device
CUDA kernel launch with 196 blocks of 256 threads
Copy output data from the CUDA device to the host memory
Test PASSED
Done
```

#### Test 2

```
nvidia-smi
```

#### Expected/Example Output

```
root@gpu-test-6d4f545b6f-f95zk:/# nvidia-smi 

Fri Apr 14 09:23:33 2023       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 525.85.12    Driver Version: 525.85.12    CUDA Version: 12.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA RTX A4000    Off  | 00000000:05:00.0 Off |                  Off |
| 41%   44C    P8    13W / 140W |      0MiB / 16376MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
root@gpu-test-6d4f545b6f-f95zk:/# 
```

## Example GPU SDL #2

> _**NOTE**_ - the CUDA version necessary for this image is `11.7` currently.  Check the image documentation page [here](https://github.com/fboulnois/stable-diffusion-docker/pkgs/container/stable-diffusion-docker) for possible updates.

```
---
version: "2.0"

services:
  gpu-test:
    image: ghcr.io/fboulnois/stable-diffusion-docker
    expose:
      - port: 3000
        as: 80
        to:
          - global: true
    cmd:
      - run
    args:
      - 'An impressionist painting of a parakeet eating spaghetti in the desert'
      - --attention-slicing
      - --xformers-memory-efficient-attention
profiles:
  compute:
    gpu-test:
      resources:
        cpu:
          units: 1
        memory:
          size: 20Gi
        gpu:
          units: 2
        storage:
          - size: 100Gi
  placement:
    westcoast:
      pricing:
        gpu-test:
          denom: uakt
          amount: 100000
deployment:
  gpu-test:
    westcoast:
      profile: gpu-test
      count: 1
```
