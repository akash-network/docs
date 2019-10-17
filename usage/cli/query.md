# Query Network

**Usage**

```text
$ akash query [command]
```

**Example**

```text
$ akash query help

query something

Usage:
  akash query [command]

Available Commands:
  account          query account
  deployment       query deployment
  deployment-group query deployment groups
  fulfillment      query fulfillment
  lease            query lease
  order            query order
  provider         query provider

Flags:
  -h, --help          help for query
  -n, --node string   node host (default "http://api.akashtest.net:80")

Global Flags:
  -d, --data string   data directory (default "~/.akash")

Use "akash query [command] --help" for more information about a command.
```

Use `akash query` to query all the things that need querying.

**Available Commands**

| Command | Description |
| :--- | :--- |
| account | Query account details. |
| deployment | Query deployment details. |
| deployment-group | Query deployment-group details. |
| fulfillment | Query fulfillment details. |
| lease | Query lease details. |
| order | Query order details. |
| provider | Query provider details. |

# `account`

**Usage**

```text
akash query account [account ...] [flags]
```

**Example**

```text
$ akash query account -k my-key-name
{
  "address": "8d2cb35f05ec35666bbc841331718e31415926a1",
  "balance": 90351025,
  "nonce": 7
}
```

In the example above, token balance is given in microAKSH `(AKSH * 10^-6)`.

Retrieve the details for one or more of your accounts, including token balance.

**Arguments**

Argument \| Type \| Required \| Description \| \|:--\|:--\|:--\|:--\| \| account \| string \| N \| One or more account addresses to query. Omitting this argument returns all your accounts for the provided key. \|

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## `deployment`

**Usage**

```text
akash query deployment [deployment ...] [flags]
```

**Example**

```text
$ akash query deployment -k alpha

{
  "items": [
    {
      "address": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
      "tenant": "8d2cb35f05ec35666bbc841331718e31415926a1",
      "state": 2,
      "version": "8e02ba39187cbd2de194a7ac3b31ffe9889856d4b817fc039669e569fde6c647"
    },
    {
      "address": "4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8",
      "tenant": "8d2cb35f05ec35666bbc841331718e31415926a1",
      "version": "8e02ba39187cbd2de194a7ac3b31ffe9889856d4b817fc039669e569fde6c647"
    },
...
  ]
}
```

Retrieve the details for one or more of your deployments. A deployment represents a request for provider resources.

In the example:

* **"state": 2**: indicates a closed deployment.  
* **version**: is a hash of the manifest, used by provider to verify incoming manifest content

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| deployment | string | N | One or more deployment ids to query. Omitting this argument returns all your deployments. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## `fulfillment`

**Usage**

```text
akash query fulfillment [fulfillment ...] [flags]
```

**Example**

```text
$ akash query fulfillment
{
  "items": [
    {
      "id": {
        "deployment": "2a15e3d0a5ed9201f46f9d4c8e0a80579d202b6bee90ff7fac613f1b289bdf9d",
        "group": 1,
        "order": 2,
        "provider": "4be226880fce4efd19f81c87cebc86bf001e05a7aae7b862d421f3ec36f9e345"
      },
      "price": 71
    },
    {
      "id": {
        "deployment": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
        "group": 1,
        "order": 2,
        "provider": "5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44"
      },
      "price": 73,
      "state": 2
    },
...
  ]
}
```

> In the example above, `"state": 2` indicates a closed fulfillment.

Retrieve the details for one or more fulfillments made for your deployments. A fulfillment represents a provider's bid on your deployments.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| fulfillment | string | N | One or more fulfillment ids to query. Omitting this argument returns all fulfillments that resulted in leases. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## `lease`

**Usage**

```text
$ akash query lease [lease ...] [flags]
```

**Example**

```text
$ akash query lease -k my-key-name
{
  "items": [
    {
      "id": {
        "deployment": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
        "group": 1,
        "order": 2,
        "provider": "d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737"
      },
      "price": 52,
      "state": 2
    },
    {
      "id": {
        "deployment": "4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8",
        "group": 1,
        "order": 2,
        "provider": "5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44"
      },
      "price": 48
    },
...
  ]
}
```

> In the example above, `"state": 2` indicates a closed lease.

```text
$ akash query lease 3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42/1/2/d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737
{
  "id": {
    "deployment": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
    "group": 1,
    "order": 2,
    "provider": "d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737"
  },
  "price": 52,
  "state": 2
}
```

> In the example above, the lease is specified in the form `[deployment id]/[deployment group number]/[order number]/[provider address]` and the `-k` flag is not required.

Retrieve the details for one or more of your leases. A lease represents an agreement between you and the lowest-bidding provider to provide resources as for the price specified in their fullfillment.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| lease | string | N | One or more leases to query. Omitting this argument returns all your leases. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Conditional | Name of one of your keys, for authentication. Required when fetching all an account's leases, but not when fetching one lease. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## `order`

**Usage**

```text
$ akash query order [order ...] [flags]
```

**Example**

```text
$ akash query order
{
  "items": [
    {
      "id": {
        "deployment": "16bfd04ba37ca64ba675e47d2fb5fcab6c5c3c3e949d71f0012cd65a81dd6507",
        "group": 1,
        "seq": 2
      },
      "endAt": 3519,
      "state": 2
    },
    {
      "id": {
        "deployment": "2a15e3d0a5ed9201f46f9d4c8e0a80579d202b6bee90ff7fac613f1b289bdf9d",
        "group": 1,
        "seq": 2
      },
      "endAt": 204,
      "state": 1
    },
...
  ]
}
```

Retrieve the details for one or more of your orders. An order is an internal representation of a deplyoyment group: the resources from your deployment that may be fulfilled by a single provider.

In the example:

* **"state": 2**: indicates a closed order.
* **endAt**: indicates the block number upon which all fulfillments must be issued, prior to awarding a lease

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| order | string | N | One or more order ids to query. Omitting this argument returns all your orders. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## `provider`

**Usage**

```text
$ akash query provider [provider ...] [flags]
```

**Example**

```text
$ akash query provider
{
  "providers": [
    {
      "address": "0253c080e189825da0e072ed8213947bb5d9386f4504ab9c15a15f5776600e83",
      "owner": "73ff91326664be3dad53b3b58e9d1fe08dfbec74",
      "hostURI": "http://provider.ewr.caladan.akashtest.net",
      "attributes": [
        {
          "name": "region",
          "value": "ewr"
        }
      ]
    },
    {
      "address": "4be226880fce4efd19f81c87cebc86bf001e05a7aae7b862d421f3ec36f9e345",
      "owner": "e6956171534f8ffbcf47c6830788df4ebbb165a9",
      "hostURI": "http://provider.sjc.arrakis.akashtest.net",
      "attributes": [
        {
          "name": "region",
          "value": "sjc"
        }
      ]
    },
...
  ]
}
```

Retrieve the attributes of one or more providers.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| provider | string | N | One or more provider ids to query. Omitting this argument returns all providers in the network. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
