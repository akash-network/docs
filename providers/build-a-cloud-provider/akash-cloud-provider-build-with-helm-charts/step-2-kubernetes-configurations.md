# STEP 2 - Kubernetes Configurations

Create Provider namespaces on your Kubernetes cluster.

Run these commands from a Kubernetes master node which has kubectl access to cluster.

```
kubectl create ns akash-services
kubectl label ns akash-services akash.network/name=akash-services akash.network=true

kubectl create ns ingress-nginx
kubectl label ns ingress-nginx app.kubernetes.io/name=ingress-nginx app.kubernetes.io/instance=ingress-nginx

kubectl create ns lease
kubectl label ns lease akash.network=true
```
