# Join the network after genesis

## Before we begin

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

### Add a Key

Create a key locally with any random name using below command:

```
akashctl keys add <key-name>
```

{% hint style='warning' %}

Please store the menonic keys in a safe place

{% endhint %}

## Setting Up a New Node

These instructions are for setting up a brand new full node from scratch.

First, initialize the node and create the necessary config files:

```
akashd init <your_moniker> --chain-id centauri
```

You can edit this `moniker` later, in the `~/.akashd/config/config.toml` file:

```
# A custom human readable name for this node
moniker = "<your_moniker>"
```

You can edit the ~/.akashd/config/app.toml file in order to enable the anti spam mechanism and reject incoming transactions with less than the minimum gas prices:

```
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

##### main base config options #####

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 0.25token1;0.0001token2).
minimum-gas-prices = ""
```

Your full node has been initialized!

## Configure Node

This section is applicable only after the genesis is released.

### Download the Genesis and Sync with Seeds

Fetch released genesis into `akashd`'s `config` directory.

```
curl -s https://raw.githubusercontent.com/ovrclk/net/master/centauri/genesis.json > ~/.akashd/config/genesis.json
```

Add seed nodes and persistent peers in `config.toml`.

```
$EDITOR ~/.akashd/config/config.toml
```

Find the following section and add the _seed_ and _persistent peer_ nodes, the values should be seperated by a comma (`,`) for each key:

```
seeds = "331db71f20be13da096a8c2e4fbb8106cd7077e8@147.75.62.73:26656,cf9b4ab767f245062f664cf3cc6aa06c082af106@67.207.70.48:26656,e58583366339344c92161e92602f40fa4163edf9@86.109.15.49:26656"
```
```
# Comma separated list of persistent peers to connect to
persistent_peers = "b29c405d575b76795150cf9b26e44a7b51e72dd8@157.245.119.72:26656,c7c3f86b35dee13958190b301f7f3b8de137fa9e@167.71.138.117:26656"
```

The above configuraiton will sync your node with below set of seeds nodes and peristent peers:

**Seed nodes:**
- `331db71f20be13da096a8c2e4fbb8106cd7077e8@147.75.62.73:26656`
- `cf9b4ab767f245062f664cf3cc6aa06c082af106@67.207.70.48:26656`
- `e58583366339344c92161e92602f40fa4163edf9@86.109.15.49:26656`

**Persistent peers:**
- `b29c405d575b76795150cf9b26e44a7b51e72dd8@157.245.119.72:26656`
- `c7c3f86b35dee13958190b301f7f3b8de137fa9e@167.71.138.117:26656`

## Start Your Node

### Option #1: Simple

To start the node, simple run `start command`, and check node status by running `status`.

```sh
akashd start --pruning nothing
```

```sh
akashctl status
```

{% hint style='warning' %}

**Note: Please make sure to add the ```--pruning ``` flag after the start command**

{% endhint %}

### Option #2: Using `systemd`

Fetch `akashd` location path and use it in next step.

```
which akashd
```

#### Make `akashd` a System Service

```
sudo $(EDITOR) /lib/systemd/system/akashd.service
```

Paste in the following:
```
[Unit]
Description=Akash Daemon
After=network-online.target

[Service]
User=<your_user>
ExecStart=<akashd-path> start --pruning nothing
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

{% hint style='warning' %}

**Note: Please make sure to add the ```--pruning ``` flag after the start command**

{% endhint %}

Enable and start the systemd service using:

```
sudo systemctl enable akashd
sudo systemctl start akashd
```

Finally, check node status

```
akashctl status
```

Check Logs using:

```
sudo journalctl -u akashd -f
```

## Become a Validator

To create validator, you need to have some tokens.

### Request some tokens

Join our [riot](https://matrix.to/#/!QOQfggNBhPYxvbQdNm:matrix.org?via=matrix.org&via=fedi.io&via=librem.one) group and  request some tokens there by sharing address of your key created in beginning.

Check tokens balance of your key using:

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

* `Min-self-delegation` is a stritly positive integer that represents the minimum amount of self-delegated voting power your validator must always have. A `min-self-delegation` of 1 means your validator will never have a self-delegation lower than `1akt`, or 1000000uakt.