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
Closing deployment
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
619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450
Waiting...
Group 1/1 Fulfillment: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=57]
Group 1/1 Fulfillment: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737 [price=70]
Group 1/1 Lease: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=57]
Sending manifest to http://provider.ewr.salusa.akashtest.net...
Service URIs for provider: 5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
    webapp: webapp.48bc1ea9-c2aa-4de3-bbfb-5e8d409ae334.147-75-193-181.aksh.io
```

Create a new deployment. Posts your request to the chain for bidding and subsequent lease creation. Your manifest\(s\) are then sent to the winning provider\(s\), pod\(s\) created, and token transfer from your account to provider\(s\) initiated.

In the example:

* **deployment-id**: `619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450`
* **lease**: `619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44` \(in the form \[deployment id\]/\[deployment group number\]/\[order number\]/\[provider address\]\)
* **service URI**: `webapp.48bc1ea9-c2aa-4de3-bbfb-5e8d409ae334.147-75-193-181.aksh.io`
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
lease: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
    webapp: webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io
```

> Deployment is closed

```text
$ akash deployment close 3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42 -k my-key-name
```

Get the lease and service URI\(s\) for an open deployment.

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
