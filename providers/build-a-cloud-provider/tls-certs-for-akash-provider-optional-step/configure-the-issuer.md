# Configure the Issuer

## Initial Cert Manager Configuration

> _**NOTE**_ -  If you want to use the namespaces then configure Issuer instead of the ClusterIssuer.

```
cat > cert-manager-values.yaml << EOF
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

Additional details from Let's Encrypt:

* [Let's Encrypt Wildcard Cert Usage Guidance](https://letsencrypt.org/docs/faq/#does-let-s-encrypt-issue-wildcard-certificates)
* [CertManager IO Wildcard Cert Usage Guidance](https://cert-manager.io/docs/release-notes/release-notes-0.3/#acmev2-and-lets-encrypt-wildcard-certificates)

We can use either Google Cloud or Cloudflare as the DNS solver.  Subsequent sections of this guide will use Google Cloud DNS for this purpose but we provide both examples below for reference.

#### Google Cloud DNS Additions

> Additional details from Google Cloud on DNS usage are found [here](https://cert-manager.io/docs/configuration/acme/dns01/google/).

* Add the following section in the `solvers` section of your `cert-manager-values.yaml` file.

> _**NOTE**_ - see these [section](configure-the-issuer.md#google-dns-example) for a full `cert-manager-values.yaml` YAML file example

```
    - dns01:
        cloudDNS:
          # The ID of the GCP project
          project: "<your-gcp-project-id-number>"
          # This is the secret used to access the GCP service account JSON key
          serviceAccountSecretRef:
            name: clouddns-gcp-dns01-solver-sa
            key: key.json
```

#### CloudFlare DNS Additions

> Additional details from CloudFlare on DNS usage are found [here](https://cert-manager.io/docs/configuration/acme/dns01/google/).

* Add the following section in the `solvers` section of your `cert-manager-values.yaml` file.

> _**NOTE**_ - see these [section](configure-the-issuer.md#cloudflare-dns-example) for a full cert-manager-values.yaml YAML file example

```
    - dns01:
        cloudDNS:
          # The ID of the GCP project
          project: "<your-gcp-project-id-number>"
          # This is the secret used to access the GCP service account JSON key
          serviceAccountSecretRef:
            name: clouddns-gcp-dns01-solver-sa
            key: key.json
```

### Complete cert-manager-values.yaml YAML File Example

#### Google DNS Example

* Fully populated `cert-manager-values.yaml` manifest using the Google Cloud DNS example

```
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: REDACTED
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
    - dns01:
        cloudDNS:
          # The ID of the GCP project
          project: "REDACTED"
          # This is the secret used to access the GCP service account JSON key
          serviceAccountSecretRef:
            name: clouddns-gcp-dns01-solver-sa
            key: key.json
```

#### CloudFlare DNS Example

* Fully populated `cert-manager-values.yaml` manifest using the CloudFlare DNS example

```
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: REDACTED
    ##server: https://acme-staging-v02.api.letsencrypt.org/directory
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: letsencrypt-prod-issuer-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: nginx
    - dns01:
        cloudflare:
          apiTokenSecretRef:
            key: api-token
            name: cloudflare-api-token-secret
          email: REDACTED
      selector:
        dnsZones:
          - 'akash.pro'
          - 'ingress.akash.pro'
```

## Apply Manifest

Once your `cert-manager-values.yaml` is configured properly and based on the guidance above, apply the manifest to your Kubernetes cluster.

```
kubectl apply -f cert-manager-values.yaml
```
