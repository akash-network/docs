# Install Let's Encrypt Cert Manager

## Steps to Install the Let's Encrypt Cert Manager

> _**NOTE**_ - perform the steps in this guide on an Akash control plane node with Helm installed

### Add the Let's Encrypt Helm Repo

```
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

### Install the Let's Encrypt Helm Chart

```
###kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  --set installCRDs=true
```

### Verify the Let's Encrypt Cert Manager Install

```
kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges -A
```
