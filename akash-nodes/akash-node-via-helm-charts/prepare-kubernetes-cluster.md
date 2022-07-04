# Prepare Kubernetes Cluster

## Overview

In this section we will create necessary Kubernetes labels, install Helm, and ensure the necessary Helm repositories are available.

## Create Necessary Kubernetes Labels

* Create the `akash-services` label if not done so prior

```
kubectl create ns akash-services
kubectl label ns akash-services akash.network/name=akash-services akash.network=true
```

## Install Helm

* Install Helm for Kubernetes package management if not done so prior
* Execute on these steps on a Kubernetes master node

```
wget https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz

tar -zxvf helm-v3.8.2-linux-amd64.tar.gz

mv linux-amd64/helm /usr/local/bin/helm

helm repo add akash https://ovrclk.github.io/helm-charts
```

## Update the Akash Helm Repo

```
helm repo update akash
```
