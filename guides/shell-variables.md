# Shell Variables

Shell variables will be used throughout these guides to make the instructions so that the commands can be used verbatim. The beginning of each guide will give a list of variables used and how to populate them.

Because of this, it is important to type the commands into a terminal where the variables have been defined. Closing or changing terminals will mean that you have to re-define the variable.

| Name | Description |
| :--- | :--- |
| `AKASH_NET` | Akash network configuration base URL. |
| `AKASH_VERSION` | Akash version to install for your network. |
| `AKASH_CHAINID` | Chain ID of the Akash network for [IBC](../reference/akashnet-relayer.md). |
| `AKASH_NODE` | Akash RPC endpoint URL and port number. |
| `AKASH_KEY_NAME` | Key name of your choosing.  This documentation uses a value of "alice". |
| `AKASH_KEYRING_BACKEND` | Keyring backend to use for local keys.  One of `os` \(default\), `file`, `test`. |

## Key Name

First, configure the name of your key. The command below will set the name of your key to `alice`, run the below command and replace `alice` with a name of your choice:

```bash
AKASH_KEY_NAME=alice
```

**Key Ring Backend**

Set the Key Ring Backend that you will use to store your key locally. The default is `os` and will store the key in your operating system, protected by your login password. You can change this to `file` or `test`.

```bash
AKASH_KEYRING_BACKEND=os
```

## Network

First, configure the base URL \(`$AKASH_NET`\) for the Akash Network; copy and paste the command below:

```bash
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
```

## Version

Next, configure the version of the Akash Network `AKASH_VERSION`; copy and paste the command below:

```bash
AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
```

## Chain ID

The akash CLI will recognize `AKASH_CHAIN_ID` environment variable when exported to the shell.

```bash
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

## RPC Endpoint

Print a random RPC endpoint. The akash CLI will recognize `AKASH_NODE` environment variable when exported to the shell.

```bash
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"

echo $AKASH_NODE
```

## API Endpoint

Print a random API endpoint.

```bash
curl -s "$AKASH_NET/api-nodes.txt" | shuf -n 1
```

