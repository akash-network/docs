# Specific GPU Vendor

## Overview

In the example SDL provided below the following request is made:

* GPU Quantity: 1
* GPU Vendor: NVIDIA

Based on these inclusions in the SDL - only providers that have NVIDIA chips will respond with a bid.

> _**NOTE**_ - using this SDL example no specific GPU model/type (I.e. NVIDIA A100) is specified.  Based on this syntax any provider with a NVIDIA GPU will respond with a bid.  If a specific GPU model/type is needed - use the SDL example [here](specific-gpu-vendor-and-model.md).

## SDL Example

```
---
version: "2.0"

services:
  obtaingpu:
    image: ubuntu:22.04
    command:
      - "sh"
      - "-c"
    args:
      - 'uptime;
        nvidia-smi;
        sleep infinity'
    expose:
      - port: 8080
        as: 80
        to:
          - global: true

profiles:
  compute:
    obtaingpu:
      resources:
        cpu:
          units: 1.0
        memory:
          size: 1Gi
        gpu:
          units: 1
          attributes:
            vendor:
              nvidia:
        storage:
          size: 1Gi
  placement:
    akash:
      pricing:
        obtaingpu: 
          denom: uakt
          amount: 100000

deployment:
  obtaingpu:
    akash:
      profile: obtaingpu
      count: 1

```

## Confirmation

* The SDL used in the provided example prints the GPU Model/Chip Type to the logs as depicted below
* We can use these logs to determine the success of the deployment

<figure><img src="../../.gitbook/assets/gpuCheck.png" alt=""><figcaption></figcaption></figure>
