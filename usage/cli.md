# Command Line

## Akash Command Line Utlity

This section describes usage of the Akash client for requesting and managing deployments to the Akash Network.

### Installation

The Akash Suite is composed of a full node `akashd` and the client `akash`. The full node \(`akashd`\) is the \(tendermint-based\) blockchain node that implements the decentralized exchange. `akash` is the client used to access the exchange and network in general.



{% tabs %}
{% tab title="Mac O" %}
**Using Homebrew**

```text
brew install ovrclk/tap/akash
```

If you dont have Homebrew installed, run the below to install:

```text
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
{% endtab %}

{% tab title="Linux" %}
Download the latest release from  [release page](https://github.com/ovrclk/akash/releases). 

The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.
{% endtab %}

{% tab title="Windows" %}
Download the [windows archive](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_windows_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows) contains instructions for setting the PATH on Windows.
{% endtab %}
{% endtabs %}

### MacOS

> Install Homebrew

```text
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

> Install `akash` client and `akashd` daemon using homebrew

```text
$ brew install ovrclk/tap/akash
```

The simplest way to install is by using [homebrew](https://brew.sh). Install `akash` client by running `brew install ovrclk/tap/akash`. Once installed, verify the installation by running `akash version`.

Alternatively, you can manually download the [binaries](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_darwin_amd64.tar.gz) from the [releases page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version. The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on MacOS.

### Linux

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_linux_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the terraform binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

### Windows

Download the [windows archive](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_windows_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows) contains instructions for setting the PATH on Windows.

### Others \(From Source\)

> Installing akash suite from source

```text
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.8+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Additional requirements are:

* [glide](https://github.com/Masterminds/glide): Golang library management.

For development environments, requirements include:

* [protocol buffers](https://developers.google.com/protocol-buffers/): Protobuf compiler.

Most golang libraries will be packaged in the local `vendor/` directory via [glide](https://github.com/Masterminds/glide), however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [gogoprotobuf](https://github.com/gogo/protobuf): Golang protobuf compiler plugin.
* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akash` and `akashd` using `make install`

### The Akash TestNet

The Akash testnet is available for public use. A description of the testnet, registration instructions, and a getting-started guide may be found [here](https://github.com/ovrclk/docs/tree/85e4b806da57673f6c5577754d41aa8b543a0f8c/usage/guides/testnet/README.md).

### Modes

Akash CLI provides an `interactive` mode designed for human usage and `json` and `shell` optimized for machine usage. Mode is using `--mode` or `-m`.

#### Interactive

[![asciicast](https://asciinema.org/a/kfgNylCa0BhLu5AT2kvGHbg3m.svg)](https://asciinema.org/a/kfgNylCa0BhLu5AT2kvGHbg3m?autoplay=1)

#### Shell

Shell mode is optimized for using Akash with shell programs. For examples:

```text
$ akash key create alice -m shell | tee -a alice

akash_create_key_0_name="alice"
akash_create_key_0_public_key="10ee882d643c645fd793a7b2dcb1380cbaf2de40"
akash_create_key_0_recovery_codes="basic creek call choose swim run horror globe argue bunker rent harvest forum excuse carpet boil toward pride alter bronze already neck body humor"

$ source alice

$ echo $akash_create_key_0_public_key
10ee882d643c645fd793a7b2dcb1380cbaf2de40
```

#### JSON

Example using json mode and jq

```text
$ akash key create alice -m json  | jq

{
  "create_key": [
    {
      "name": "alice",
      "public_key": "d57d1f91ee04a283ed7150ed6700ea03508090f3",
      "recovery_codes": "spike erosion glue head cool network city flavor frequent tube soda funny hen outer bag pause diesel else brick toy list skirt art vacuum"
    }
  ]
}
{
  "raw": {
    "name": "alice",
    "pubkey": [ 2, 183, 238, 17, 107, 252, 161, 155, 151, 213, 43, 236, 145, 193, 171, 10, 17, 105, 141, 207, 226, 227, 220, 59, 56, 211, 30, 235, 169, 179, 228, 210, 216 ],
    "privkey.armor": "-----BEGIN TENDERMINT PRIVATE KEY-----\nkdf: bcrypt\nsalt: C06BE82D0FAF06C3877361DFFA51F510\n\nYbNEF8iXqWLxbc2oGKoOXohWP8w0hr5BJV9kQWw9OBTPnp3Ym+caCW+Ipe7zgIAR\ndaJzRpc6dVtwoyvAyhSL1870Q1ea5AeU8gYHWkY=\n=+HTx\n-----END TENDERMINT PRIVATE KEY-----"
  }
}
```

### Top-level commands

> You can access help using `akash help`:

These commands are presented as an overview of the features available via the Akash client. Individual command usage is described in subsequent sections.

```text
$ akash help
```

> Outputs:

```text
Akash CLI Utility.

Akash is a peer-to-peer marketplace for computing resources and
a deployment platform for heavily distributed applications.
Find out more at https://akash.network

Usage:
  akash [command]

Available Commands:
  deployment  Manage deployments
  help        Help about any command
  key         Manage keys
  logs        Service logs
  marketplace Monitor marketplace
  provider    Manage provider
  query       Query something
  send        Send tokens
  status      Display node status
  version     Display version

Flags:
  -d, --data string   data directory (default "/Users/gosuri/.akash")
  -h, --help          help for akash
  -m, --mode string   output mode (interactive|shell|json) (default "interactive")

Use "akash [command] --help" for more information about a command.
```

| Command | Description |
| :--- | :--- |
| [deployment](cli.md#manage-deployments) | Manage deployments. |
| [key](cli.md#manage-keys) | Manage keys. |
| [logs](cli.md#display-logs) | Service logs |
| [marketplace](cli.md#monitor-marketplace) | Monitor marketplace. |
| [provider](cli.md#manage-providers) | Manage provider. |
| [query](cli.md#query-network) | Query things that need querying. |
| [send](cli.md#transfer-tokens) | Send tokens to an account. |
| [status](cli.md#check-network-status) | Get remote node status. |
| [version](cli.md#check-version) | Print Akash version. |

**Flags**

Every command accepts the following flags. For brevity, they are omitted from the following documentation.

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -h | --help | None | N | Help for any command. |
| -d | --data | String | N | User data directory \(defaults to `~/.akash`\). |

## Manage Deployments

> **Usage**

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

### `close`

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

### `create`

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

Create a new deployment. Posts your requested to the chain for bidding and subsequent lease creation. Your manifest\(s\) are then sent to the winning provider\(s\), pod\(s\) created, and token transfer from your account to provider\(s\) initiated.

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

### `sendmani`

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

### `status`

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

### `validate`

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

## Manage Keys

> **Usage**

```text
$  akash key [subcommand]
```

> **Example**

```text
$  akash key help

Key commands

Usage:
  akash key [command]

Available Commands:
  create      Create new key
  list        list keys
  show        display a key

Flags:
  -h, --help   help for key

Global Flags:
  -d, --data string   data directory (default "~/.akash")

Use "akash key [command] --help" for more information about a command.
```

Use `akash key` to create and manage your keys.

**Available Commands**

| Command | Description |
| :--- | :--- |
| create | Create new key |
| list | List all your keys |
| show | Display a single key |

### `create`

> **Usage**

```text
akash key create <key-name> [flags]
```

> **Example**

```text
$ akash key create my-key-name
8d2cb35f05ec35666bbc841331718e31415926a1
```

Create a new key to use in the Akash Network. A key links to an Akash account and is used to authenticate to the network.

In the example:

**key value**: `8d2cb35f05ec35666bbc841331718e31415926a1`

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| key-name | string | Y | A meaningful-to-you name for your key. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -t | --type | \(ed25519\|secp256k1\|ledger\) | N | Type of key \(default "ed25519"\). |

### `list`

> **Usage**

```text
$ akash key list [flags]
```

> **Example**

```text
$ akash key list

my-key-name         8d2cb35f05ec35666bbc841331718e31415926a1
my-other-key-name     35c055f1fa38cb1864e484a1d733a58bbffb1156
```

List all your local keys.

**Arguments**

None

**Flags**

None

### `show`

> **Usage**

```text
$ akash key show <key-name> [flags]
```

> **Example**

```text
$ akash key show my-key-name
8d2cb35f05ec35666bbc841331718e31415926a1
```

Show the key value belonging to a key name.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| key-name | string | Y | Name of the key to display. |

**Flags**

None

## Display Logs

> **Usage**

```text
$ akash logs <service> <lease> [flags]
```

> **Example**

```text
$ akash logs webapp 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 -f
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.307976982Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET / HTTP/1.1" 200 3583 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.614215684Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET /css/main.css HTTP/1.1" 200 195072 "http://webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.712794998Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET /images/qr.png HTTP/1.1" 200 7039 "http://webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
```

> In the example above, `webapp` is a simple web page serving static content.

Use `akash logs` to tail the application logs for each of your services.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| service | string | Y | The service name originally defined in your deployment file |
| lease | string | Y | The lease ID belonging to that service, returned by `akash deployment status` |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -f | --follow | none | N | Whether update the console with new log lines or simply return the last n lines defined by `-l`. |
| -l | --lines | uint | N | Number of lines from the end of the logs to show per service \(default 10\). |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## Monitor Marketplace

> **Usage**

```text
$ akash marketplace [flags]
```

> **Example**

```text
$ akash marketplace
DEPLOYMENT CREATED    4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8 created by 35c055f1fa38cb1864920e2a7619d4f95d18c125
ORDER CREATED    4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2
FULFILLMENT CREATED    4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2 by 5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=48]
FULFILLMENT CREATED    4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2 by d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737 [price=54]
LEASE CREATED    4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2 by 5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=48]
```

> In the example above, `price` is given in microAKSH \(AKSH \* 10^-6\).

Use `akash marketplace` for monitoring marketplace transactions.

**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## Manage Providers

> **Usage**

```text
akash provider [command]
```

> **Example**

```text
$ akash provider help

manage provider

Usage:
  akash provider [command]

Available Commands:
  closef      close an open fulfillment
  closel      close an active lease
  create      create a provider
  run         respond to chain events
  status      print status of (given) providers

Flags:
  -h, --help          help for provider
  -n, --node string   node host (default "http://api.akashtest.net:80")

Global Flags:
  -d, --data string   data directory (default "~/.akash")

Use "akash provider [command] --help" for more information about a command.
```

Use `akash provider` to manage provider\(s\)

**Available Commands**

| Command | Description |
| :--- | :--- |
| closef | Close an open fulfillment. Used by providers; not documented here. |
| closel | Close an active lease. Used by providers; not documented here. |
| create | Create a provider. Used by providers; not documented here. |
| run | Respond to chain events. Used by providers; not documented here. |
| status | Print provider details. |

`akash provider` is used to manage providers. This command is intended for providers, so this section will only address commands that are useful for a client creating and managing deployments.

### `status`

Retrieve the attributes and status of one or more providers.

> **Usage**

```text
$ akash provider status [<provider-id> ...] [flags]
```

> **Example**

```text
$ akash provider status d714ecb330d5a3873bdc88e9fce10dab1a65287fac4fe55c80ac48776fa83276
[
 {
  "Provider": {
   "address": "d714ecb330d5a3873bdc88e9fce10dab1a65287fac4fe55c80ac48776fa83276",
   "owner": "59e018689248c527ed8a755a9c67ec647ce77d28",
   "hostURI": "http://provider.sjc.arrakis.akashtest.net",
   "attributes": [
    {
     "name": "region",
     "value": "sjc"
    }
   ]
  },
  "Status": {
   "code": 200,
   "version": {
    "version": "0.3.3",
    "commit": "4786994cf709e2829aadf64d05b07212e4a8ce28",
    "date": "2018-07-31T20:43:05Z"
   },
   "message": "OK"
  }
 }
```

**Arguments**

None

**Flags**

None

## Query Network

> **Usage**

```text
$ akash query [command]
```

> **Example**

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

### `account`

> **Usage**

```text
akash query account [account ...] [flags]
```

> **Example**

```text
$ akash query account -k my-key-name
{
  "address": "8d2cb35f05ec35666bbc841331718e31415926a1",
  "balance": 90351025,
  "nonce": 7
}
```

> In the example above, token balance is given in microAKSH `(AKSH * 10^-6)`.

Retrieve the details for one or more of your accounts, including token balance.

**Arguments**

Argument \| Type \| Required \| Description \| \|:--\|:--\|:--\|:--\| \| account \| string \| N \| One or more account addresses to query. Omitting this argument returns all your accounts for the provided key. \|

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

### `deployment`

> **Usage**

```text
akash query deployment [deployment ...] [flags]
```

> **Example**

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

### `fulfillment`

> **Usage**

```text
akash query fulfillment [fulfillment ...] [flags]
```

> **Example**

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

### `lease`

> **Usage**

```text
$ akash query lease [lease ...] [flags]
```

> **Example**

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

### `order`

> **Usage**

```text
$ akash query order [order ...] [flags]
```

> **Example**

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

### `provider`

> **Usage**

```text
$ akash query provider [provider ...] [flags]
```

> **Example**

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

## Transfer Tokens

> **Usage**

```text
akash send <amount> <to-account> [flags]
```

> **Example**

```text
$ akash send 1.1 35c055f1fa38cb1864e484a1d733a58bbffb1156 -k alpha
Sent 1.1 tokens to 35c055f1fa38cb1864e484a1d733a58bbffb1156 in block 61049
```

> In the example above, the amount is given in AKSH. You may also specify the amount in microAKSH \(AKSH \* 10^-6\) using the `u` unit suffix \(e.g. `100u` for 100 microAKSH\).

Use `akash send` to send tokens from one account to another.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| amount | float | Y | The amount of tokens to send. |
| to-account | string | Y | The key value for the recipient account. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. Tokens will be sent from this account. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
|  | --nonce | uint | N | Nonce. |

## Check Network Status

> **Usage**

```text
akash status [flags]
```

> **Example**

```text
$ akash status
Block: 61553
Block Hash: 734FBC125E094CBC18311B85B3D278E820891D06
```

Use `akash status` to get the status of a remote node.

**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

## Check Version

> **Usage**

```text
$ akash version [flags]
```

> **Example**

```text
$ akash version
version:  0.3.4
commit:   8e90774b47cc3791603d443301038e4dbf49c748
date:     2018-08-01T06:45:59Z
```

Use `akash version` to get the client version.

**Arguments**

None

**Flags**

None

