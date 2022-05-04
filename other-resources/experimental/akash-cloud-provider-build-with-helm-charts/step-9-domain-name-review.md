# Step 9 - Domain Name Review

Our guide defines a domain which all of the charts will use for their ingress routes. For our example we use yourdomain.com.

Add A records for the IP addresses of all Kubernetes worker nodes and point to nodes.yourdomain.com.

To get the external IP of your worker nodes, run the following command on your Kubernetes cluster.

```
kubectl get nodes -A -o wide
```

Your DNS records should look something like this:

```
*.ingress 300 IN CNAME nodes.yourdomain.com.
nodes 300 IN A x.x.x.x
nodes 300 IN A x.x.x.x
nodes 300 IN A x.x.x.x
provider 300 IN CNAME nodes.yourdomain.com.
```
