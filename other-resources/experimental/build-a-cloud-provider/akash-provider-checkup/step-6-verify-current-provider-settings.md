# STEP 6 - Verify Current Provider Settings

## Overview

Use the steps covered in this section to verify the current settings of your running provider.

> Steps in this section assume the provider was installed via Akash Provider Helm Charts.
>
> Conduct the steps from a Kubernetes master node with `kubectl` access to the cluster.

## View Provider Current Settings

### Access Provider Pod

* Verification of current  settings will be conducted from within the Provider pod's shell
* Use the following command to gain access to the Provider's shell

```
kubectl -n akash-services exec -ti $(kubectl -n akash-services get pods -l app=akash-provider --output jsonpath='{.items[0].metadata.name}') -- bash
```

### List All Provider Settings

* Current Provider settings are obtained from the process/PID

```
cat /proc/$(pidof akash)/environ | xargs -0 -n1
```

#### Example/Sample Output

* Only head of example output shown

```
cat /proc/$(pidof akash)/environ | xargs -0 -n1

AKASH_PROVIDER_PORT_8443_TCP_PROTO=tcp
AKASH_DEPLOYMENT_BLOCKED_HOSTNAMES=
KUBERNETES_SERVICE_PORT_HTTPS=443
AKASH_BID_PRICE_MEMORY_SCALE=0.0016
KUBERNETES_SERVICE_PORT=443
AKASH_GAS=auto
AKASH_PROVIDER_SERVICE_PORT_API=8443
AKASH_BOOT_KEYS=/boot-keys
AKASH_VERSION=0.1.0
HOSTNAME=akash-provider-77bddc8c4c-qkwtz
AKASH_PROVIDER_PORT_8443_TCP_ADDR=10.233.24.154
AKASH_GAS_PRICES=0.025uakt
```

### List Specific Provider Setting

* Example command to list only the Withdraw Period from the Provider's current settings

```
cat /proc/$(pidof akash)/environ | xargs -0 -n1 | grep -i withdraw
```

#### Example/Expected Output

```
cat /proc/$(pidof akash)/environ | xargs -0 -n1 | grep -i withdraw

AKASH_WITHDRAWAL_PERIOD=1h
```
