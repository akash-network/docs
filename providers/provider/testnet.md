# Provider Test Networks

## NOTE: Please use Mainnet for all deployments if you want to get bids from Providers. There are no providers available to bid on orders on the Testnet.

At any given time, there are a number of different  Akash networks running for using in testing new nodes, providers, validators, and even deployments.  The generally available networks are: 

| Network | Description |
| :--- | :--- |
| [mainnet](https://github.com/ovrclk/net/tree/master/mainnet) | Akash Network mainnet network. |
| [testnet](https://github.com/ovrclk/net/tree/master/testnet) | **No available providers at this time.**  |
| \*\*\*\*[edgenet](https://github.com/ovrclk/net/tree/master/edgenet) | Testnet of the next mainnet version. |

When following guides in this document, it is important to use the right parameters for the network you want to connect to.

The [ovrclk/net](https://github.com/ovrclk/net) repository contains metadata about each available network. The format is standardized across the networks so that you can use the same method to fetch the information for any of them. See [below](testnet.md#obtaining-the-data) for how to use [ovrclk/net](https://github.com/ovrclk/net) in the guides here.

## Obtaining Data

First determine the base URL \(`$AKASH_NET`\) for the network you want to connect to - use the line from below that corresponds with the network you want to connect to:

```bash
# mainnet
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"

# testnet
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/testnet"

# edgenet
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/edgenet"
```

### Version

```bash
AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
```

### Chain ID

The akash CLI will recogonize `AKASH_CHAIN_ID` environment variable when exported to the shell.

```bash
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

### Genesis

```bash
curl -s "$AKASH_NET/genesis.json" > genesis.json
```

### Seed Nodes

```bash
curl -s "$AKASH_NET/seed-nodes.txt" | paste -d, -s
```

### Peer Nodes

```bash
curl -s "$AKASH_NET/peer-nodes.txt" | paste -d, -s
```

### RPC Node

Print a random RPC endpoint. The akash CLI will recognize `AKASH_NODE` environment variable when exported to the shell.

```bash
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"

echo $AKASH_NODE
```

### API Node

Print a random API endpoint

```bash
curl -s "$AKASH_NET/api-nodes.txt" | shuf -n 1
```

### Testnet Faucet

The TestNet has a "faucet" running - a server that will send tokens to your account. You can see the faucet url by running:

```bash
curl "$AKASH_NET/faucet-url.txt"
```

Go to the resulting URL and enter your account address; you should see tokens in your account shortly.

