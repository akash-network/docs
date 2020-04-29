# Command Line

## Akash Command Line Utlity

This section describes usage of the Akash client for requesting and managing deployments to the Akash Network.

### Installation

For instructions on installing the `akashctl` client, please check out the [install guide](../guides/install.md)

### Akash Testnet

The Akash testnet is available for public use. A description of the testnet, registration instructions, and a getting-started guide may be found [here](../guides/testnet.md).

## Top-level commands

> You can access help using `akashctl help`:

These commands are presented as an overview of the features available via the Akash client. Individual command usage is described in subsequent sections.

```text
$ akashctl help
```

> Outputs:

```text
Akash Network CLI Utility.

Akash is a peer-to-peer marketplace for computing resources and
a deployment platform for heavily distributed applications.
Find out more at https://akash.network

Usage:
  akashctl [command]

Available Commands:
  config      Create or query an application CLI configuration file
  help        Help about any command
  keys        Add or view local private keys
  query       Querying subcommands
  rest-server Start LCD (light-client daemon), a local REST server
  status      Query remote node for status
  tx          Transactions subcommands
  version     Print the app version

Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
  -h, --help              help for akash
      --home string       directory for config and data (default "/Users/gosuri/.akashctl")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

Use "akashctl [command] --help" for more information about a command.
```

| Command | Description |
| :--- | :--- |
| [config](config.md) | Create or query an application CLI configuration file |
| [keys](keys.md)  | Add or view local private keys |
| [query](query.md) | Querying subcommands |
| [rest-server](rest-server.md) | Start LCD (light-client daemon), a local REST server |
| [status](status.md) | Query remote node for status |
| [tx](tx.md) |  Transactions subcommands |
| [version](version.md) | Print the app version |

**Global Flags**

Every command accepts the following flags. For brevity, they are omitted from the following documentation.

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
|   -e |  --encoding | string | N | Binary encoding (hex, b64, btc) (default "hex") |
|   -h |  --help     | bool   | N | help for akashctl |
|      |  --home     | string | N | directory for config and data (default "/Users/gosuri/.akashctl") |
|   -o |  --output   | string | N | Output format (text, json) (default "text") |
|      |  --trace    | bool   | N | print out full stack trace on errors |
