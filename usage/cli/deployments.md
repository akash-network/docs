# Manage Deployments

**Usage**

```text
$ akash deployment [command]
```

> **Example**

```text
$ akash deployment help

manage deployments

Usage:
  akash deployment [command]

Available Commands:
  close       close a deployment
  create      create a deployment
  sendmani    send manifest to all deployment providers
  status      get deployment status
  update      update a deployment (*EXPERIMENTAL*)
  validate    validate deployment file

Flags:
  -h, --help   help for deployment

Global Flags:
  -d, --data string   data directory (default "~/.akash")

Use "akash deployment [command] --help" for more information about a command.
```

Use `akash deployment` to create, manage, and query your deployments.

**Available Commands**

| Command | Description |
| :--- | :--- |
| close | Close a deployment. |
| create | Create a deployment. |
| sendmani | Send manifest to all deployment providers. |
| status | Get deployment status. |
| validate | Validate deployment file. |

## `close`

> **Usage**

```text
$ akash deployment close <deployment-id> [flags]
```

> **Example**

```text
$ akash deployment close 3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42 -k my-key-name

(wait)  request close deployment
(done)  deployment closed

Close Deployment
================

Deployment ID:  3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42
Reason:         TENANT_CLOSE
Height:         1447314
Hash:           0565e7b4f0ad8462f40e30184969d3b19431b6806d961666904ed7bc3cf9fa34
```

Close one of your deployments. Deletes the pod\(s\) containing your container\(s\) and stops token transfer.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| deployment-id | string | Y | ID of the deployment to close, returned by \(`akash query deployment`\) |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. Tokens will be transferred from the account associated with this key. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
|  | --nonce | uint | N | Nonce. |

## `create`

> **Usage**

```text
$ akash deployment create <deployment-file> [flags]
```

> **Example**

```text
$ akash deployment create testnet-deployment.yml -k my-key-name
(wait)  [deploy] begin deployment from config: (...)
(wait)  [broadcast] request deployment for group(s): global
(done)  [broadcast] request accepted, deployment created with id: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450
(wait)  [auction] waiting to create buy orders(s) for 1 deployment groups(s)
(wait)  [auction] buy order (1) created with id: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2
(wait)  [auction] waiting on fulfillment(s)
(wait)  [auction] received fulfillment (1/1) with id:
        619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
(wait)  [lease] waiting on lease(s)
(done)  [auction] complete; received 1 fulfillment(s) for 1 order(s)
(wait)  [lease] received lease (1) for group (1/1) [price 56] [id
        619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44]
(wait)  [lease] send manifest to provider at http://marx.akashtest.net
(done)  [lease] manifest accepted by provider at http://marx.akashtest.net
(done)  [lease] complete; received 1 lease(s) for 1 groups(s)
(done)  [deploy] deployment complete

Deployment
==========

Deployment ID:          619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450
Deployment Groups(s):   Group:        	global
                        Requirements:
                        Resources:    	Count:  	1
                                        Price:  	500
                                        CPU:    	250
                                        Memory: 	536870912
                                        Disk:   	1000000000
Fulfillment(s):         Group:    	1
                        Price:    	56
                        Provider: 	5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44

Lease(s)
========

Lease ID:     619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
Services(s):  NAME	HOST(S) / IP(S)                          	AVAILABLE	TOTAL
              web 	niwjqcrwaqzzm8xsxhejpv.marx.akashtest.net	0        	1
              web 	147.75.39.127                            	0        	1
```

Create a new deployment. Posts your request to the chain for bidding and subsequent lease creation. Your manifest\(s\) are then sent to the winning provider\(s\), pod\(s\) created, and token transfer from your account to provider\(s\) initiated.

In the example:

* **deployment-id**: `619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450`
* **deployment-group(s)**:
* ***Group***: `2` (Group Number)
* ***Requiremetns***:
* ***Resources***:
* *** - Count ***: `1` (Number of pods)
* *** - Price ***: `500` (Given in microAKSH) \(AKSH \* 10^-6\)
* *** - CPU ***: `250`
* *** - Memory ***: `536870912` (Memory in bytes, => 512M)
* *** - Disk ***: `1000000000` (Disk memory size)
* **lease**: `619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44` \(in the form \[deployment id\]/\[deployment group number\]/\[order number\]/\[provider address\]\)
* **service URI**: `niwjqcrwaqzzm8xsxhejpv.marx.akashtest.net`
* **price**: Given in microAKSH \(AKSH \* 10^-6\).

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| deployment-file | string | Y | Absolute or relative path to your deployment file. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. |
|  | --no-wait | none | N | Exit before waiting for lease creation. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
|  | --nonce | uint | N | Nonce |

## `sendmani`

> **Usage**

```text
$ akash deployment sendmani <deployment-file> <deployment-id> [flags]
```

> **Example**

```text
$ akash deployment sendmani testnet-deployment.yml 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450 -k my-key-name
(wait)  [deploy] upload manifest for deployment (619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450)
(wait)  [deploy.sendmani] upload manifest to provider (5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44)
(done)  [deploy.sendmani] manifest received by provider (5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44)

Lease(s)
========

Lease ID: 	619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
Price:      56
State:      ACTIVE
Provider:   Address:           	5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
            Owner:             	38f05967bba460d15b8b5e15559284ea9b56b7cd
            Host URI:          	http://marx.akashtest.net
            Attributes:        	region: ewr | region_name: Parsippany, NJ | sgx: enabled | tier: 5
            Received Manifest: 	Yes
```

Sends manifest directly to a deployment's provider\(s\), using data from the deployment file. Use this command after creating a deployment using the `--no-wait` flag.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| manifest | String | Y | **?** |
| deployment-id | string | Y | ID of the deployment to for which to send the manifest, returned by \(`akash query deployment`. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## `status`

> **Usage**

```text
$ akash deployment status <deployment-id> [flags]
```

> **Example**
>
> Deployment is open

```text
$ akash deployment status 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450
Lease(s)
========

Lease ID:   	619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
Price:        56
State:        ACTIVE
Service(s):   NAME	HOST(S) / IP(S)                          	AVAILABLE	TOTAL
              web 	gerb2bwatxtxsy48age6f7.marx.akashtest.net	1        	1
              web 	147.75.39.127                            	1        	1
```

> Deployment is closed

```text
$ akash deployment close 3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42 -k my-key-name
Lease(s)
========

Lease ID:       3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42/1/2/0565e7b4f0ad8462f40e30184969d3b19431b6806d961666904ed7bc3cf9fa34
Price:          60
```

Get the state and service URI\(s\) for an open deployment.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| deployment-id | string | Y | ID of the deployment to check, returned by `akash query deployment` |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## `validate`

Validate the syntax and structure of a deployment file.

> **Usage**

```text
$ akash deployment validate <deployment-file> [flags]
```

> **Example**
>
> File passes validation

```text
$ akash deployment validate testnet-deployment.yml
ok
```

> File does not pass validation \(min price too low\)

```text
$ akash deployment validate badfile.yml
Error: group specs: group san-jose: price too low (1 >= 25 fails)
```

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| deployment-file | string | Y | Absolute or relative path to your deployment file. |

**Flags**

None
