# layer 1

In this step, we'll be installing Kubernetes and the necessary components such as helm, load balancers etc

To install just run the following:

```
MASTER_IP={packet_ip} HOST={host_fqdn} make layer1-install
```

## Verify

```
make layer1-check HOST=node.sjc1.ovrclk1.com
```

You should see an output similar to:

```
KUBECONFIG=/Users/gosuri/code/go/src/github.com/ovrclk/disco/data/db/config/kube/node.sjc1.ovrclk1.com kubectl cluster-info
Kubernetes master is running at https://139.178.70.174:6443
CoreDNS is running at https://139.178.70.174:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'
```

## Configure Kubernetes client

Generate kubernetes config file

```
make kube-config HOST=node.sjc1.ovrclk1.com
```

Set `KUBECONFIG` environment variable

```
export KUBECONFIG=$(make kube-config-path HOST=node.sjc1.ovrclk1.com)
```

### Verify Kubernetes CLI is setup properly

```
kubectl get pods -A

kube-system   coredns-66f496764-gnt2z          1/1     Running     0          8m36s
kube-system   helm-install-traefik-czgfw       0/1     Completed   0          8m36s
kube-system   tiller-deploy-767d9b9584-r2zxt   1/1     Running     0          8m36s
kube-system   svclb-traefik-jvqcg              3/3     Running     0          8m22s
kube-system   csi-packet-controller-0          3/3     Running     0          8m18s
kube-system   csi-node-9xb77                   2/2     Running     0          8m18s
kube-system   traefik-d869575c8-8qrfc          1/1     Running     0          8m22s
```

Now your Kubernetes Cluster is ready
