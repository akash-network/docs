# Provider Status and General Info

Use the verifications included in this section for the following purposes:

* [Determine Provider Status](provider-status-and-general-info.md#provider-status)
* [Review Provider Configuration](provider-status-and-general-info.md#provider-configuration-review)
* [Current Versions of Provider's Akash and Kubernetes Installs](provider-status-and-general-info.md#current-versions-of-providers-akash-and-kubernetes-installs)&#x20;

## Provider Status

Obtain live Provider status including:

* Number of active leases
* Active leases and hard consumed by those leases
* Available resources on a per node basis

### Command Template

Issue the commands in this section from any machine that has the [Akash CLI ](../../guides/cli/detailed-steps/)installed.

```
provider-services status <provider-address>
```

### Example Command Use

```
provider-services status akash1q7spv2cw06yszgfp4f9ed59lkka6ytn8g4tkjf
```

### Example Output

```
provider-services status akash1wxr49evm8hddnx9ujsdtd86gk46s7ejnccqfmy
{
  "cluster": {
    "leases": 3,
    "inventory": {
      "active": [
        {
          "cpu": 8000,
          "memory": 8589934592,
          "storage_ephemeral": 5384815247360
        },
        {
          "cpu": 100000,
          "memory": 450971566080,
          "storage_ephemeral": 982473768960
        },
        {
          "cpu": 8000,
          "memory": 8589934592,
          "storage_ephemeral": 2000000000000
        }
      ],
      "available": {
        "nodes": [
          {
            "cpu": 111495,
            "memory": 466163988480,
            "storage_ephemeral": 2375935850345
          },
          {
            "cpu": 118780,
            "memory": 474497601536,
            "storage_ephemeral": 7760751097705
          },
          {
            "cpu": 110800,
            "memory": 465918152704,
            "storage_ephemeral": 5760751097705
          },
          {
            "cpu": 19525,
            "memory": 23846356992,
            "storage_ephemeral": 6778277328745
          }
        ]
      }
    }
  },
  "bidengine": {
    "orders": 0
  },
  "manifest": {
    "deployments": 0
  },
  "cluster_public_hostname": "provider.bigtractorplotting.com"
}
```

## Provider Configuration Review

Review the Provider’s attribute, and Host URI with the status command

### Command Template

Issue the commands in this section from any machine that has the [Akash CLI](broken-reference) installed.

```
provider-services query provider get <akash-address>
```

### Example Command Use

```
provider-services query provider get <address>
```

### Example Output

```
attributes:
- key: capabilities/storage/1/class
  value: default
- key: capabilities/storage/1/persistent
  value: "true"
- key: capabilities/storage/2/class
  value: beta2
- key: capabilities/storage/2/persistent
  value: "true"
- key: host
  value: akash
- key: organization
  value: akash.network
- key: region
  value: us-west
- key: tier
  value: community
- key: provider
  value: "1"
- key: chia-plotting
  value: "true"
host_uri: https://provider.mainnet-1.ca.aksh.pw:8443
info:
  email: ""
  website: ""
owner: akash1q7spv2cw06yszgfp4f9ed59lkka6ytn8g4tkjf
```

## Current Versions of Provider's Akash and Kubernetes Installs

* Command may be issued from any source with internet connectivity

```
curl -sk https://provider.mainnet-1.ca.aksh.pw:8443/version | jq,    
```
