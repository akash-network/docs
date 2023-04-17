# Ingress Controller Install

> _**NOTE**_ - all steps in this guide should be performed from a Kubernetes control plane node

## Build the Kubernetes Ingress Controller

```
helm install akash-ingress akash/akash-ingress -n ingress-nginx --set domain=$DOMAIN
```

#### Expected/Example Output

<pre><code>root@node1:~# helm install akash-ingress akash/akash-ingress -n ingress-nginx --set domain=$DOMAIN --set chainid=testnet-02 --set image.tag=0.3.0-rc6
<strong>
</strong><strong>NAME: akash-ingress
</strong>LAST DEPLOYED: Mon Apr 17 13:06:20 2023
NAMESPACE: ingress-nginx
STATUS: deployed
REVISION: 1
TEST SUITE: None
</code></pre>
