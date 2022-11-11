# Step 5 - Domain Name Review

## Overview

Add DNS (type A) records for your Akash Provider related domains on your DNS hosting provider.

## Akash Provider Domain Records

* Replace yourdomain.com with your own domain name
* DNS (type A) records should point to public IP address of a single Kubernetes worker node of your choice

> _**NOTE**_ - do not use Cloudflare or any other TLS proxy solution for your Provider DNS A records.

```
*.ingress.yourdomain.com

provider.yourdomain.com
```

## Example DNS Configuration

![](../../../.gitbook/assets/namecheapCapture.png)
