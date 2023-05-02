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
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  --set installCRDs=true
```

#### Expected/Example Output

```
NAME: cert-manager
LAST DEPLOYED: Tue May  2 13:56:12 2023
NAMESPACE: cert-manager
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
cert-manager v1.11.0 has been deployed successfully!

In order to begin issuing certificates, you will need to set up a ClusterIssuer
or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

More information on the different types of issuers and how to configure them
can be found in our documentation:

https://cert-manager.io/docs/configuration/

For information on how to configure cert-manager to automatically provision
Certificates for Ingress resources, take a look at the `ingress-shim`
documentation:

https://cert-manager.io/docs/usage/ingress/
```
