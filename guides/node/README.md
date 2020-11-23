# Join the Akash Network Testnet

In this guide, we'll set up an Akash node and connect it to a network.

## Before We Begin

You'll also need to know information about the network you're connecting your node to.
See [Choosing a Network](/guides/versions.md) for how to obtain any network-related information.

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## Setting Up a New Node

These instructions are for setting up a brand new full node from scratch.

First, initialize the node and create the necessary config files:

```bash
akash init <your_custom_moniker>
```

{% hint style="warning" %}
Monikers can contain only ASCII characters. Using Unicode characters will render your node unreachable.
{% endhint %}

You can edit this `moniker` later, in the `~/.akash/config/config.toml` file:

```toml
# A custom human readable name for this node
moniker = "<your_custom_moniker>"
```

Your full-node keeps unconfirmed transactions in its mempool. In order to protect it from spam, it is better to set a `minimum-gas-prices` that the transaction must meet in order to be accepted in your node's mempool. This parameter can be set in the following file `~/.akash/config/app.toml`.

The initial recommended `min-gas-prices` is `0.025uakt`, but you might want to change it later.

```
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

Note we use the `$AKASH_NET` variable - see the [net repo](https://github.com/ovrclk/net) for how to set this variable
for the network you're connecting to.

To verify the correctness of the configuration run:

```bash
akash validate-genesis
```

### Add Seed Nodes

Your node needs to know how to find peers. You'll need to add healthy seed nodes or persistent peers to `$HOME/.akash/config/config.toml`.  As with installing [`genesis.json`](#copy-the-genesis-file), consult the [net repo](https://github.com/ovrclk/net/) for how to obtain seeds to connect to.

For more information on the how and why of seeds and peers, you can [read this](https://docs.tendermint.com/master/spec/p2p/peer.html) great documentation from the Tendermint maintainers.

## A Note on Gas and Fees

Transactions on the Akash Network need to include a transaction fee in order to be processed. This fee pays for the gas required to run the transaction. The formula is the following:

```
fees = ceil(gas * gasPrices)
```

The `gas` is dependent on the transaction. Different transaction require different amount of `gas`. The `gas` amount for a transaction is calculated as it is being processed, but there is a way to estimate it beforehand by using the `auto` value for the `gas` flag. Of course, this only gives an estimate. You can adjust this estimate with the flag `--gas-adjustment` (default `1.0`) if you want to be sure you provide enough `gas` for the transaction. 

The `gasPrice` is the price of each unit of `gas`. Each validator sets a `min-gas-price` value, and will only include transactions that have a `gasPrice` greater than their `min-gas-price`. 

The transaction `fees` are the product of `gas` and `gasPrice`. As a user, you have to input 2 out of 3. The higher the `gasPrice`/`fees`, the higher the chance that your transaction will get included in a block. 

::: tip
For Akash testnets, the recommended `gas-prices` is `0.025uakt`. 
::: 

## Pruning of State

There are three strategies for pruning state, please be aware that this is only for state and not for block storage:

1. `PruneEverything`: This means that all saved states will be pruned other than the current.
2. `PruneNothing`: This means that all state will be saved and nothing will be deleted.
3. `PruneSyncable`: This means that only the state of the last 100 and every 10,000th blocks will be saved.

By default every node is in `PruneSyncable` mode. If you would like to change your nodes pruning strategy then you must do so when the node is initialized. For example, if you would like to change your node to the `PruneEverything` mode then you can pass the `---pruning everything` flag when you call `akash start`.

> Note: When you are pruning state you will not be able to query the heights that are not in your store. The sentry nodes the Akash team is running will be `--pruning nothing` and all data from the testnet will be queriable there.

## Run a Full Node

Start the full node with this command:

```bash
akash start --pruning everything
```

If you would like to run your node via `systemd` please see [this guide](/guides/node/systemd.md).

You can use `akash` to check that everything is running smoothly:

```bash
akash status
```

View the status of the network with the testnet explorer.

## Upgrade to Validator Node

You now have an active full node. What's the next step? You can upgrade your full node to become a Akash Validator. Validators have the ability to propose new blocks the Akash testnet. If you are interested you can continue onto [the Validator Setup](/guides/node/validator.md).
