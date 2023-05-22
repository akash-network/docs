# STEP 9 - Ingress Controller Install

## Create Upstream Ingress-Nginx Config

Create the `ingress-nginx-custom.yaml` file via this step

> _**NOTE**_ - in the default install the dedicated Akash RPC Node used for your provider is reachable only within the Kubernetes cluster.  This is done intentionally as this RPC Node is intended for use only by the Akash Provider only.  The Provider will have access within the cluster to the RPC Node.  This additionally protects the RPC Node from possible DDoS attacks from external parties.   If have a need to expose the Provider's RPC Node to the outside world, use the `ingress-nginx-custom.yaml` file included in this [section](step-8-ingress-controller-install.md#expose-rpc-node-to-outside-world) instead.

```
cd ~

cat > ingress-nginx-custom.yaml << EOF
controller:
  service:
    type: ClusterIP
  ingressClassResource:
    name: "akash-ingress-class"
  kind: DaemonSet
  hostPort:
    enabled: true
  admissionWebhooks:
    port: 7443
  config:
    allow-snippet-annotations: false
    enable-real-ip: true
    proxy-buffer-size: "16k"
  metrics:
    enabled: true
  extraArgs:
    enable-ssl-passthrough: true
tcp:
  "8443": "akash-services/akash-provider:8443"
EOF
```

#### Expose RPC Node to Outside World

Use this step only if you choose to expose your Akash Provider RPC Node to the outside world

```
cd ~

cat > ingress-nginx-custom.yaml << EOF
controller:
  service:
    type: ClusterIP
  ingressClassResource:
    name: "akash-ingress-class"
  kind: DaemonSet
  hostPort:
    enabled: true
  admissionWebhooks:
    port: 7443
  config:
    allow-snippet-annotations: false
    enable-real-ip: true
    proxy-buffer-size: "16k"
  metrics:
    enabled: true
  extraArgs:
    enable-ssl-passthrough: true
tcp:
  "1317": "akash-services/akash-node-1:1317"
  "8443": "akash-services/akash-provider:8443"
  "9090":  "akash-services/akash-node-1:9090"
  "26656": "akash-services/akash-node-1:26656"
  "26657": "akash-services/akash-node-1:26657"
EOF
```

## Install Upstream Ingress-Nginx

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --version 4.6.0 \
  --namespace ingress-nginx --create-namespace \
  -f ingress-nginx-custom.yaml
```

## Apply Necessary Labels

* Label the `ingress-nginx` namespace and the `akash-ingress-class` ingressclass

```
kubectl label ns ingress-nginx app.kubernetes.io/name=ingress-nginx app.kubernetes.io/instance=ingress-nginx

kubectl label ingressclass akash-ingress-class akash.network=true
```

