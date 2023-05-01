# TLS Certs for Akash Provider (Optional Step)

Follow the instructions in this guide to replace the `Kubernetes Ingress Controller Fake Certificate` default cert which `ingress-nginx` serves over 443/tcp (HTTPS) by default.

After following this doc, all deployments receiving Akash Provider hostnames within `*.ingress.<yourdomain>` or `*.<yourdomain>` will automatically have the wildcard Let's Encrypt certificate.  This will ensure that users interacting with such deployments will not receive self signed certificate warnings.

* [Install Let's Encrypt Cert Manager](install-lets-encrypt-cert-manager.md)
* [Configure the Issuer](configure-the-issuer.md)
* [Google Cloud OR Cloudflare Configuration](google-cloud-or-cloudflare-configuration.md)
* [Wildcard Certificate Request](wildcard-certificate-request.md)
* [Ingress Controller Wildcard Cert Use](ingress-controller-wildcard-cert-use.md)
* [Optional Step - Certs for Custom Domains](optional-step-certs-for-custom-domains.md)
