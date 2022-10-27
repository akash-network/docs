# Build a Cloud Provider

Become an Akash provider and make profit on your spare compute made available for tenant lease.

Our curated guide to building your decentralized provider follows these sequential steps.

* **STEP 1** - [Build the Kubernetes Cluster for your Provider](kubernetes-cluster-for-akash-providers/)
* **STEP 2** - [Build your Cloud Provider via Helm Charts](akash-cloud-provider-build-with-helm-charts/)
* **STEP 3** - [Complete a CheckUp of your New Provider](akash-provider-checkup/)
* **STEP 4** - [Enable Persistent Storage on your Cloud Provider](helm-based-provider-persistent-storage-enablement/)
* **STEP 5** - [Provider Troubleshooting](akash-provider-troubleshooting/)

## Helm Chart Repository for Akash Providers

The steps outlined above will guide the user through the creation of an Akash Provider and necessary components.  The table below clarifies required and optional Helm Charts in the Provider build process.

The Akash Helm Chart repository can be accessed [here](https://github.com/ovrclk/helm-charts).

| Chart Name               | Description                                                        |   |
| ------------------------ | ------------------------------------------------------------------ | - |
| akash-provider           | Installs an Akash provider (required)                              |   |
| akash-ingress            | Installs the Akash Ingress resources (required)                    |   |
| akash-hostname-operator  | An operator to map Ingress objects to Akash deployments (required) |   |
| akash-node               | Installs an Akash RPC node (required)                              |   |
| akash-inventory-operator | An operator required for persistent storage (optional)             |   |
| akash-ip-operator        | An operator required for ip marketplace (optional)                 |   |
| akash-metallb            | A dependency required for ip marketplace (optional)                |   |
