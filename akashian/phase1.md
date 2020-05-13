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


# Sirius upgrade

## Context - Why Sirius Upgrade?
Centauri network launch was smooth, the first block was produced within 2 seconds and that's remarkable. Later the day, a few validators reported the issues with block rewards and querying distributions. There was a bug in distribution module integration and all the jailed (previously) validators were facing the issues due to that. A new version is released and Sirius upgrade is to upgrade the network to new binary (v0.6.4)

## Schedule
- Upgrade proposal time: 12 May, 16:00 UTC
- Binary release : 12 May, 16:00 UTC
- Voting Period : 12, May - 14 May, 16:00 UTC
- Network Upgrade Time: 15 May, 16:00 UTC

## Proposal Details
|    |            |
|----------|:-------------:|
| Proposal ID |  2 |
| Name |    sirius   |
| Title | Sirius Upgrade | 
| Description | The first ever on-chain upgrade on Akash Network. Sirius upgrade fixes the issues with withdraw rewards txs and double-sign slashing |
| Proposal Time | 2020-05-12 16:00 UTC |
| Voting Start Time | 2020-05-12 16:00 UTC |
| Voting End Time | 2020-05-14 16:00 UTC |
| Network Upgrade Time | 15 May, 16:00 UTC |
| Link(s) | https://akash.aneka.io/proposals/2, https://testnet.akash.bigdipper.live/proposals/2 |

## Querying the proposal

Use the following command to query the proposal

```sh
akashctl query gov proposal 2 --chain-id centauri --node http://akash-rpc.vitwit.com:26657 -o json
```

You can query the votes using following command.

```sh
akashctl query gov votes 2 --chain-id centauri --node http://akash-rpc.vitwit.com:26657 -o json
```

## Voting for proposal

Use the following command to vote on the proposal.
```sh
akashctl tx gov vote 2 yes --chain-id centauri --node http://akash-rpc.vitwit.com:26657 --from <key-name>
```

Though you have `yes`/`no`/`abstain`/`no_with_veto` options to vote, it is recommended to choose only `yes` option as this will fix existing bugs on the network.


## How to Upgrade

If the proposal goes through, everyone gets to switch/update their binaries to new version (v0.6.4). The old binary (v0.6.3) will stop working from 15 May, 16:00 UTC and it won't be able to sync/sign new blocks from then.

Note: We should use new binaries only after 15 May, 16:00UTC, if you try to update it before, it fails.

### Download the binaries

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.6.4/akash_0.6.4_linux_amd64.zip) from the [release page](https://github.com/ovrclk/akash/releases/tag/v0.6.4).

Alternatively, install the `v0.6.4` version via [`godownloader`](https://github.com/goreleaser/godownloader) with:

```sh
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- v0.6.4
```

The final step is to make sure that the akash binaries are available in your shell `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

### Build from source

Installing Akash suite from source

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ git checkout v0.6.4
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.14+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Most golang libraries will be installed via `go mod`, however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akashctl` and `akashd` using `make install`
