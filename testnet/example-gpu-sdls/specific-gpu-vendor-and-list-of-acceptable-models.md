# Specific GPU Vendor & List of Acceptable Models

## Overview

In the example SDL provided below the following request is made:

* GPU Quantity: 1
* GPU Vendor: NVIDIA
* GPU Model: T4 or A4000

Based on these inclusions in the SDL - only providers that have NVIDIA T4 OR A4000 chips will respond with a bid.  The purpose of this SDL use would be in scenario in which specific models of GPU are necessary but there are multiple, acceptable models.&#x20;

&#x20;In this example we specific that providers with NVIDIA T4 or A4000 models should bid on the deployment.  But it is possible to list many different models if desired.

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
                - model: t4
                - model: a4000
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
* We can use these logs to determine the success of the deployment and confirm that the selected GPU model/type was allocated

<figure><img src="../../.gitbook/assets/gpuCheck.png" alt=""><figcaption></figcaption></figure>
