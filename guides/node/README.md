# Run an Akash Node

In this guide, we'll set up an Akash node and connect it to a network.

## Before We Begin

You'll also need to know information about the network you're connecting your node to. See [Choosing a Network](../version.md) for how to obtain any network-related information.

Make sure to have Akash client installed on your workstation, check [install guide](../install.md) for instructions.

## Setting Up a New Node

These instructions are for setting up a brand new full node from scratch.

First, choose a "moniker" - a readable name for your validator. In this guide, we'll use `moniker-from-the-guide`, but you should replace that with your own for the following instructions.

{% hint style="warning" %}
Monikers can contain only ASCII characters. Using Unicode characters will render your node unreachable.
{% endhint %}

```bash
AKASH_MONIKER="moniker-from-the-guide"
```

Then initialize the node and create the necessary config files:

```bash
akash init --chain-id "$AKASH_CHAIN_ID" "$AKASH_MONIKER"
```

You can edit this `moniker` later, in the `~/.akash/config/config.toml` file:

```text
# A custom human readable name for this node
moniker = "moniker-from-the-guide"
```

From here on, your node can be configured in a number of different places.

* `~/.akash/config/app.toml`    - cosmos-specific configuration
* `~/.akash/config/config.toml` - tendermint-specific configuration
* environment variables and command-line options can override settings in the above configuration files.

Some common settings are described below.

### Gas Prices

Your full-node keeps unconfirmed transactions in its mempool. In order to protect it from spam, it is better to set a `minimum-gas-prices` that the transaction must meet in order to be accepted in your node's mempool. This parameter can be set in `~/.akash/config/app.toml`.

The initial recommended `min-gas-prices` is `0.025uakt`, but you might want to change it later.

```text
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

##### main base config options #####

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 10uatom).

minimum-gas-prices = "0.025uakt"
```

## Genesis & Seeds

Next we need to configure the p2p network and ensure that you have the right `genesis.json` file to join the testnet.

### Copy the Genesis File

Fetch the testnet's `genesis.json` file into `akash`'s config directory.

```bash
curl -s "$AKASH_NET/genesis.json" > $HOME/.akash/config/genesis.json
```

Note we use the `$AKASH_NET` variable - see the [net repo](https://github.com/ovrclk/net) for how to set this variable for the network you're connecting to.

To verify the correctness of the configuration run:

{% hint style="warning" %}
The following command is currently not working on `edgenet`. **This error can be ignored on `edgenet`**.

We are looking into the problem, but it won't affect running a node.
{% endhint %}

```bash
akash validate-genesis
```

### Add Seed Nodes

Your node needs to know how to find peers. You'll need to add healthy seed nodes or persistent peers to `$HOME/.akash/config/config.toml`. As with installing [`genesis.json`](./#copy-the-genesis-file), consult the [net repo](https://github.com/ovrclk/net/) for how to obtain seeds to connect to.

For more information on the how and why of seeds and peers, you can [read this](https://docs.tendermint.com/master/spec/p2p/peer.html) great documentation from the Tendermint maintainers.

## A Note on Gas and Fees

Transactions on the Akash Network need to include a transaction fee in order to be processed. This fee pays for the gas required to run the transaction. The formula is the following:

```text
fees = ceil(gas * gasPrices)
```

The `gas` is dependent on the transaction. Different transaction require different amount of `gas`. The `gas` amount for a transaction is calculated as it is being processed, but there is a way to estimate it beforehand by using the `auto` value for the `gas` flag. Of course, this only gives an estimate. You can adjust this estimate with the flag `--gas-adjustment` \(default `1.0`\) if you want to be sure you provide enough `gas` for the transaction.

The `gasPrice` is the price of each unit of `gas`. Each validator sets a `min-gas-price` value, and will only include transactions that have a `gasPrice` greater than their `min-gas-price`.

The transaction `fees` are the product of `gas` and `gasPrice`. As a user, you have to input 2 out of 3. The higher the `gasPrice`/`fees`, the higher the chance that your transaction will get included in a block.

::: tip For Akash testnets, the recommended `gas-prices` is `0.025uakt`. :::

## Pruning of State

There are three strategies for pruning state, please be aware that this is only for state and not for block storage:

1. `default`: the last 100 states are kept in addition to every 500th state; pruning at 10 block intervals
2. `nothing`: all historic states will be saved, nothing will be deleted \(i.e. archiving node\)
3. `everything`: all saved states will be deleted, storing only the current state; pruning at 10 block intervals
4. `custom`: allow pruning options to be manually specified through `pruning-keep-recent`, `pruning-keep-every`, and `pruning-interval`

You can configure your node's pruning strategy at start time with the `--pruning` or by configuring your `app.toml` file.

{% hint style="warning" %}
If running a validator node, do not use `--pruning everything` as it is known to cause issues. Instead, please use `--pruning default`.
{% endhint %}

> Note: When you are pruning state you will not be able to query the heights that are not in your store. The sentry nodes the Akash team is running will be `--pruning nothing` and all data from the testnet will be queriable there.

## Fast Sync

"Fast Sync" allows nodes that are far behind the current height to catchup quickly by downloading blocks in parallel and verifying their commits. This feature is configured in `~/.akash/config/config.toml`.

Enable "Fast Sync" with

```text
fast_sync = true
```

Different versions of Akash use diferent versions of the "Fast Sync" backend:

| Akash Version | Fast Sync Version |
| :--- | :--- |
| `<  0.9.x` | `v0` |
| `>= 0.9.x` | `v2` |

Find the `[fastsync]` section of `~/.akash/config/config.toml` and set the correct backend version like so:

```text
version = "v2"
```

## Run a Full Node

Start the full node with this command:

```bash
akash start
```

If you would like to run your node via `systemd` please see [this guide](https://github.com/ovrclk/docs/tree/5de597cc071f0dec49919e331bc5589f97af6854/guides/node/systemd.md).

You can use `akash` to check that everything is running smoothly:

```bash
akash status
```

