# Network Parameters

At any given time, there are a number of different active
Akash networks running, each with a different `akash` version,
chain-id, seed hosts, etc...

The generally available networks are:

|Network|Description|
|---|---|
|[mainnet](https://github.com/ovrclk/net/tree/master/mainnet)| Akash Network mainnet network.|
|[testnet](https://github.com/ovrclk/net/tree/master/testnet)| Testnet of the current mainnet version.|
|[edgenet](https://github.com/ovrclk/net/tree/master/edgenet)| Testnet of the next mainnet version.|

When following guides in this document, it is important to use
the right parameters for the network you want to connect to.

The [ovrclk/net] repository contains metadata about each available network.  The format is standardized across the networks so that you can use the same method to fetch the information for any of them.  See [below](#obtaining-the-data) for how
to use [ovrclk/net] in the guides here.

## Obtaining Data

First determine the base URL (`$AKASH_NET`) for the network you want to connect to - use the line from below that corresponds with the network you want to connect to:

```sh
# mainnet
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"

# testnet
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/testnet"

# edgenet
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/edgenet"
```

### Version

```sh
AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
```

### Chain ID

```sh
AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

### Genesis

```sh
curl -s "$AKASH_NET/genesis.json" > genesis.json
```

### Seed Nodes

```sh
curl -s "$AKASH_NET/seed-nodes.txt" | paste -d, -s
```

### Peer Nodes

```sh
curl -s "$AKASH_NET/peer-nodes.txt" | paste -d, -s
```

### RPC Node

Print a random RPC endpoint

```sh
curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1
```

### API Node

Print a random API endpoint

```sh
curl -s "$AKASH_NET/api-nodes.txt" | shuf -n 1
```

[ovrclk/net]: https://github.com/ovrclk/net
