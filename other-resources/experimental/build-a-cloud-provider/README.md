# Build a Cloud Provider - Merge GPU Instructions

Become an Akash provider and make profit on your spare compute made available for tenant lease.

Our curated guide to building your decentralized provider follows these sequential steps.

* **STEP 1** - [Build the Kubernetes Cluster for your Provider](../../../providers/build-a-cloud-provider/kubernetes-cluster-for-akash-providers/)
* **STEP 2** - [Build your Cloud Provider via Helm Charts](../../../providers/build-a-cloud-provider/akash-cloud-provider-build-with-helm-charts/)
* **STEP 3** - [Complete a CheckUp of your New Provider](../../../providers/build-a-cloud-provider/akash-provider-checkup/)
* **STEP 4** - [Enable Persistent Storage on your Cloud Provider](../../../providers/build-a-cloud-provider/helm-based-provider-persistent-storage-enablement/)
* **STEP 5** - [Provider Maintenance](../../../providers/akash-provider-troubleshooting/provider-maintenance.md)
* **STEP 6** - [Provider Troubleshooting](../../../providers/akash-provider-troubleshooting/)
* **STEP 7** - [What's Next (Provider Care and Maintenance)](../../../providers/akash-provider-troubleshooting/maintaining-and-rotating-kubernetes-etcd-certificates-a-how-to-guide.md)

#### OPTIONAL STEPS

> _**NOTE**_ - the following features are not requirements of an Akash Provider but the enablement of such features may increase demand and tenant lease activity.  Consider adding such functionality to your Akash Provider either in initial build or at a later stage.

* [TLS Certs for Akash Providers](../../../providers/build-a-cloud-provider/tls-certs-for-akash-provider-optional-step/)
* [IP Leases](../../../providers/build-a-cloud-provider/ip-leases-provider-enablement-optional-step/)
* [Persistent Storage](../../../providers/build-a-cloud-provider/helm-based-provider-persistent-storage-enablement/persistent-storage-requirements.md)

#### GPU PROVIDER

Use the guide below to build an Akash provider hosting GPU resources:

* [Provider Build With GPU](../../../providers/build-a-cloud-provider/provider-build-with-gpu/)

#### VERIFICATIONS AND TROUBLESHOOTING

> _**NOTE**_ - utilize these guides post Akash Provider build to ensure the provider is fully operational and during troubleshooting/maintenance needs.

* [Akash Provider Checkup](../../../providers/build-a-cloud-provider/akash-provider-checkup/)
* [Akash Provider Maintenance/FAQ/Troubleshooting](../../../providers/akash-provider-troubleshooting/)

## Helm Chart Repository for Akash Providers

The steps outlined above will guide the user through the creation of an Akash Provider and necessary components.  The table below clarifies required and optional Helm Charts in the Provider build process.

The Akash Helm Chart repository can be accessed [here](https://github.com/akash-network/helm-charts).

<table><thead><tr><th>Chart Name</th><th>Description</th><th data-hidden></th></tr></thead><tbody><tr><td>akash-provider</td><td>Installs an Akash provider (required)</td><td></td></tr><tr><td>akash-hostname-operator</td><td>An operator to map Ingress objects to Akash deployments (required)</td><td></td></tr><tr><td>akash-node</td><td>Installs an Akash RPC node (required)</td><td></td></tr><tr><td>akash-inventory-operator</td><td>An operator required for persistent storage (optional)</td><td></td></tr><tr><td>akash-ip-operator</td><td>An operator required for ip marketplace (optional)</td><td></td></tr></tbody></table>
