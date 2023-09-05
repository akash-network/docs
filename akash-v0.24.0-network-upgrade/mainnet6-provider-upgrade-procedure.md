# Mainnet6 Provider Upgrade Procedure

## Overview

This is a comprehensive guide that covers the steps necessary to upgrade from Mainnet5 to Mainnet6 of Akash Network and Akash Provider components in a Kubernetes cluster.

## Provider Components to be Upgraded

* `provider-services` is the main binary of the `akash-provider`, `akash-hostname-operator`, `akash-inventory-operator`, and `akash-ip-operator` helm charts
* `akash` is the main binary of the `akash-node` helm chart

### Mainnet5 Versions

* `provider-services`: `0.2.1`
* `node`: `0.20.0`/`0.22.0` (akash network `0.20.0`)

### Mainnet6 Versions

* `provider-services`: `0.4.6`
* `node`: `0.24.0` (akash network `0.24.0`)

## Prerequisites

* ENSURE TO EXAMINE ENTIRE GUIDE PRIOR DOING ANYTHING
* Ensure Helm installed and configured
* Ensure `kubectl` is installed
* Ensure `kubectl` is configured to access your provider(s) cluster(s)
* Provider key imported on your local machine
* Environment is configured:
  * `AKASH_NODE` is set to your preferable RPC node
  * `AKASH_CHAIN_ID=akashnet-2`
* Install provider-services `v0.4.6` on your local machine

## Upgrade Procedure

IMPORTANT! Seek help if you encounter an issue at any step or have doubts! Please seek the support in the `#providers` Akash Network Devs Discord room [here](https://discord.akash.network/).

### STEP 1 - Scale down to 0 replicas the akash-provider

This step is crucial to prevent unexpected behavior during the upgrade.

> _**NOTE**_: The Akash Deployments will continue to run as usual while `akash-provider` service is stopped. The only impact is that users won't be able to perform `lease-<shell|events|logs>` against their deployments nor deploy/update or terminate them.

```
kubectl -n akash-services scale statefulsets akash-provider --replicas=0
```

### STEP 2 - Akash Provider Migration



> _**NOTE**_ - the migration procedure covered in this step is only necessary if your provider has active leases which need to be migrated for Mainnet6 provider use.  If you provider has no active leases - proeed directly to Step 3.

> _**NOTE**_ - when the dry run migration step (2.1) is run the command should output text stating "loaded CRDs" and "loaded active leases for provider".  If blank output is received instead this indicates that no active leases were found for your provider.  If the provider does in fact have active leases - please check the RPC node used for possible issue.

#### 2.1. Get the new provider-services binary file, which supports the migration

> The link to the binary files in case if you have other than x86\_64 (amd64) architecture [https://github.com/akash-network/provider/releases/tag/v0.4.6](https://github.com/akash-network/provider/releases/tag/v0.4.6)

To install `provider-services` `v0.4.6` follow this doc [https://docs.akash.network/other-resources/sandbox/detailed-steps/part-1.-install-akash](https://docs.akash.network/other-resources/sandbox/detailed-steps/part-1.-install-akash)

Verify you have installed the `provider-services` properly:

```
provider-services version
```

Expected output:

```
# provider-services version
v0.4.6
```

#### 2.2. Dry-run Provider Migration

> _**IMPORTANT**_: If the following commands returns any error, please seek the support in the #providers Akash Network Devs Discord room [here](https://discord.akash.network/)!

> _**NOTE**_: `--crd-dry-run=true` by default

> _**NOTE**_ - for the `from` switch used in the command sets, issue `provider-services keys list` if unsure what the key name should be

```
provider-services migrate v2beta2 \
--crd-v2beta1=https://raw.githubusercontent.com/akash-network/provider/v0.2.1/pkg/apis/akash.network/crd.yaml \
--crd-v2beta2=https://raw.githubusercontent.com/akash-network/provider/v0.4.6/pkg/apis/akash.network/crd.yaml \
--crd-backup-path=./crd \
--from=<KEY NAME>
```

#### 2.3. If Previous Step Succeeded - Run Actual Migration

> _**NOTE**_ - Dry-run step above make backup of existing CRDs, you'll be prompted to replace it, press y and hit Enter

```
provider-services migrate v2beta2 \
--crd-dry-run=false \
--crd-v2beta1=https://raw.githubusercontent.com/akash-network/provider/v0.2.1/pkg/apis/akash.network/crd.yaml \
--crd-v2beta2=https://raw.githubusercontent.com/akash-network/provider/v0.4.6/pkg/apis/akash.network/crd.yaml \
--crd-backup-path=./crd \
--from=<KEY NAME>
```

### STEP 3 - Upgrade the Helm Charts

> Follow these steps to upgrade various Helm charts. Make sure you've backed up your existing Helm chart configurations.

Helm charts to be upgraded are: `akash-node` (aka RPC node), `akash-provider`, `akash-hostname-operator`, `akash-inventory-operator`, and `akash-ip-operator`.

> Do not upgrade the chart if you did not have it installed previously!

In this step you'll be saving the current `akash-node`, `akash-provider`, `akash-ip-operator` chart configs as files named `akash-node-values.yml,` `akash-provider-values.yml`, `akash-ip-operator-values.yml` respectively.

We recommend switcingh into a new directory called `mainnet6-chart-configs` where you will be saving them.

> You can later move the chart config files to the directory of your choice (typically the one you originally configured & kept them at)

```
cd ~
mkdir mainnet6-chart-configs
cd mainnet6-chart-configs
```

#### 3.1. Upgrade the Repo

```
helm repo update akash
```

Verify you can see the correct chart/app versions:

```
# helm search repo akash
NAME                          	CHART VERSION	APP VERSION	DESCRIPTION                                       
akash/akash-hostname-operator 	6.0.4        	0.4.6      	An operator to map Ingress objects to Akash dep...
akash/akash-inventory-operator	6.0.4        	0.4.6      	An operator required for persistent storage (op...
akash/akash-ip-operator       	6.0.4        	0.4.6      	An operator required for ip marketplace (optional)
akash/akash-node              	6.0.0        	0.24.0     	Installs an Akash RPC node (required)             
akash/provider                	6.0.4        	0.4.6      	Installs an Akash provider (required)      
```

#### 3.2. akash-node Chart

Take the current `akash-node` chart values:

```
helm -n akash-services get values akash-node | grep -v '^USER-SUPPLIED VALUES' > akash-node-values.yml
```

Upgrade your `akash-node` chart:

> Prior to executing the Helm Upgrade command - inspect `akash-node-values.yml` for `image` tag and remove it if present.

```
helm upgrade akash-node akash/akash-node -n akash-services -f akash-node-values.yml
```

#### 3.3 akash-provider Chart

Take the current `akash-provider` chart values:

```
helm -n akash-services get values akash-provider | grep -v '^USER-SUPPLIED VALUES' > akash-provider-values.yml
```

> Prior to executing the Helm Upgrade command - inspect `akash-provider-values.yml` for `image` tag and remove it if present.

```
helm upgrade akash-provider akash/provider -n akash-services -f akash-provider-values.yml
```

> _**IMPORTANT**_: Make sure your provider is using the latest bid price script! Here is the guide that tells you how you can set it for your akash-provider chart. [https://docs.akash.network/providers/build-a-cloud-provider/akash-cloud-provider-build-with-helm-charts/step-6-provider-bid-customization](https://docs.akash.network/providers/build-a-cloud-provider/akash-cloud-provider-build-with-helm-charts/step-6-provider-bid-customization)

#### 3.4 akash-hostname-operator Chart

```
helm upgrade akash-hostname-operator akash/akash-hostname-operator -n akash-services
```

#### 3.5 akash-inventory-operator Chart

> Skip this section if your provider does not provide persistent storage.

> _**Note**_: This is not a typo, we are installing the inventory-operator without the akash- prefix.

```
helm upgrade inventory-operator akash/akash-inventory-operator -n akash-services
```

#### 3.6 akash-ip-operator Chart

> Skip this section if your provider does not provide IP leasing.

Take the current akash-ip-operator chart values:

```
helm -n akash-services get values akash-ip-operator | grep -v '^USER-SUPPLIED VALUES' > akash-ip-operator-values.yml
```

> Prior to executing the Helm Upgrade command - inspect `akash-ip-operator-values.yml` for `image` tag and remove it if present.

```
helm upgrade akash-ip-operator akash/akash-ip-operator -n akash-services -f akash-ip-operator-values.yml
```

### STEP 4 - Verify the Charts Have Been Upgraded

Perform these checks to ensure the upgrade was successful.

\
Run this command to check the pods and their versions within the `akash-services` namespace:

```
kubectl -n akash-services get pods -o custom-columns='NAME:.metadata.name,IMAGE:.spec.containers[*].image'
```

The charts upgrade went well, if you are seeing these images and versions:

* provider and operator image is: `ghcr.io/akash-network/provider:0.4.6`
* node image is: `ghcr.io/akash-network/node:0.24.0`

Example Result:

```
# kubectl -n akash-services get pods -o custom-columns='NAME:.metadata.name,IMAGE:.spec.containers[*].image'
NAME                                        IMAGE
akash-hostname-operator-86d4596d6c-pwbt8    ghcr.io/akash-network/provider:0.4.6
akash-inventory-operator-69464fbdff-dxkk5   ghcr.io/akash-network/provider:0.4.6
akash-ip-operator-6f6ddc47f8-498kj          ghcr.io/akash-network/provider:0.4.6
akash-node-1-0                              ghcr.io/akash-network/node:0.24.0
akash-provider-0                            ghcr.io/akash-network/provider:0.4.6
```

\
