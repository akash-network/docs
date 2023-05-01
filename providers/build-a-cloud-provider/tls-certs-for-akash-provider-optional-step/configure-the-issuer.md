# Configure the Issuer

## Initial Cert Manager Configuration

> _**NOTE**_ -  If you want to use the namespaces then configure Issuer instead of the ClusterIssuer.

```
kubectl apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: youremail@xyz.com
    #server: https://acme-staging-v02.api.letsencrypt.org/directory
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: letsencrypt-prod-issuer-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: nginx
EOF
```

## Update Solvers Section of the Cert Manager Configuration

For wildcard certs you have to use the DNS-01 type of the challenge.

Additional details:

* [Let's Encrypt Wildcard Cert Usage Guidance](https://letsencrypt.org/docs/faq/#does-let-s-encrypt-issue-wildcard-certificates)
* [CertManager IO Wildcard Cert Usage Guidance](https://cert-manager.io/docs/release-notes/release-notes-0.3/#acmev2-and-lets-encrypt-wildcard-certificates)

We can use either Google Cloud or Cloudflare as the DNS solver.  Subsequent sections of this guide will use Google Cloud DNS for this purpose but we provide both examples below for reference.

#### Google Cloud DNS

> Additional details from Google Cloud on DNS usage are found [here](https://cert-manager.io/docs/configuration/acme/dns01/google/).

```
    solvers:
    - dns01:
        cloudDNS:
          # The ID of the GCP project
          project: "<your-gcp-project-id-number>"
          # This is the secret used to access the GCP service account JSON key
          serviceAccountSecretRef:
            name: clouddns-gcp-dns01-solver-sa
            key: key.json
```

#### CloudFlare DNS

> Additional details from CloudFlare on DNS usage are found [here](https://cert-manager.io/docs/configuration/acme/dns01/google/).

```
    solvers:
    - dns01:
        cloudDNS:
          # The ID of the GCP project
          project: "<your-gcp-project-id-number>"
          # This is the secret used to access the GCP service account JSON key
          serviceAccountSecretRef:
            name: clouddns-gcp-dns01-solver-sa
            key: key.json
```
