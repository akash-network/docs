# STEP 1 - Install K3s and Initial Cluster Config

## Overview

In this section we will deploy a Kubernetes control plane and worker node on a single server using [Rancher K3s](https://www.rancher.com/products/k3s).  The use of K3s allows a very simple Kubernetes cluster install appropriate for single server production and lab environments.

## Install K3s

```
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh -s -
```

## Configure Kubeconfig

```
mkdir ~/.kube

sudo cat /etc/rancher/k3s/k3s.yaml | tee ~/.kube/config >/dev/null
```

## Confirm Kubectl Access to the Kubernetes Cluster

```
kubectl get nodes
```

#### Expected/Example Output

```
kubectl get nodes

NAME              STATUS   ROLES                  AGE    VERSION
ip-172-31-3-111   Ready    control-plane,master   3m4s   v1.25.6+k3s1
```

## Create Necessary Labels for the Akash Provider

```
kubectl create ns akash-services
kubectl label ns akash-services akash.network/name=akash-services akash.network=true

kubectl create ns ingress-nginx
kubectl label ns ingress-nginx app.kubernetes.io/name=ingress-nginx app.kubernetes.io/instance=ingress-nginx

kubectl create ns lease
kubectl label ns lease akash.network=true
```
