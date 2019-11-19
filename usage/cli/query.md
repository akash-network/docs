# Query Network

**Usage**

```text
$ akash query [command]
```

**Example**

```text
$ akash query help

Query something

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
  -m, --mode string   output mode (interactive|shell|json) (default "interactive")

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
(warn)  please note, the token balance is denominated in microAKASH (AKASH * 10^-6)

Account Query
=============

Public Key Address:   8d2cb35f05ec35666bbc841331718e31415926a1
Balance:              97,264,568
Nonce:                4
```

In the example above, token balance is given in microAKSH `(AKSH * 10^-6)`.

Retrieve the details for one or more of your accounts, including token balance.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| account | string | N | One or more account addresses to query. Omitting this argument returns all your accounts for the provided key. |

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

Deployment(s)
=============

Deployment ID                                                     Tenant ID                                 State   Version
-------------                                                     ---------                                 -----   -------

127846f78612fffdacb1c6b595faaeb724ce622ff205a79c18dd68c2d0df9f54	259d3831b178ef71545e992da9ea7b580032c9dd	ACTIVE	a1085e366605fc370961ebcd0651025e3e1ca2d206e094c7bdc89a388ecc2f3a
598e8e16520fb78762c50324d5babeabc20974566743c7316522d698301de85a	259d3831b178ef71545e992da9ea7b580032c9dd	ACTIVE	a1085e366605fc370961ebcd0651025e3e1ca2d206e094c7bdc89a388ecc2f3a
...
```

Retrieve the details for one or more of your deployments. A deployment represents a request for provider resources.

In the example:

* **"state": 2**: indicates a closed deployment.  
* **version**: is a hash of the manifest, used by provider to verify incoming manifest content

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| deployment | string | N | One or more deployment ids to query. Omitting this argument returns all your deployments associated with the key provided |

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

Fulfillment(s)
==============

Fulfillment ID                                                                                                                          Price State
--------------                                                                                                                          ----- -----

01e4a443878f9eaf9b05d536e3d3322c1ecb608bc4d4930c6a8eb8502b06618c/1/2/f1695acb26884111d87e91d655fddc511a961987c846a61b62ce42f5ba1d90e7   104   CLOSED
02bff9baad284a2be88791dbf31dcde10f01bf646ceffd46cf214365adfafb67/1/2/e014d0e903e0d82a2058be384e21efa5552aad49078f0471447020fc238e3bd7   46    CLOSED
036b70a355038b9389b4dc2de72335b9e8b91a11f5193aba1061ea061a83752c/1/2/f1695acb26884111d87e91d655fddc511a961987c846a61b62ce42f5ba1d90e7   60    CLOSED
03b6f6912f88ee8854fac7b4a37ea9af1c3e95116512afc961684ca66e82944b/1/2/f1695acb26884111d87e91d655fddc511a961987c846a61b62ce42f5ba1d90e7   73    OPEN
...
```

> In the example above, `"state": CLOSED` indicates a closed fulfillment.

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

Lease(s)
========

Lease: 	9f5b7326f3b5b37d1cb2ab43ecdc0410c89e14e4f44fe12ed376879bcf0900c6/1/2/e014d0e903e0d82a2058be384e21efa5552aad49078f0471447020fc238e3bd7
Price: 	56
State: 	ACTIVE

Lease: 	01e4a443878f9eaf9b05d536e3d3322c1ecb608bc4d4930c6a8eb8502b06618c/1/2/f1695acb26884111d87e91d655fddc511a961987c846a61b62ce42f5ba1d90e7
Price: 	104
State: 	CLOSED

...

```

> In the example above, `"state": CLOSED` indicates a closed lease.

```text
$ akash query lease 01e4a443878f9eaf9b05d536e3d3322c1ecb608bc4d4930c6a8eb8502b06618c/1/2/f1695acb26884111d87e91d655fddc511a961987c846a61b62ce42f5ba1d90e7


Lease: 	01e4a443878f9eaf9b05d536e3d3322c1ecb608bc4d4930c6a8eb8502b06618c/1/2/f1695acb26884111d87e91d655fddc511a961987c846a61b62ce42f5ba1d90e7
Price: 	104
State: 	CLOSED

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

Orders(s)
=========

Order                                                                 	End At (Block)	State
-----                                                                 	--------------	-----

01e4a443878f9eaf9b05d536e3d3322c1ecb608bc4d4930c6a8eb8502b06618c/1/2  	1082995       	CLOSED
03b6f6912f88ee8854fac7b4a37ea9af1c3e95116512afc961684ca66e82944b/1/2  	1000789       	MATCHED
04759181a06e18bf33aa97ea0139d99629530398121b84a613dcc518a4a4caca/1/2  	1165374       	OPEN
...
```

Retrieve the details for one or more of your orders. An order is an internal representation of a deplyoyment group: the resources from your deployment that may be fulfilled by a single provider.

In the example:

* **"State": CLOSED**: indicates a closed order.
* **End At (Block)**: indicates the block number upon which all fulfillments must be issued, prior to awarding a lease

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

Provider(s)
===========

Address                                                         	Owner                                   	Host URI                   	Attributes
-------                                                         	-----                                   	--------                   	----------

be41ebb7499055a204ef74af75301b1dffb44aedc9bbe48ebaaa59ac6419fe29	932573d4d03b56da1b394f2293cf49a802a8dc8d	http://akash.chainvibes.com	region: nl

e014d0e903e0d82a2058be384e21efa5552aad49078f0471447020fc238e3bd7	38f05967bba460d15b8b5e15559284ea9b56b7cd	http://marx.akashtest.net  	region: ewr | region_name: Parsippany, NJ | sgx: enabled | tier: 5
f1695acb26884111d87e91d655fddc511a961987c846a61b62ce42f5ba1d90e7	7939d05bb2737bd209eb2ea2841d8aabc6406ee1	http://roy.akashtest.net   	region: sjc | region_name: Sunnyvale, US | sgx: enabled | tier: 5 
...
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
