# STEP 5 - Install Helm

## Helm Installation

```
wget https://get.helm.sh/helm-v3.11.0-linux-amd64.tar.gz

tar -zxvf helm-v3.11.0-linux-amd64.tar.gz

mv linux-amd64/helm /usr/local/bin/helm
```

## Verify Helm Install

```
helm version
```

#### Expected/Example Output

```
helm version

GitCommit:"472c5736ab01133de504a826bd9ee12cbe4e7904", GitTreeState:"clean", GoVersion:"go1.18.10"}
```

## Add Akash Helm Repository

```
helm repo remove akash
helm repo add akash https://akash-network.github.io/helm-charts
```
