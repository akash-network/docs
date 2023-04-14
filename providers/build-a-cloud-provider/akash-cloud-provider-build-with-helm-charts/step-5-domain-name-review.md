# Step 5 - Domain Name Review

## Overview

Add DNS (type A) records for your Akash Provider related domains on your DNS hosting provider.

## Akash Provider Domain Records

* Replace yourdomain.com with your own domain name
* DNS (type A) records should point to public IP address of a single Kubernetes worker node of your choice

```
*.ingress.yourdomain.com

provider.yourdomain.com
```

> _**NOTE**_ - do not use Cloudflare or any other TLS proxy solution for your Provider DNS A records.

> _**NOTE**_ - Instead of the multiple DNS A records for worker nodes, consider using CNAME DNS records such as the example provided below.  CNAME use allows ease of management and introduces higher availability.
>
> \
> `*.ingress 300 IN CNAME nodes.yourdomain.com.`\
> `nodes 300 IN A x.x.x.x`\
> `nodes 300 IN A x.x.x.x`\
> `nodes 300 IN A x.x.x.x`\
> `provider 300 IN CNAME nodes.yourdomain.com.`

## Example DNS Configuration

![](../../../.gitbook/assets/namecheapCapture.png)
