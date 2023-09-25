# STEP 4 - Helm Installation on Kubernetes Node



*   Install Helm on a Kubernetes Master Node

    ```
    wget https://get.helm.sh/helm-v3.11.0-linux-amd64.tar.gz

    tar -zxvf helm-v3.11.0-linux-amd64.tar.gz

    install linux-amd64/helm /usr/local/bin/helm

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
# helm version

version.BuildInfo{Version:"v3.11.0", GitCommit:"472c5736ab01133de504a826bd9ee12cbe4e7904", GitTreeState:"clean", GoVersion:"go1.18.10"}
```

