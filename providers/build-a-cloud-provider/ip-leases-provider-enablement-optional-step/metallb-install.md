# MetalLB Install

In this guide we present paths to install MetalLB both via Helm Charts and Kubespray.  Please follow only the path applicable, ideal to your environment.

Sections within this guide:

* [New MetalLB Deployment via Helm](metallb-install.md#option-1-deploy-metallb-with-helm)
* [New MetalLB Deployment via Kubespray](metallb-install.md#option-2-deploy-metallb-using-kubespray)
* [Migration of MetalLB Version 0.12.X to 0.13.x](metallb-install.md#migrating-metallb-0.12.x-to-0.13.x)

## Option 1: Deploy MetalLB with Helm

> _**NOTE**_ - If you plan to upgrade your MetalLB Helm-Chart in the future, ensure the [metallb release notes](https://metallb.universe.tf/release-notes/) are followed.

```
helm repo add metallb https://metallb.github.io/metallb

helm -n metallb-system install metallb metallb/metallb --version 0.13.7
```

### Expose your MetalLB Controller to the Akash IP Operator

```
kubectl -n metallb-system expose deployment metallb-controller --name=controller --overrides='{"spec":{"ports":[{"protocol":"TCP","name":"monitoring","port":7472}]}}'
```

### Apply your MetalLB Config

> _**NOTE**_ - make sure you replace the example addresses with your IP ranges

#### Create the MetalLB Config

```
cat > metallb-config.yaml << EOF
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - 144.217.30.192/28
  - 198.50.185.112/28
  - 66.70.218.96/28
  - 194.28.98.217/32
  - 194.28.98.219-194.28.98.222
  autoAssign: true
  avoidBuggyIPs: false
EOF
```

#### Apply the MetalLB Config

```
kubectl apply -f metallb-config.yaml
```

> If you are using MetalLB with a kubernetes version that enforces [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/) (which is beta in k8s 1.23), make sure to label the metallb-system namespace with the following labels:

```
  labels:
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/audit: privileged
    pod-security.kubernetes.io/warn: privileged
```

## Option 2: Deploy MetalLB using Kubespray

Based on MetalLB via Kubespray guidance documented [here](https://github.com/kubernetes-sigs/kubespray/blob/v2.20.0/docs/metallb.md)

The Kubespray flags provided bellow should go into your Provider's Kubespray inventory file and under the vars section.  Our reference Provider Kubespray inventory file - used during initial Provider Kubernetes cluster build - is located [here](https://docs.akash.network/providers/build-a-cloud-provider/kubernetes-cluster-for-akash-providers/step-4-ansible-inventory#manual-edits-insertions-of-the-hosts.yaml-inventory-file).

```
# akash provider needs metallb pool name set to `default` - https://github.com/ovrclk/provider-services/blob/v0.1.0-rc13/cluster/kube/metallb/client.go#L43
metallb_pool_name: default
metallb_enabled: true
metallb_speaker_enabled: true
#metallb_avoid_buggy_ips: true
metallb_protocol: layer2
kube_proxy_strict_arp: true

# set your IP ranges here
metallb_ip_range:
  - 144.217.30.192/28
  - 198.50.185.112/28
  - 66.70.218.96/28
```

### Expose your MetalLB Controller to the Akash IP Operator

* Kubespray your cluster with this config and then expose your MetalLB controller for the Akash IP Operator access it

```
kubectl -n metallb-system expose deployment controller --overrides='{"spec":{"ports":[{"protocol":"TCP","name":"monitoring","port":7472}]}}'
```

## Migrating MetalLB 0.12.X to 0.13.X

> _**Perform the following only if you have upgraded your MetalLB from 0.12 (or prior) to 0.13 (or higher) version.**_

> Based on [https://metallb.universe.tf/configuration/migration\_to\_crds/](https://metallb.universe.tf/configuration/migration\_to\_crds/)

1\). Save the old v0.12 configmap-based metallb config to a `config.yaml` file

```
kubectl -n metallb-system get cm config -o yaml > config.yaml
```

2\). Use this command to migrate it to v0.13 (CRD-based format) - (`resources.yaml`)

```
docker run -d -v $(pwd):/var/input quay.io/metallb/configmaptocrs
```

This will produce a new config file - `resources.yaml`.

3\). Apply the new config

```
kubectl apply -f resources.yaml
```

4\). Remove the old config

```
kubectl -n metallb-system delete cm config
```

#### Example of Legacy v0.12 Metallb Configmap Based Config

* `config.yaml`

```
apiVersion: v1
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 194.28.98.216/29
kind: ConfigMap
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","data":{"config":"address-pools:\n- name: default\n  protocol: layer2\n  addresses:\n  - 194.28.98.216/29\n"},"kind":"ConfigMap","metadata":{"annotations":{},"name":"config","namespace":"metallb-system"}}
  creationTimestamp: "2023-02-20T10:35:36Z"
  name: config
  namespace: metallb-system
  resourceVersion: "150026"
  uid: fd35767f-2f35-4792-b4fd-01b1d9ce2cb8
```

#### Example of New metallb v0.13 CRD Based Config

* `resources.yaml`

```
# This was autogenerated by MetalLB's custom resource generator.
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  creationTimestamp: null
  name: default
  namespace: metallb-system
spec:
  addresses:
  - 194.28.98.216/29
status: {}
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  creationTimestamp: null
  name: l2advertisement1
  namespace: metallb-system
spec:
  ipAddressPools:
  - default
status: {}
---
```
