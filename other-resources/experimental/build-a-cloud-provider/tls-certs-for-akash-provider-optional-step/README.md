# TLS Certs for Akash Provider (Optional Step)

Follow the instructions in this guide to replace the `Kubernetes Ingress Controller Fake Certificate` default cert which `ingress-nginx` serves over 443/tcp (HTTPS) by default.

After following this doc, all deployments receiving Akash Provider hostnames within `*.ingress.<yourdomain>` or `*.<yourdomain>` will automatically have the wildcard Let's Encrypt certificate.  This will ensure that users interacting with such deployments will not receive self signed certificate warnings.

* [Install Let's Encrypt Cert Manager](../../../../providers/build-a-cloud-provider/tls-certs-for-akash-provider-optional-step/install-lets-encrypt-cert-manager.md)
* [Configure the Issuer](../../../../providers/build-a-cloud-provider/tls-certs-for-akash-provider-optional-step/configure-the-issuer.md)
* [Google Cloud OR Cloudflare Configuration](../../../../providers/build-a-cloud-provider/tls-certs-for-akash-provider-optional-step/google-cloud-or-cloudflare-configuration.md)
* [Wildcard Certificate Request](../../../../providers/build-a-cloud-provider/tls-certs-for-akash-provider-optional-step/wildcard-certificate-request.md)
* [Ingress Controller Wildcard Cert Use](../../../../providers/build-a-cloud-provider/tls-certs-for-akash-provider-optional-step/ingress-controller-wildcard-cert-use.md)
* [Optional Step - Certs for Custom Domains](../../../../providers/build-a-cloud-provider/tls-certs-for-akash-provider-optional-step/optional-step-certs-for-custom-domains.md)
