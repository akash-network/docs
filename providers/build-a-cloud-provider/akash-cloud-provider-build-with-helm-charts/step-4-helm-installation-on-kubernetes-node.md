# STEP 4 - Helm Installation on Kubernetes Node



*   Install Helm on a Kubernetes Master Node

    ```
    wget https://get.helm.sh/helm-v3.11.0-linux-amd64.tar.gz

    tar -zxvf helm-v3.9.4-linux-amd64.tar.gz

    mv linux-amd64/helm /usr/local/bin/helm

    ###Remove any potential prior repo instances
    helm repo remove akash

    helm repo add akash https://akash-network.github.io/helm-charts
    ```



## **Confirmation of Helm Install**

**Print Helm Version**

```
helm version
```

**Expected Output**

```
root@node1:~# helm version

version.BuildInfo{Version:"v3.9.4", GitCommit:"6e3701edea09e5d55a8ca2aae03a68917630e91b", GitTreeState:"clean", GoVersion:"go1.17.5"}
```
