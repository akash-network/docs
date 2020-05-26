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
