# Akash SDL Hello World Example

## Overview

* Use the example Akash SDL below for our Terraform demonstration
* Create a file named `deploy.yaml` with the Terraform project direct created prior
* Copy the contents of the `Hello World SDL` below into the `deploy.yaml` file

### Hello World SDL

```
---
version: "2.0"

services:
  website:
    image: nginxdemos/hello
    expose:
      - port: 80
        http_options:
          max_body_size: 104857600
        to:
          - global: true
profiles:
  compute:
    website:
      resources:
        cpu:
          units: 1.0
        memory:
          size: 512Mi
        storage:
          size: 512Mi
  placement:
    akash:
      attributes:
        host: akash
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
          - "akash18qa2a2ltfyvkyj0ggj3hkvuj6twzyumuaru9s4"
      pricing:
        website:
          denom: uakt
          amount: 10000
deployment:
  website:
    akash:
      profile: website
      count: 1
```
