# Create your Configuration

Create a deployment configuration `deploy.yml` to deploy an example GPU enabled workload via the steps and SDL provided in this section.

### Akash GPU Enabled Manifest/SDL

You may use the sample deployment file as-is or modify it for your own needs as described in our [SDL (Stack Definition Language)](https://github.com/ovrclk/docs/blob/master/sdl/README.md) documentation.

#### EXAMPLE GPU ENABLED SDL:

```bash
cat > deploy.yml <<EOF
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
          attributes:
            vendor:
              nvidia:
                - model: a4000
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
EOF
```
