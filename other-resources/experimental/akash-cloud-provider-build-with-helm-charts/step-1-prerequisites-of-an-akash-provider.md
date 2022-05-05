# STEP 1 - Prerequisites of an Akash Provider

## Akash Wallet

Placing a bid on an order requires a 5 AKT deposit placed into collateral per bid won. If the provider desired 2 concurrent leases, the provider’s wallet would need minimum funding of 10AKT.

As every deployment request bid requires 5 AKT to be deposited in the escrow account, it's always good to have more so your provider can keep bidding. If your provider is ready to offer 10 deployments, then it's best to have 5 x 10 = 50 AKT and a little more to make sure provider can pay the fees for broadcasting the transactions on Akash Network.

The steps to create an Akash wallet are covered in the Provider setup section of this [document](https://docs.akash.network/token/keplr).

## **Kubernetes Cluster**

A full Kubernetes cluster is required with outbound internet access and be reachable from the internet.

If you need assistance in building a new cluster, visit the [Kubernetes Cluster for Akash Providers ](../kubernetes-cluster-for-akash-providers/)guide.

## RPC Node

Akash Providers need to run their own blockchain RPC node to remove dependence on public nodes.  This is a strict requirement.&#x20;

Build your own RPC node via these [instructions](../../../akash-nodes/run-an-akash-node/).

## Custom Kubernetes Cluster Settings

Akash Providers are deployed in many environments and we will make additions to these sections as when nuances are discovered.

* [VMware Tanzu](../../../providers/custom-kubernetes-cluster-settings/vmware-tanzu.md)
