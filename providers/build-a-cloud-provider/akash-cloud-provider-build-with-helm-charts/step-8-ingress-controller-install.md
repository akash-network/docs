# STEP 7 - Ingress Controller Install

*   Build the Kubernetes ingress controller

    ```
    helm install akash-ingress ovrclk/akash-ingress -n ingress-nginx --set domain=$DOMAIN
    ```

#### Expected Output

```
NAME: akash-ingress
LAST DEPLOYED: Thu Apr 28 19:08:45 2022
NAMESPACE: ingress-nginx
STATUS: deployed
REVISION: 1
TEST SUITE: None
```
