# STEP 1 - Prerequisites of an Akash Provider

## Akash Wallet

Placing a bid on an order requires a 5 AKT deposit placed into collateral per bid won. If the provider desired 2 concurrent leases, the provider’s wallet would need minimum funding of 10AKT.

The steps to create an Akash wallet are covered in the Provider setup section of this [document](https://docs.akash.network/token/keplr).

## **Kubernetes Cluster**

A full Kubernetes cluster is required with outbound internet access and be reachable from the internet.

If you need assistance in building a new cluster, visit the [Kubernetes Cluster for Akash Providers ](../kubernetes-cluster-for-akash-providers/)guide.

## RPC Node

Akash Providers need to run their own blockchain RPC node to remove dependence on public nodes.  This is a strict requirement.  The RPC node should not run as a deployment on the Testnet network as no long running workloads should run in that environment and deployments running for more than several hours be deleted.

Build your own RPC node via these [instructions](../../../akash-nodes/run-an-akash-node/).

## Custom Kubernetes Cluster Settings

Akash Providers are deployed in many environments and we will make additions to these sections as when nuances are discovered.

* [VMware Tanzu](../../../providers/custom-kubernetes-cluster-settings/vmware-tanzu.md)
