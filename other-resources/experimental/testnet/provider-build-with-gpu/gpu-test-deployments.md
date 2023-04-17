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
    # for nvidia 525 drivers
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

## Example GPU SDL #2

```
---
version: "2.0"

services:
  gpu-test:
    image: ghcr.io/akash-network/stable-diffusion-docker
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
