# Step 5 - Domain Name Review

Add A records on your external DNS servers for Akash Provider related domains.&#x20;

### Akash Provider Domain Records

* Replace yourdomain.com with your own domain name
* Direct A records to public IP address of a single Kubernetes worker node

```
*.ingress.yourdomain.com

provider.yourdomain.com
```

### Example DNS Configuration

![](../../../.gitbook/assets/dnsExample.png)
