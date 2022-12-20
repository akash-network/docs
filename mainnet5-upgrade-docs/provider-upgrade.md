---
description: Akash Provider upgrades required post Mainnet5 network upgrade
---

# Provider Upgrade

## Overview

The upgrade instructions provided in this guide pertain to Akash providers installed via Helm Charts.

If your provider was installed using Praetor, please visit the [Praetor Discord](http://discord.gg/uzUCHTF93D) server for upgrade guidance and inquiries.

> All providers _**MUST**_ upgrade their Akash Provider and related components (RPC Node only) on the date of the `Mainnet5` upgrade (December 21st 2022) to avoid disruption.  Provider RPC Nodes which are not upgrade post `Mainnet5` will be unable to bid on new orders.  Pre-existing deployments on non-upgraded providers will not incur service disruption. But the ability to bid on new deployments will be impacted until the provider's RPC nodes are upgraded to `0.20.0` .

> _**NOTE**_ - please do not attempt to upgrade your provider RPC modes until the `Mainnet5` upgrade has been completed.  The Helm Charts will be updated to the use the correct/current binaries on the day of the `Mainnet5` upgrade.

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
