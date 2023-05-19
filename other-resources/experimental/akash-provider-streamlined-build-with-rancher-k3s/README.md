# Akash Provider Streamlined Build with Rancher K3s

An Akash Provider leases compute to users launching new deployments. Follow the steps in this guide to build your own provider using a streamlined Kubernetes install process.

This guide uses a Rancher K3s to build a single control plane and worker node "all in one" Kubernetes cluster with little effort.  The Kubernetes cluster is then utilized for the Akash Provider install and configuration steps.

Overview and links to the steps involved in Akash Provider Build using K3s:

* [Install K3s and Initial Cluster Config](step-1-install-k3s-and-initial-cluster-config.md)
* [Install the Akash CLI for Provider Use](step-2-install-akash-cli.md)
* [Akash Provider Wallet](step-3-akash-provider-wallet.md)
* [Export Provider Wallet](step-3-export-provider-wallet.md)
* [Install Helm](step-5-install-helm.md)
* [Provider Build via Helm Chart](step-6-provider-build-via-helm-chart.md)
* [Hostname Operator Build](step-7-hostname-operator-build.md)
* [Ingress Controller Install](broken-reference)
* [Next Steps - Provider Health Check and Optional Services](step-9-next-steps-provider-health-check-and-optional-services.md)
