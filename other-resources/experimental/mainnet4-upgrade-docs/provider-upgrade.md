---
description: >-
  Akash Provider upgrade to version 0.18.0 required post Mainnet4 network
  upgrade
---

# Provider Upgrade

## Overview

The upgrade instructions provided in this guide pertain to Akash providers installed via Helm Charts.

If your provider was installed using Praetor, please visit the [Praetor Discord](http://discord.gg/uzUCHTF93D) server for upgrade guidance and inquiries.

> All providers _**MUST**_ upgrade their Akash Provider and related components (RPC Node, CRDs, etc) on the date of the `Mainnet4` upgrade (November 17th 2022) to avoid disruption.  Providers which are not upgrade post `Mainnet4` will be unable to bid on new orders.  Pre-existing deployments on non-upgraded providers will not incur service disruption. But the ability to bid on new deployments, allow container shell access, and other features will be impacted until the provider is upgraded to `0.18.0`.

> _**NOTE**_ - please do not attempt to upgrade your provider until the `Mainnet4` upgrade has been completed.  The Helm Charts will be updated to the use the `0.18.0` binary on the day of the `Mainnet4` upgrade.

## Provider Upgrade Procedure

### Update Local Helm Repo

```
helm repo update akash
```

### RPC Node

```
helm -n akash-services get values akash-node | grep -v '^USER-SUPPLIED VALUES' > akash-node-values.yml
```

* Prior to executing the Helm Upgrade command - inspect `akash-node-values.yml` for `image tag` and remove it if present

```
helm upgrade akash-node akash/akash-node -n akash-services -f akash-node-values.yml
```

### Akash Provider

```
helm -n akash-services get values akash-provider | grep -v '^USER-SUPPLIED VALUES' > akash-provider-values.yml
```

* Prior to executing the Helm Upgrade command - inspect `akash-provider-values.yml` for `image tag` and remove it if present

```
helm upgrade akash-provider akash/provider -n akash-services -f akash-provider-values.yml
```

### Hostname Operator

```
helm upgrade hostname-operator akash/akash-hostname-operator -n akash-services
```

### Inventory Operator

* Only necessary if providing persistent storage

```
helm upgrade inventory-operator akash/akash-inventory-operator -n akash-services
```

### Ingress Controller (Optional)

```
helm -n ingress-nginx get values akash-ingress | grep -v '^USER-SUPPLIED VALUES' > akash-ingress-values.yml
```

* Prior to executing the Helm Upgrade command - inspect `akash-ingress-values.yml` for image tag and remove it if present

```
helm upgrade akash-ingress akash/akash-ingress -n ingress-nginx -f akash-ingress-values.yml
```
