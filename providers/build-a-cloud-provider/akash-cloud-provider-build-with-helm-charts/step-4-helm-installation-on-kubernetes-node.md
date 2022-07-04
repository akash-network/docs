# STEP 4 - Helm Installation on Kubernetes Node

*   Install Helm on a Kubernetes Master Node

    ```
    wget https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz

    tar -zxvf helm-v3.8.2-linux-amd64.tar.gz

    mv linux-amd64/helm /usr/local/bin/helm

    helm repo add akash https://ovrclk.github.io/helm-charts
    ```



## **Confirmation of Helm Install**

**Print Helm Version**

```
helm version
```

**Expected Output**

```
root@node1:~# helm version

version.BuildInfo{Version:"v3.8.2", GitCommit:"6e3701edea09e5d55a8ca2aae03a68917630e91b", GitTreeState:"clean", GoVersion:"go1.17.5"}
```
