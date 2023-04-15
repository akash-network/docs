# Ingress Controller Install

> _**NOTE**_ - all steps in this guide should be performed from a Kubernetes control plane node

## Build the Kubernetes Ingress Controller

```
helm install akash-ingress akash/akash-ingress -n ingress-nginx --set domain=$DOMAIN
```

#### Expected/Example Output

```
NAME: akash-ingress
LAST DEPLOYED: Thu Apr 28 19:08:45 2022
NAMESPACE: ingress-nginx
STATUS: deployed
REVISION: 1
TEST SUITE: None
```
