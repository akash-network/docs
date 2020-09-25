# Join the network after genesis

## Before we begin

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## Add a Key

Create a key (account) using below command:

```
akashctl keys add <key-name>
```

{% hint style='warning' %}

Please store the menonic keys in a safe place

{% endhint %}

## Setting Up a New Node

Following instructions are for setting up a node.

First, initialize the node and create the necessary config files:

```
akashd init <your_moniker> --chain-id centauri
```

You can edit the `~/.akashd/config/app.toml` file in order to enable the anti spam mechanism and reject incoming transactions with less than the minimum gas prices:

```
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

##### main base config options #####

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 0.25token1;0.0001token2).
minimum-gas-prices = ""
```

Your node has been initialized!

## Configure and Start Node

Check below instruction links to configure and start node:

* [Configure Node](/akashian/phase1.md#configure-node)

* [Start Node](/akashian/phase1.md#start-your-node)

## Become a Validator

To create validator, you need to have some `uakt`.

### Request some `uakt`

Join our [riot](https://riot.im/app/#/room/#akashnet:matrix.org) group and request some tokens there by sharing address of your key created in the beginning.

Check `uakt` balance with your address using:

```
akashctl query account <key-address>
```

### Create Your Validator

To create your validator, just use the following command:

```
akashctl tx staking create-validator \
  --amount=9000000uakt \
  --pubkey=$(akashd tendermint show-validator) \
  --moniker="choose a moniker" \
  --chain-id=centauri \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas="auto" \
  --from=<key_name>
```

{% hint style='warning' %}

Don't use more `uakt` than you have.

{% endhint %}

* When specifying commission parameters, the `commission-max-change-rate` is used to measure *% point* change over the `commission-rate`. E.g. 1% to 2% is a 100% rate increase, but only 1 percentage point.

* `Min-self-delegation` is a stritly positive integer that represents the minimum amount of self-delegated voting power your validator must always have. A `min-self-delegation` of 1 means your validator will never have a self-delegation lower than `1uakt`, or `1000000uakt`.

You can confirm that you are in the validator set by using any akash block explorer.

Or, you can query validators using:

```sh
akashctl query staking validators --trust-node --node http://localhost:26657 --chain-id centauri -o json | jq '.[] | select(.jailed==false) | {operator_address, jailed, status, moniker:.description.moniker}'
```
