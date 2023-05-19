# Build a Cloud Provider

Become an Akash provider and make profit on your spare compute made available for tenant lease.

Our curated guide to building your decentralized provider follows these sequential steps.

* **STEP 1** - [Build the Kubernetes Cluster for your Provider](kubernetes-cluster-for-akash-providers/)
* **STEP 2** - [Build your Cloud Provider via Helm Charts](akash-cloud-provider-build-with-helm-charts/)
* **STEP 3** - [Complete a CheckUp of your New Provider](akash-provider-checkup/)
* **STEP 4** - [Enable Persistent Storage on your Cloud Provider](helm-based-provider-persistent-storage-enablement/)
* **STEP 5** - [Provider Troubleshooting](../akash-provider-troubleshooting/)
* **STEP 6** - [What's Next (Provider Care and Maintenance)](../akash-provider-troubleshooting/maintaining-and-rotating-kubernetes-etcd-certificates-a-how-to-guide.md)

## Helm Chart Repository for Akash Providers

The steps outlined above will guide the user through the creation of an Akash Provider and necessary components.  The table below clarifies required and optional Helm Charts in the Provider build process.

The Akash Helm Chart repository can be accessed [here](https://github.com/akash-network/helm-charts).

<table><thead><tr><th>Chart Name</th><th>Description</th><th data-hidden></th></tr></thead><tbody><tr><td>akash-provider</td><td>Installs an Akash provider (required)</td><td></td></tr><tr><td>akash-hostname-operator</td><td>An operator to map Ingress objects to Akash deployments (required)</td><td></td></tr><tr><td>akash-node</td><td>Installs an Akash RPC node (required)</td><td></td></tr><tr><td>akash-inventory-operator</td><td>An operator required for persistent storage (optional)</td><td></td></tr><tr><td>akash-ip-operator</td><td>An operator required for ip marketplace (optional)</td><td></td></tr></tbody></table>
