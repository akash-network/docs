To update to the newest version of the testnet:

1. Update your server to the latest version of `akashd` ([`0.7.0`](https://github.com/ovrclk/akash/releases/tag/v0.7.0)). If you [installed from source](../guides/install.md#others-from-source), the following commands will update to the latest version:

```bash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ git checkout v0.7.0
$ make install
```

2. Stop the old node and reset the server. If you are using `systemd` you can stop the node with `sudo systemctl stop akashd`, otherwise use `killall akashd`.

```bash
# stop akashd
$ akashd unsafe-reset-all
$ rm ~/.akashd/config/genesis.json
$ curl -s https://raw.githubusercontent.com/ovrclk/net/master/centauri-2/genesis.json > ~/.akashd/config/genesis.json
```

Verify the genesis with `sha256sum`:
```bash
$ cd ~/.akashd/config && sha256sum genesis.json
263d5742d0fb08a1f1a4eb1e85ab72e16e2dc57f6797ae6b9cf6fdfe3d65e765 genesis.json
```

3. Update seeds & persistent peers

Edit your `~/.akashd/config/config.toml` file and update `seeds` and `persistent_peers`.

```
$EDITOR ~/.akashd/config/config.toml
```

Find the following section and update the _seed_ and _persistent peer_ nodes, the values should be seperated by a comma (`,`) for each key:

```
seeds = "331db71f20be13da096a8c2e4fbb8106cd7077e8@147.75.62.73:26656"
```
```
# Comma separated list of persistent peers to connect to
persistent_peers = "9f6a910a640789fe34fba787587f6a1aba9dd178@147.75.76.41:26656,42b56fa219ca6800f3b20bd117a8510c62e05d61@147.75.69.249:26656"
```

The above configuraiton will sync your node with below set of seeds nodes and peristent peers:

**Seed nodes:**
- `331db71f20be13da096a8c2e4fbb8106cd7077e8@147.75.62.73:26656`

**Persistent peers:**
- `9f6a910a640789fe34fba787587f6a1aba9dd178@147.75.76.41:26656`
- `42b56fa219ca6800f3b20bd117a8510c62e05d61@147.75.69.249:26656`

4. Start the node

```bash
# Start akash, below we show using systemd
$ sudo service akashd start
```

5. Create validator

Once the node has started, you should be able to use the same key from `centauri` to create a validator:

```bash
$ akashctl tx staking create-validator \
  --amount=9000000uakt \
  --pubkey=$(akashd tendermint show-validator) \
  --moniker="<moniker-name>" \
  --chain-id=centauri-2 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas="auto" \
  --from=<key_name>
```


# Cygni upgrade

## Context - Why Cygni Upgrade?
The goal is to ensure upgrades happen without friction, and coordination gaps are identified and fixed. The release will have updates to gov params and staking, to reduce the voting power of genesis validator(s) to match with other validators. More details on the release changelog are available at: https://github.com/ovrclk/akash/releases/tag/v0.7.1

## Schedule
- Upgrade proposal time: 29 May, 16:00 UTC
- Binary release : 29 May, 16:00 UTC
- Voting Period : 29 May - 31 May, 16:00 UTC
- Network Upgrade Time: 01 June, 16:00 UTC

## Proposal Details
|    |            |
|----------|:-------------:|
| Proposal ID |  1 |
| Name |    cygni   |
| Title | Cygni Upgrade | 
| Description | The goal is to ensure upgrades happen without friction, and coordination gaps are identified and fixed. The release will have updates to gov params and staking, to reduce the voting power of genesis validator(s) to match with other validators. More details on the release changelog are available at: https://github.com/ovrclk/akash/releases/tag/v0.7.1 |
| Proposal Time | 2020-05-29 16:00 UTC |
| Voting Start Time | 2020-05-29 16:00 UTC |
| Voting End Time | 2020-05-31 16:00 UTC |
| Network Upgrade Time | 1 June, 16:00 UTC |
| Link(s) | https://akash.aneka.io/proposals/1, https://testnet.akash.bigdipper.live/proposals/1, https://look.ping.pub/#/governance/1 |

## Querying the proposal

Use the following command to query the proposal

```sh
akashctl query gov proposal 1 --chain-id centauri-2 -o json
```

You can query the votes using following command.

```sh
akashctl query gov votes 1 --chain-id centauri-2 -o json
```

## Voting for proposal

Use the following command to vote on the proposal.
```sh
akashctl tx gov vote 1 <option> --chain-id centauri-2 --from <key-name>
```

You have `yes`/`no`/`abstain`/`no_with_veto` options to vote, it is recommended to choose your vote carefully as the governance decision will change the network state forever.
Note: You can always change your vote before voting endtime.

## How to Upgrade

If the proposal goes through, everyone gets to switch/update their binaries to new version (v0.7.2). The old binary (v0.7.0) will stop working from 01 June, 16:00 UTC and it won't be able to sync/sign new blocks from then.

Note: We should use new binaries only after 01 June, 16:00UTC, if you try to update it before, it fails.

### Download the binaries

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.7.2/akash_0.7.2_linux_amd64.zip) from the [release page](https://github.com/ovrclk/akash/releases/tag/v0.7.2).

Alternatively, install the `v0.7.2` version via [`godownloader`](https://github.com/goreleaser/godownloader) with:

```sh
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- v0.7.2
```

The final step is to make sure that the akash binaries are available in your shell `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

### Build from source

Installing Akash suite from source

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ git fetch && git checkout v0.7.2
$ make install
$ akashd version
```

Akash is developed and tested with [golang 1.14+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Most golang libraries will be installed via `go mod`, however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akashctl` and `akashd` using `make install`

### Restart the node
If you are using `systemd` service,

```sh
sudo service akashd stop
sudo service akashd start
sudo service akashd status
```

If you are using `screen`, switch to the screen and execute:
```sh
akashd start --pruning nothing
```