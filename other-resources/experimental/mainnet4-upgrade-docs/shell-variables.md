# Setup your Environment

Shell variables will be used throughout these guides to make the instructions so that the CLI commands in the documentation can be copied and pasted easily without editing at all. Below is a list of variables used and how to populate them.

Note it is important to type the commands into a terminal where the variables have been defined. Closing or changing terminals will mean that you have to re-define your shell variables.

### Environment Variables

| Name                    | Description                                                                   |
| ----------------------- | ----------------------------------------------------------------------------- |
| `AKASH_NET`             | Akash network configuration base URL.                                         |
| `AKASH_VERSION`         | Akash version to install for your network.                                    |
| `AKASH_CHAIN_ID`        | Chain ID of the Akash network for [IBC](../../../cli/broken-reference/).      |
| `AKASH_NODE`            | Akash RPC endpoint URL and port number.                                       |
| `AKASH_KEY_NAME`        | Key name of your choosing. This documentation uses a value of "alice".        |
| `AKASH_KEYRING_BACKEND` | Keyring backend to use for local keys. One of `os` (default), `file`, `test`. |

### Environment Variables and flags

Generally, every parameter set by CLI flag used by akash can be also set via environment variable. Use following rule of binding flag to the corresponding environment variable

1. every dash `-` must be replaced with underscore `_`. `--` prefix must not be accounted!
2. make all characters capital case
3. add prefix `AKASH_` to the result

for example flag `--keyring-backend` binds to `AKASH_KEYRING_BACKEND` environment variable

The precedence is defined in the table below. 0 means highest priority

| Priority | Type                 |
| -------- | -------------------- |
| 0        | Environment variable |
| 1        | Flag                 |
| 2        | Config file          |
| 3        | Default value        |

Example below shows value precedence for `--keyring-backend` parameter.

* use default value set to `os`

```
provider-services tx deployment create ... 
#keyring-backend=os is used
```

* use value set by flag `--keyring-backend=file`

```
provider-services tx deployment create --keyring-backend=file ...
#keyring-backend=file is used 
```

* use value set by environment variable `AKASH_KEYRING_BACKEND=test`

```
export AKASH_KEYRING_BACKEND=test 
provider-services tx deployment create --keyring-backend=file ...
#keyring-backend=test is used 
```

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

First, configure the base URL (`$AKASH_NET`) for the Akash Network; copy and paste the command below:

```bash
AKASH_NET="https://raw.githubusercontent.com/akash-network/net/master/mainnet"
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
