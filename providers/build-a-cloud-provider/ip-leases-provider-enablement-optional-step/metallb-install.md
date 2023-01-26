# MetalLB Install

In this guide we present paths to install MetalLB both via Helm Charts and Kubespray.  Please follow only the path applicable, ideal to your environment.

## Deploy MetalLB with Helm (Option 1)

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

```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 144.217.30.192/28
      - 198.50.185.112/28
      - 66.70.218.96/28
EOF
```

> If you are using MetalLB with a kubernetes version that enforces [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/) (which is beta in k8s 1.23), make sure to label the metallb-system namespace with the following labels:

```
  labels:
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/audit: privileged
    pod-security.kubernetes.io/warn: privileged
```

## Deploy MetalLB using Kubespray (Option 2)

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
