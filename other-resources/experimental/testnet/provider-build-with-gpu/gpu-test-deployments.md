# GPU Test Deployments

## Overview

Test your provider's ability to host GPU related deployments via the SDL provided in this section.

## Example GPU SDL #1

### SDL

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
        accept:
          - webdistest.localhost
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
