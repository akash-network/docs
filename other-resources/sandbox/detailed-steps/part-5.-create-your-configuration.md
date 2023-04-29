# Create your Configuration

Create a deployment configuration [deploy.yaml](https://github.com/ovrclk/docs/tree/b65f668b212ad1976fb976ad84a9104a9af29770/guides/deploy/deploy.yml) to deploy the `ovrclk/lunie-light` for [Lunie Light](https://github.com/ovrclk/lunie-light) Node app container using [SDL](https://github.com/ovrclk/docs/tree/b65f668b212ad1976fb976ad84a9104a9af29770/sdl/README.md).

### Modify your Configuration

You may use the sample deployment file as-is or modify it for your own needs as described in our [SDL (Stack Definition Language)](https://github.com/ovrclk/docs/blob/master/sdl/README.md) documentation. A typical modification would be to reference your own image instead of our demo app image.

#### EXAMPLE CONFIGURATION:

```bash
cat > deploy.yml <<EOF
---
version: "2.0"

services:
  web:
    image: ovrclk/lunie-light
    expose:
      - port: 3000
        as: 80
        to:
          - global: true

profiles:
  compute:
    web:
      resources:
        cpu:
          units: 0.1
        memory:
          size: 512Mi
        storage:
          size: 512Mi
  placement:
    westcoast:
      pricing:
        web: 
          denom: uakt
          amount: 10000

deployment:
  web:
    westcoast:
      profile: web
      count: 1

EOF
```
