# Akash Cloud Provider Build With Helm Charts



An Akash Provider leases compute to users launching new deployments. Follow the steps in this guide to build your own provider.

This guide uses a single Kubernetes master node.

## Lease Withdraw Known Bug and Temp Workaround

* A known bug exists in Akash version 0.16.4 in which providers are not withdrawing from active leases properly.
* Following your provider build using this guide, use these steps to determine if your provider is being impacted by this bug and to implement a temp workaround:

> * To verify if your provider is being impacted by this bug follow the steps covered [here](https://gist.github.com/andy108369/3b396076c5426fa666e66fea22e2b4ef).
> * To apply the temporary workaround for this bug, implement the steps covered [here](https://github.com/ovrclk/akash/issues/1635#issuecomment-1168944395) .

## Overview and links to the steps involved in Akash Provider Build:

* [Prerequisites of an Akash Provider](step-1-prerequisites-of-an-akash-provider.md)
* [Kubernetes Configurations](step-2-kubernetes-configurations.md)
* [Export Provider Wallet](step-3-export-provider-wallet.md)
* [Helm Installation on Kubernetes Node](step-4-helm-installation-on-kubernetes-node.md)
* [Domain Name Review](step-5-domain-name-review.md)
* [Provider Build via Helm Chart](step-6-provider-build-via-helm-chart.md)
* [Provider Bid Customization](step-6-provider-bid-customization.md)
* [Hostname Operator Build](step-7-hostname-operator-build.md)
* [Ingress Controller Install](step-8-ingress-controller-install.md)
* [Firewall Rule Review](step-9-firewall-rule-review.md)
