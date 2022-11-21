# STEP 1 - Prerequisites of an Akash Provider

## Akash Wallet

Placing a bid on an order requires a 5 AKT deposit placed into collateral per bid won. If the provider desired 2 concurrent leases, the provider’s wallet would need minimum funding of 10AKT.

As every deployment request bid requires 5 AKT to be deposited in the escrow account, it's always good to have more so your provider can keep bidding. If your provider is ready to offer 10 deployments, then it's best to have 5 x 10 = 50 AKT and a little more to make sure provider can pay the fees for broadcasting the transactions on Akash Network.

The steps to create an Akash wallet are covered in the Provider setup section of this [document](../../../other-resources/archived-resources/mainnet3-legacy-docs/detailed-steps/part-1.-install-akash.md) (_**Parts 1-3 )**_.

## **Kubernetes Cluster**

A full Kubernetes cluster is required with outbound internet access and be reachable from the internet.

If you need assistance in building a new cluster, visit the [Kubernetes Cluster for Akash Providers ](../kubernetes-cluster-for-akash-providers/)guide.

## RPC Node

Akash Providers need to run their own blockchain RPC node to remove dependence on public nodes.  This is a strict requirement.&#x20;

We have recently released documentation guiding thru the process of building a [RPC node via Helm Charts](../../../akash-nodes/akash-node-via-helm-charts/) with state sync.

## CPU Support

Only x86\_64 processors are officially supported by Akash for provider Kubernetes nodes at this time.  This may change in the future and when ARM processors are supported it will be announced and documented.

## Custom Kubernetes Cluster Settings

Akash Providers are deployed in many environments and we will make additions to these sections as when nuances are discovered.

* [VMware Tanzu](../../custom-kubernetes-cluster-settings/vmware-tanzu.md)
