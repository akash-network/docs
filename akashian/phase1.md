# Phase 1: Node Operations

## Before we begin

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## Become a Genesis Validator

### 1. Add a Key

Pick a memorable team name, ideally team you've registered with for Akashian. Create a key locally using that name:

```
export TEAM=<name>
akashctl keys add $TEAM
```

{% hint style='warning' %}

Please store the menonic keys in a safe place

{% endhint %}

### 2. Generate Genesis Transaction

```sh
akashd init <moniker> --chain-id centauri
curl -s https://raw.githubusercontent.com/ovrclk/net/master/centauri/genesis.json > ~/.akashd/config/genesis.json
akashd add-genesis-account $(akashctl keys show $TEAM -a) 10000000uakt # other values will be removed.
akashd gentx --name $TEAM --amount 9000000uakt
```

You should see a response similar to:

```
Genesis transaction written to "/Users/gosuri/.akashd/config/gentx/gentx-0519098c91a23b00c33d47a53e069e9470a3e736.json"
```

### 3. Submit GenTx using Pull Request

  * Fork the [networks repository](https://github.com/ovrclk/net) to your GitHub.
  * Clone the networks repository to your workstation. For example, where <user> is your GitHub username:
  ```sh
  git clone https://github.com/<user>/net.git
  ```
  * Copy the generated GenTx from the `akashd` home directory at `~/.akashd/config/gentx/` to `net/centauri/gentxs`. For the below example, replace `<your-gentx-file>` with your local value.
  ```sh
  cp /Users/<user>/.akashd/config/gentx/<your-gentx-file>.json net/centauri/gentxs/$TEAM.json
  ```
  * Commit and push your repository.
  * Create a pull request to [networks repository](https://github.com/ovrclk/net) with your team name.

### 4. Join the Akash Telegram Community

Get to know your fellow Akash community members as they're vital for your success throughout the competition. Join our [telegram](https://t.me/akashnw) group and introduce yourself. 


## Configure Node

This section is applicable only after the genesis is released.

### Genesis & Seeds

Fetch released genesis into `akashd`'s `config` directory.

```
curl -s https://raw.githubusercontent.com/ovrclk/net/master/centauri/genesis.json > ~/.akashd/config/genesis.json
```

Add seed nodes and persistent peers in `config.toml`.
```
$ nano ~/.akashd/config/config.toml
```

Find the following section and add the seed nodes.
```
# Comma separated list of seed nodes to connect to
seeds = "15ee12ae5fe8256ee94d1065e0000893e52532d9@akash.ovrclk.com:36656,ca130fd7ca16a957850a96ee9bdb74a351c4929f@akash.ovrclk.com:36656"
```

```
# Comma separated list of persistent peers to connect to
persistent_peers = "8054c84b1571831bf0e744da3af3a647bcaddecf@157.82.22.217:26656,6efc92719561aa8fb4728696f63b16634e5291b4@akash.ovrclk.com:26656"
```

## Start Your Node

### **Method 1** - With `systemd`

#### Get `akashd` path

Get `akashd` location path and use it in next step.

```
$ which akashd
```

#### Make `akashd` a System Service

```
$ sudo nano /lib/systemd/system/akashd.service
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

##### Note: Please make sure to add the ```--pruning ``` flag after the start command

```
$ sudo systemctl enable akashd
$ sudo systemctl start akashd
```
Check node status
```
$ akashctl status
```
Check logs
```
$ sudo journalctl -u akashd -f
```

### **Method 2** - Without `systemd`
```
$ akashd start --pruning nothing
```
Check node status
```
$ akashctl status
```
##### Note: Please make sure to add the ```--pruning ``` flag after the start command