# Command Line

## Akash Command Line Utlity

This section describes usage of the Akash client for requesting and managing deployments to the Akash Network.

### Installation

For instructions on installing the `akash` client, please check out the [install guide](../guides/install.md)

### Akash Testnet

The Akash testnet is available for public use. A description of the testnet, registration instructions, and a getting-started guide may be found [here](../guides/testnet.md).

## Interaction Modes

Akash CLI provides an `interactive` mode designed for human usage and `json` and `shell` optimized for machine usage. Mode is using `--mode` or `-m`.

### Interactive

```shell
akash key create
```

Waits for in user to input the required attribute `key`, optmized to reduce failures:

```text
Key Name (required): alice

(info)  [key] key created

Create Key
==========

Name:           	alice
Public Key:     	632d94e2b3542eacd673e0e84ab81d82936b4640
Recovery Codes: 	nephew symptom draw awful divide speed spring renew erode sail aunt nephew trap spoil increase throw piece toy fuel guard minute oblige shield usage

(warn)  [Important] Write these Recovery codes in a safe place. It is the only way to recover your account.
```

### Shell

Shell mode is optimized for using Akash with shell programs. For example:

```shell
akash key create alice -m shell | tee -a alice
```

```shell
akash_create_key_0_name="alice"
akash_create_key_0_public_key="10ee882d643c645fd793a7b2dcb1380cbaf2de40"
akash_create_key_0_recovery_codes="basic creek call choose swim run horror globe argue bunker rent harvest forum excuse carpet boil toward pride alter bronze already neck body humor"

$ source alice

$ echo $akash_create_key_0_public_key
10ee882d643c645fd793a7b2dcb1380cbaf2de40
```

### JSON

Example using json mode and jq

```shell
akash key create alice -m json  | jq
```

Displays:

```json

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
