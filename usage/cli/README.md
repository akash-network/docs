# Command Line

## Akash Command Line Utlity

This section describes usage of the Akash client for requesting and managing deployments to the Akash Network.

### Installation

The Akash Suite is composed of a full node `akashd` and the client `akash`. The full node `akashd` is the tendermint-based blockchain node that implements the decentralized exchange. `akash` is the client used to access the exchange and network in general.

{% tabs %} {% tab title="MacOS" %}

### MacOS

Install Homebrew.

```text
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install `akash` client and `akashd` daemon using homebrew.

```text
$ brew install ovrclk/tap/akash
```

The simplest way to install is by using [homebrew](https://brew.sh). Install `akash` client by running `brew install ovrclk/tap/akash`. Once installed, verify the installation by running `akash version`.

Alternatively, you can manually download the [binaries](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_darwin_amd64.tar.gz) from the [releases page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version. The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on MacOS.

{% endtab %} {% tab title="Linux" %}

### Linux

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_linux_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the terraform binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

{% endtab %} {% tab title="Windows" %}

### Windows

Download the [windows archive](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_windows_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows) contains instructions for setting the PATH on Windows.

{% endtab %} {% tab title="Others" %}

### Others \(From Source\)

Installing akash suite from source

```shell
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

{% endtab %} {% endtabs %}

## The Akash Testnet

The Akash testnet is available for public use. A description of the testnet, registration instructions, and a getting-started guide may be found [here](https://github.com/ovrclk/docs/tree/5aed620d0b5cea1af0ec259758a64b7a231f444a/usage/guides/testnet.md)

## Interaction Modes

Akash CLI provides an `interactive` mode designed for human usage and `json` and `shell` optimized for machine usage. Mode is using `--mode` or `-m`.

{% tabs %} {% tab title="Interactive" %}

### Interactive

```shell
$ akash key create

Key Name (required): alice
(info)  [key] key created

Create Key
==========

Name:           	alice
Public Key:     	632d94e2b3542eacd673e0e84ab81d82936b4640
Recovery Codes: 	nephew symptom draw awful divide speed spring renew erode sail aunt nephew trap spoil increase throw piece toy fuel guard minute oblige shield usage

(warn)  [Important] Write these Recovery codes in a safe place. It is the only way to recover your account.
```

{% endtab %} {% tab title="Shell" %}

### Shell

Shell mode is optimized for using Akash with shell programs. For examples:

```shell
$ akash key create alice -m shell | tee -a alice

akash_create_key_0_name="alice"
akash_create_key_0_public_key="10ee882d643c645fd793a7b2dcb1380cbaf2de40"
akash_create_key_0_recovery_codes="basic creek call choose swim run horror globe argue bunker rent harvest forum excuse carpet boil toward pride alter bronze already neck body humor"

$ source alice

$ echo $akash_create_key_0_public_key
10ee882d643c645fd793a7b2dcb1380cbaf2de40
```

{% endtab %} {% tab title="JSON" %}

### JSON

Example using json mode and jq

```shell
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

{% endtab %} {% endtabs %}

## Top-level commands

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
| [deployment](deployments.md) | Manage deployments. |
| [key](keys.md) | Manage keys. |
| [logs](logs.md) | Service logs. |
| [marketplace](marketplace.md) | Monitor marketplace. |
| [provider](provider.md) | Manage provider. |
| [query](query.md) | Query things that need querying. |
| [send](send.md) | Send tokens to an account. |
| [status](status.md) | Get remote node status. |
| [version](version.md) | Print Akash version. |

**Global Flags**

Every command accepts the following flags. For brevity, they are omitted from the following documentation.

| Short | Verbose | Argument | Required | Description |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| -h | --help | None | N | Help for any command. |  |  |
| -m | --mode | String | N | output mode \(interactive | shell | json\) \(default "interactive"\) |
| -d | --data | String | N | User data directory \(defaults to ~/.akash\). |  |  |


**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
