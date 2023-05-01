# Optional Step - Certs for Custom Domains

In this section we detail the use of Let's Encrypt for custom domains served by your provider.  The prior steps in this guide enabled use of Let's Encrypt for Akash provider generated domains.  This section details the optional step of enabling Let's Encrypt for domains specified in the `accept` field of an Akash deployment's SDL.

## Pros/Cons of Custom Domain Let's Encrypt Configuration

### Pros of Using Let's Encrypt for Custom Domains

* No API key/token is required since no `DNS-01` ACME challenge is used
* Users will be able to have their custom domains signed by the Let's Encrypt
* The certs will automatically renew every 45-60 days by the cert-manager
* Users do not have to send/share their domain API key/token with the provider at all (based on the HTTP-01 ACME challenge)

### Cons of Using Let's Encrypt for Custom Domains

* No wildcard support since it's done via HTTP-01 ACME challenge; (the wildcard certs require DNS-01 ACME challenge and so the domain's API key/token)

## Configuration of Custom Domains

> _**NOTE**_ - the steps in this section must be followed for each individual custom domain desired to support

### STEP 1 - Ensure the CNAME of the Deployment Points to Provider Worker Node

* The CNAME of the deployment must be point to one of the provider worker nodes
* Verify by conducting these actions:

#### Gather the Custom Domain for the Deployment

The CNAME is `tetris.decloud.pro` in this example:

```
services:
  app:
    image: bsord/tetris
    expose:
      - port: 80
        as: 80
        to:
          - global: true
        accept:
          - "tetris.decloud.pro"
```

#### Conduct DNS Dig to Confirm CNAME is Pointing to Provider Worker Node

Example dig verification:

```
dig tetris.decloud.pro

tetris.decloud.pro.  92  IN  CNAME provider.akash.pro.
provider.akash.pro. 92  IN  A 65.108.6.185
```

### STEP 2 - Ingress Controller Annotation and Patch

> _**NOTE**_ - this is something Akash does not do out-of-the-box currently.

> _**NOTE**_ - this step should be performed on one of the Kubernetes control plane nodes of your Akash Provider

```
kubectl -n l71u6bbb5mqdu592el2mics5ltqvp49uojd8fn0ien3kg annotate ingress tetris.decloud.pro cert-manager.io/cluster-issuer="letsencrypt-prod"
kubectl -n l71u6bbb5mqdu592el2mics5ltqvp49uojd8fn0ien3kg patch ingress tetris.decloud.pro -p '{"spec":{"tls":[{"hosts":["tetris.decloud.pro"],"secretName":"tetris-decloud-pro-tls"}]}}'
```

### STEP 3 - Verification

* Verify that Let's Encrypt issued the x509 cert for `tetris.decloud.pro` based on the example custom domain
* Replace the domain name with your own custom domains added

```
echo "" | openssl s_client -connect tetris.decloud.pro:443 -showcerts |& openssl x509 -issuer -subject -dates -noout -text | grep -E '(Issuer:|Subject:|Not Before:|Not After :|DNS:)'
```

#### Example/Expected Output

```
        Issuer: C = US, O = Let's Encrypt, CN = R3
            Not Before: Apr 28 19:19:44 2023 GMT
            Not After : Jul 27 19:19:43 2023 GMT
        Subject: CN = tetris.decloud.pro
                DNS:tetris.decloud.pro
```
