# Akash Provider Feature Discovery Upgrade/Enablement

> _**NOTE**_ - do NOT use these instructions until they have been migrated out of experimental and the Akash core team has communicated it is safe to execute.

## Overview

The following provides an overview of the steps necessary to upgrade your Akash provider to version _**X.X.X**_ and to enable Feature Discovery:

* [Akash Hostname Operator Upgrade](akash-provider-feature-discovery-upgrade-enablement.md#akash-hostname-operator-upgrade)
* [Akash Provider Upgrade](akash-provider-feature-discovery-upgrade-enablement.md#akash-provider-upgrade)
* [Akash Inventory Operator Install/Upgrade](akash-provider-feature-discovery-upgrade-enablement.md#akash-inventory-operator-install-upgrade)
* [Akash IP Operator Upgrade (If Applicable)](akash-provider-feature-discovery-upgrade-enablement.md#akash-ip-operator-upgrade-if-applicable)

### Akash Hostname Operator Upgrade

```
helm update

helm uninstall akash-hostname-operator -n akash-services

helm install akash-hostname-operator -n akash-services
```

### Akash Provider Upgrade

```
helm uninstall akash-provider -n akash-services

helm install -n akash-services -f /root/provider/provider.yaml
```

### Akash Inventory Operator Install/Upgrade

> _**NOTE**_ - the Inventory Operator is now required on ALL Akash Providers.  Previously this operator was only required when the Provider hosted persistent storage.  But the operator is now mandated on all providers.

```
helm uninstall inventory-operator -n akash-services

helm install inventory-operator akash-inventory-operator-8.0.0.tgz -n akash-services --set image.tag=0.5.0-rc13
```

### Akash IP Operator Upgrade (If Applicable)

> _**NOTE**_ - the IP Operator is only necessary if your Akash Provider provides IP Leases

```
helm uninstall akash-ip-operator -n akash-services

helm install akash-ip-operator akash/akash-ip-operator -n akash-services --set provider_address=<provider-address>
```
