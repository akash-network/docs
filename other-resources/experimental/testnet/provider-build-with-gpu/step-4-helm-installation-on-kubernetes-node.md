# Helm Installation on Kubernetes Node

> _**NOTE**_ - conduct these steps from one of the Kubernetes control plane/master nodes

## Helm Install

```
wget https://get.helm.sh/helm-v3.11.2-linux-amd64.tar.gz

tar -zxvf helm-v3.11.2-linux-amd64.tar.gz

install linux-amd64/helm /usr/local/bin/

rm -rf helm-v3.11.2-linux-amd64.tar.gz linux-amd64

helm repo add nvdp https://nvidia.github.io/k8s-device-plugin

helm repo add akash https://akash-network.github.io/helm-charts

helm repo update
```



## **Confirmation of Helm Install**

**Print Helm Version**

```
helm version
```

**Expected Output**

```
# helm version

version.BuildInfo{Version:"v3.11.2", GitCommit:"472c5736ab01133de504a826bd9ee12cbe4e7904", GitTreeState:"clean", GoVersion:"go1.18.10"}
```

