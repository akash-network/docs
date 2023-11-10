# Mainnet8 Provider Upgrade Procedure

## Overview

This is a comprehensive guide that covers the steps necessary to upgrade from Mainnet5 to Mainnet6 of Akash Network and Akash Provider components in a Kubernetes cluster.

## Provider Components to be Upgraded

* `provider-services` is the main binary of the `akash-provider`, `akash-hostname-operator`, `akash-inventory-operator`, and `akash-ip-operator` helm charts
* `akash` is the main binary of the `akash-node` helm chart

### Mainnet6 Versions (Pre-Upgrade)

* `provider-services`: `0.4.6`
* `node`: `0.26.0`

### Mainnet8 Versions  (Post-Upgrade)

* `provider-services`: X.X.X
* `node`: `0.28.0`

## Upgrade Procedure

IMPORTANT! Seek help if you encounter an issue at any step or have doubts! Please seek the support in the `#providers` Akash Network Devs Discord room [here](https://discord.akash.network/).

### STEP 1 - Scale down to 0 replicas the akash-provider

This step is crucial to prevent unexpected behavior during the upgrade.

> _**NOTE**_: The Akash Deployments will continue to run as usual while `akash-provider` service is stopped. The only impact is that users won't be able to perform `lease-<shell|events|logs>` against their deployments nor deploy/update or terminate them.

```
kubectl -n akash-services scale statefulsets akash-provider --replicas=0
```

### STEP 2 - Upgrade the Helm Charts

> Follow these steps to upgrade various Helm charts. Make sure you've backed up your existing Helm chart configurations.

Helm charts to be upgraded are: `akash-node` (aka RPC node), `akash-provider`, `akash-hostname-operator`, `akash-inventory-operator`, and `akash-ip-operator`.

#### 2.1. Upgrade the Repo

```
helm repo update akash
```

Verify you can see the correct chart/app versions:



VERSIONS NEED UPDATING

```
# helm search repo akash
NAME                          	CHART VERSION	APP VERSION	DESCRIPTION                                       
akash/akash-hostname-operator 	6.0.4        	0.4.6      	An operator to map Ingress objects to Akash dep...
akash/akash-inventory-operator	6.0.4        	0.4.6      	An operator required for persistent storage (op...
akash/akash-ip-operator       	6.0.4        	0.4.6      	An operator required for ip marketplace (optional)
akash/akash-node              	6.0.0        	0.24.0     	Installs an Akash RPC node (required)             
akash/provider                	6.0.4        	0.4.6      	Installs an Akash provider (required)      
```

#### 2.2. akash-node Chart

Take the current `akash-node` chart values:

```
helm -n akash-services get values akash-node | grep -v '^USER-SUPPLIED VALUES' > akash-node-values.yml
```

Upgrade your `akash-node` chart:

> Prior to executing the Helm Upgrade command - inspect `akash-node-values.yml` for `image` tag and remove it if present.

```
helm upgrade akash-node akash/akash-node -n akash-services -f akash-node-values.yml
```

#### 2.3 akash-provider Chart

Take the current `akash-provider` chart values:

```
helm -n akash-services get values akash-provider | grep -v '^USER-SUPPLIED VALUES' > akash-provider-values.yml
```

> Prior to executing the Helm Upgrade command - inspect `akash-provider-values.yml` for `image` tag and remove it if present.

```
helm upgrade akash-provider akash/provider -n akash-services -f akash-provider-values.yml
```

> _**IMPORTANT**_: Make sure your provider is using the latest bid price script! Here is the guide that tells you how you can set it for your akash-provider chart. [https://docs.akash.network/providers/build-a-cloud-provider/akash-cloud-provider-build-with-helm-charts/step-6-provider-bid-customization](https://docs.akash.network/providers/build-a-cloud-provider/akash-cloud-provider-build-with-helm-charts/step-6-provider-bid-customization)

#### 2.4 akash-hostname-operator Chart

```
helm upgrade akash-hostname-operator akash/akash-hostname-operator -n akash-services
```

#### 2.5 akash-inventory-operator Chart

> Skip this section if your provider does not provide persistent storage.

> _**Note**_: This is not a typo, we are installing the inventory-operator without the akash- prefix.

```
helm upgrade inventory-operator akash/akash-inventory-operator -n akash-services
```

#### 2.6 akash-ip-operator Chart

> Skip this section if your provider does not provide IP leasing.

Take the current akash-ip-operator chart values:

```
helm -n akash-services get values akash-ip-operator | grep -v '^USER-SUPPLIED VALUES' > akash-ip-operator-values.yml
```

> Prior to executing the Helm Upgrade command - inspect `akash-ip-operator-values.yml` for `image` tag and remove it if present.

```
helm upgrade akash-ip-operator akash/akash-ip-operator -n akash-services -f akash-ip-operator-values.yml
```

### STEP 3 - Verify the Charts Have Been Upgraded

Perform these checks to ensure the upgrade was successful.

\
Run this command to check the pods and their versions within the `akash-services` namespace:

```
kubectl -n akash-services get pods -o custom-columns='NAME:.metadata.name,IMAGE:.spec.containers[*].image'
```

The charts upgrade went well, if you are seeing these images and versions:

* provider and operator image is: `ghcr.io/akash-network/provider:0.4.6`
* node image is: `ghcr.io/akash-network/node:0.28.0`

Example Result:



VERSIONS NEED TO BE UPDATED

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
