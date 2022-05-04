# Table of contents

* [What is Akash?](README.md)
* [Technical Support](support.md)
* [Stack Definition Language (SDL)](stack-definition-language.md)

## Deploy on Akash <a href="#guides" id="guides"></a>

* [Apps on Akash](guides/awesome-akash.md)
* [Desktop App](guides/deploy.md)
* [Web App](guides/web.md)
* [CLI](guides/cli.md)

## Using Akash Tokens <a href="#token" id="token"></a>

* [Get Free Tokens](token/funding.md)
* [Buy Akash Tokens](token/buy.md)
* [Keplr Wallet](token/keplr.md)

## Release Notes

* [Akash Version 0.14.0](release-notes/v0.14.0.md)

## Tutorials <a href="#deploy" id="deploy"></a>

* [Mine Raptoreum on Akash Network](deploy/mine-raptoreum-on-akash-network.md)
* [Mixin Messenger for AKT](deploy/mixin-messenger-for-akt.md)
* [Polygon on Akash](deploy/polygon-on-akash.md)
* [Unstoppable Web 2.0](deploy/unstoppable-web-2.0.md)
* [Multi-Tiered Deployment](deploy/multi-tier-app.md)
* [Helium Validator](deploy/helium-validator.md)
* [PostgreSQL restore/backup](deploy/postgresql-restore-backup.md)
* [Ruby on Rails with Sia and Auth0](deploy/ruby-on-rails-with-sia-and-auth0.md)

## Operations

* [Akash Node Deployment Via Omnibus](operations/akash-node-deployment-via-omnibus.md)
* [Run an Akash Node](operations/node/README.md)
  * [RPC Service](operations/node/rpc-service.md)
  * [API Service](operations/node/api-service.md)
  * [Upgrade to Akash 3.0](guides/node/upgrades/akash-3.0.md)
* [Running a Validator](operations/validator.md)
* [Akash Audited Attributes](operations/akash-audited-attributes.md)

***

* [Providers](providers/README.md)
  * [Build a Cloud Provider](providers/build-a-cloud-provider/README.md)
    * [Kubernetes Cluster](providers/build-a-cloud-provider/kubernetes-cluster.md)
    * [gVisor Issue - No system-cgroup v2 Support](providers/build-a-cloud-provider/gvisor-issue-no-system-cgroup-v2-support.md)
    * [Provider Networks](providers/build-a-cloud-provider/provider-networks.md)
  * [Custom Kubernetes Cluster Settings](providers/custom-kubernetes-cluster-settings/README.md)
    * [VMware Tanzu](providers/custom-kubernetes-cluster-settings/vmware-tanzu.md)
  * [Akash Audited Attributes](providers/akash-audited-attributes.md)
  * [Akash Provider Migration Guide - 0.14.X to 0.16.3](providers/akash-provider-migration-guide-0.14.x-to-0.16.3.md)

## Command Line Interface (CLI) <a href="#cli" id="cli"></a>

* [Install Akash](cli/install.md)
* [CLI Commands](cli/command-line-interface.md)
* [Setup your Environment](cli/shell-variables.md)
* [Create Your Account](cli/wallet.md)

***

* [Features](features/README.md)
  * [Persistent Storage](features/persistent-storage/README.md)
    * [Persistent Storage Limitations](features/persistent-storage/persistent-storage-limitations.md)
    * [Implementation Overview](features/persistent-storage/implementation-overview.md)
    * [Persistent Storage SDL Deepdive](features/persistent-storage/persistent-storage-sdl-deepdive.md)
    * [Troubleshooting](features/persistent-storage/troubleshooting.md)
    * [Complete Persistent Storage Manifest/SDL Example](features/persistent-storage/complete-persistent-storage-manifest-sdl-example.md)
  * [Authorized Spend](features/authorized-spend/README.md)
    * [Relevant Commands and Example Use](features/authorized-spend/relevant-commands-and-example-use.md)
  * [Fractional uAKT](features/fractional-uakt/README.md)
    * [Relevant SDL Declaration and Example Use](features/fractional-uakt/relevant-sdl-declaration-and-example-use.md)
  * [Deployment Shell Access](features/deployment-shell-access.md)
  * [Deployment HTTP Options](features/deployment-http-options.md)
  * [Hostname Migration](features/hostname-migration.md)
* [Other Resources](other-resources.md)
  * [Experimental](other-resources/experimental/README.md)
    * [Akash Cloud Provider Build With Helm Charts](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/README.md)
      * [STEP 1 - Prerequisites of an Akash Provider](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-1-prerequisites-of-an-akash-provider.md)
      * [STEP 2 - Kubernetes Configurations](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-2-kubernetes-configurations.md)
      * [STEP 3 - Export Provider Wallet](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-3-export-provider-wallet.md)
      * [STEP 4 - Helm Installation on Kubernetes Node](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-4-helm-installation-on-kubernetes-node.md)
      * [STEP 5 - Provider Build via Helm Chart](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-5-provider-build-via-helm-chart.md)
      * [Step 6 - Hostname Operator Build](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-6-hostname-operator-build.md)
      * [STEP 7 - Ingress Controller Install](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-7-ingress-controller-install.md)
      * [Step 8 - Firewall Rule Review](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-8-firewall-rule-review.md)
      * [Step 9 - Domain Name Review](other-resources/experimental/akash-cloud-provider-build-with-helm-charts/step-9-domain-name-review.md)
    * [Kubernetes Cluster for Akash Providers](other-resources/experimental/kubernetes-cluster-for-akash-providers/README.md)
      * [STEP 1 - Clone the Kubespray Project](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-1-clone-the-kubespray-project.md)
      * [STEP 2 - Install Ansible](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-2-install-ansible.md)
      * [STEP 3 - Ansible Access to Kubernetes Cluster](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-3-ansible-access-to-kubernetes-cluster.md)
      * [STEP 4 - Ansible Inventory](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-4-ansible-inventory.md)
      * [STEP 5 - Enable gVisor](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-5-enable-gvisor.md)
      * [STEP 6 - Create Kubernetes Cluster](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-6-create-kubernetes-cluster.md)
      * [STEP 7 - Confirm Kubernetes Cluster](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-7-confirm-kubernetes-cluster.md)
      * [STEP 8 - Disable Swap on Kubernetes Hosts](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-8-disable-swap-on-kubernetes-hosts.md)
      * [STEP 9 - Review Firewall Policies](other-resources/experimental/kubernetes-cluster-for-akash-providers/step-9-review-firewall-policies.md)

## About Akash <a href="#glossary" id="glossary"></a>

* [Security](glossary/security.md)
* [Containers](glossary/platform.md)
* [Marketplace](glossary/marketplace.md)
* [Payments](glossary/escrow.md)
* [Authentication](glossary/mtls.md)
