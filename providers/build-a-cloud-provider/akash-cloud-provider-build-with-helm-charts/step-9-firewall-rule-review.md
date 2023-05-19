# Step 10 - Firewall Rule Review

## External/Internet Firewall Rules

The following firewall rules are applicable to internet-facing Kubernetes components.

### **Akash Provider**

```
8443/tcp - for manifest uploads
```

### **Ingress Controller**

```
80/tcp - for web app deployments
443/tcp - for web app deployments
30000-32767/tcp - for Kubernetes node port range for deployments
30000-32767/udp - for Kubernetes node port range for deployments
```
