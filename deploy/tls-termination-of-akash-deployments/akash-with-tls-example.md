# Akash with TLS Example

An example Akash deployment with TLS step by step example.  We will use Ghost, a very simple web app, for the demo.

### **Deploy Ghost**

Make sure to specify the hostname you control, in this example it is “ghost.akash.pro”. Set the “https” when setting the “url” environment variable – this will get picked by the Ghost blogging platform so it knows to serve these HTTPS links.

When you deploy with 80/tcp port exposed in Akash, the nginx-ingress-controller on the provider will automatically get 443/tcp exposed too. This makes Full TLS termination possible.

If you are not familiar with Akash deployments, visit the documentation for the desktop app [Cloudmos Deploy](https://docs.akash.network/guides/deploy) as an easy way to get started.

```
---
version: "2.0"

services:
  ghost:
    image: ghost:4.36.3-alpine
    env:
      - 'url=https://ghost.akash.pro'
    expose:
      - port: 2368
        as: 80
        accept:
          - "ghost.akash.pro"
        to:
          - global: true

profiles:
  compute:
    ghost:
      resources:
        cpu:
          units: 1.0
        memory:
          size: 512Mi
        storage:
          size: 512Mi
  placement:
    akash:
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      pricing:
        ghost:
          denom: uakt
          amount: 100

deployment:
  ghost:
    akash:
      profile: ghost
      count: 1
```
