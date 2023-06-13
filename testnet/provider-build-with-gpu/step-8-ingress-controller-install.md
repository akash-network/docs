# Ingress Controller Install

## Create Upstream Ingress-Nginx Config

* Create an `ingress-nginx-custom.yaml` file with the following contents:

```
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
