# Ingress Controller Wildcard Cert Use

## Overview

The steps in section replace the Kubernetes Ingress Controller Fake Certificate default cert `ingress-nginx` serves over 443/tcp (HTTPS) by default to all clients who do not have the certs explicitly set.

## Update the ingress-nginx-custom.yaml Config File

Update the `ingress-nginx-custom.yaml` file - originally created when installing your Akash Provider ingress controller in this [guide/step](ingress-controller-wildcard-cert-use.md) - with this extra argument:

```
  extraArgs:
    default-ssl-certificate: "$(POD_NAMESPACE)/wildcard-yourdomain-com-tls"
```

## Update the Ingress Controller

Use the `helm upgrade` command - same syntax which was used in the original install of the `ingress-nginx` chart and detailed [here](ingress-controller-wildcard-cert-use.md) - to apply the changes.

## Verification

After following this doc, all deployments receiving their hostnames within `*.ingress.<yourdomain>` or `*.<yourdomain>` will automatically have the wildcard LE (Let's Encrypt) cert!

Verify by issuing (replace `yourdomain` with the actual domain):

```
echo "" | openssl s_client -connect rmkpiskhbhfpr3901cqok3dhrk.ingress.yourdoamin.com:443 -showcerts |& openssl x509 -issuer -subject -dates -noout -text | grep -E '(Issuer:|Subject:|Not Before:|Not After :|DNS:)'
```

#### Expected/Example Output

> _**NOTE**_ - If you still get Kubernetes Ingress Controller Fake Certificate at this point, it is likely the `ingress-nginx` did not pick-up the cert or the cert hasn't been issued by the cert-manager.

```
        Issuer: C = US, O = Let's Encrypt, CN = R3
            Not Before: Apr 26 10:40:06 2023 GMT
            Not After : Jul 25 10:40:05 2023 GMT
        Subject: CN = *.yourdoamin.com
                DNS:*.ingress.yourdoamin.com, DNS:*.yourdoamin.com
```
