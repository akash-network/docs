# Wildcard Certificate Request

## Request the Wildcard Certificate for your Domain

> _**NOTE**_ - replace the domain bits with yours accordingly.  Leave the \*.ingress. bit (or adjust to the one you are using for the ingress address deployments receive) since wildcards aren't working for sub-sub domain (RFC 2818).

> _**NOTE**_ - this step should be performed on one of the Kubernetes control plane nodes of your Akash Provider

#### Create the Wildcard Cert Config

```
cat > wildcard-cert-request.yaml << EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: wildcard-yourdomain-com
  namespace: ingress-nginx
spec:
  secretName: wildcard-yourdomain-com-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  commonName: '*.yourdomain.com'
  dnsNames:
  - '*.yourdomain.com'
  - '*.ingress.yourdomain.com'
EOF
```

#### Apply the Wildcard Cert Config

```
kubectl apply -f wildcard-cert-request.yaml
```

## Additional Detail

Additional notes on the wildcard certifcate request from Let's Encrypt can be found [here](https://letsencrypt.org/docs/faq/#does-let-s-encrypt-issue-wildcard-certificates).
