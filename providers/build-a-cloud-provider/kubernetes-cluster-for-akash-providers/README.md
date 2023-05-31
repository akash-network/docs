# Kubernetes Cluster for Akash Providers

## **Overview**

Akash leases are deployed via Kubernetes pods on provider clusters.  This guide details the build of the provider’s Kubernetes control plane and worker nodes.

The setup of a Kubernetes cluster is the responsibility of the provider. This guide provides best practices and recommendations for setting up a Kubernetes cluster. This document is not a comprehensive guide and assumes pre-existing Kubernetes knowledge.

The Kubernetes Cluster created is then ready for the Akash Provider build detailed [here](../akash-cloud-provider-build-with-helm-charts/).

## Prerequisites

The Kubernetes instructions in this guide are intended for audiences that have the following skills sets and knowledge.

* **Server Administration Skills** - necessary for setting up servers/network making up the Kubernetes cluster
* **Kubernetes Experience** - a base level of Kubernetes administration is highly recommended

Please consider using the [Praetor](../../community-solutions/praetor.md) application to build an Akash Provider for small and medium sized environments which require little customization.

## Guide Sections

* [Clone the Kubespray Project](step-1-clone-the-kubespray-project.md)
* [Install Ansible](step-2-install-ansible.md)
* [Ansible Access to Kubernetes Cluster](step-3-ansible-access-to-kubernetes-cluster.md)
* [Ansible Inventory](step-4-ansible-inventory.md)
* [Additional Verifications](step-5-enable-gvisor.md)
* [DNS Configuration](step-6-dns-configuration.md)
* [Provider Ephemeral Storage Config](step-6-provider-ephemeral-storage-config.md)
* [Create Kubernetes Cluster](step-6-create-kubernetes-cluster.md)
* [Confirm Kubernetes Cluster](step-7-confirm-kubernetes-cluster.md)
* [Custom Kernel Parameters](step-10-custom-kernel-parameters.md)
* [Review Firewall Policies](step-9-review-firewall-policies.md)
