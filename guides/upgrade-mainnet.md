# Upgrade to Akashnet-2

## Akashnet-2 Upgrade Procedure

### What validators need to do before the upgrade time?

1. Verify you are currently running the correct version of Akash

   ```text
    $ akashd version --long
    name: akash
    server_name: akashd
    client_name: akashctl
    version: 0.8.3
    commit: 11a6e4dfba545073f79732088735f93a5408995c
    build_tags: netgo,ledger,mainnet
    go: go version go1.15.5 linux/amd64
   ```

2. Set halt-time to ensure your validator node stops at the right time and date: March 08 2021 at 1500 UTC.

   ```text
   $ perl -i -pe 's/^halt-time =.*/halt-time = 1615215600/' ~/.akashd/config/app.toml
   ```

   or you can manually update `app.toml` using `nano` or `vm`

3. Stop your `akashd` binary or systemd process
4. Restart your `akashd` binary or systemd process

### Instructions for upgrade, after the node stops \(i.e., after 1500UTC on 8th March, 2021\)

1. Stop your `akashd` binary or systemd process
2. Check the last block height signed

   Check the last block height signed by your validator:

   ```text
   $ cat ~/.akashd/data/priv_validator_state.json | jq '.height'
   ```

Take the state export from this height \(decision on the final height will be coordinated on the mainnet-validator discord channel\):

1. Export the `akashnet-1` state

```text
akashd export --for-zero-height --height <height> > old_genesis_export.json
```

1. Fix migration issue by executing following command \(This is yet to be fixed on cosmos-sdk: [https://github.com/cosmos/cosmos-sdk/issues/8776](https://github.com/cosmos/cosmos-sdk/issues/8776)\)

   ```bash
   cat old_genesis_export.json | jq '.app_state.auth.accounts= [.app_state.auth.accounts[] | if (.value.public_key!=null and .value.public_key!="") then (.value.public_key.value= (.value.public_key.value | if type=="string" then . else (.threshold = (.threshold| tonumber)) end)) else . end ]' > old_genesis_updated.json
   ```

2. Verify the SHA256 of the \(sorted\) exported genesis file:

   ```text
   $ jq -S -c -M '' old_genesis_updated.json | shasum -a 256
   ```

   Compare this value with other validators of the network over on \#validators-mainnet on the [discord server](https://discord.gg/CuGPqaUW). It's important that everyone can create the same genesis file export.

HASH: \[TBD\]

1. Install Akash [v0.10.1](https://github.com/ovrclk/akash/releases/tag/v0.10.1)

**Note**: Building the new binary requires Go 1.15+

```text
git clone https://github.com/ovrclk/akash
cd akash
git checkout v0.10.1
MAINNET=true make install
```

1. Verify you have the correct version:

   \`\`\`

   $ akash version --long

   name: akash

   server\_name: akash

   version: 0.10.1

   commit: c39715e1f9c13ec85eefbfb295031e995db45591

   build\_tags: netgo,ledger,mainnet

   go: go version go1.15.5 linux/amd64

   build\_deps:

2. github.com/99designs/keyring@v1.1.6
3. github.com/ChainSafe/go-schnorrkel@v0.0.0-20200405005733-88cbf1b4c40d
4. github.com/Workiva/go-datastructures@v1.0.52

   ....

   \`\`\`

**Note**: `akashd` and `akashctl` are merged into a single binary, `akash` now.

1. Migrate exported state from the current v0.8.3 version to the new v0.10.1 version:

   ```text
   $ akash migrate v0.40 old_genesis_updated.json --chain-id=akashnet-2 --genesis-time 2021-03-08T15:00:00Z > 040_migrated_genesis.json
   ```

2. Migrate command adds a warning to the exported file regarding `max_bytes` in the `evidence` module which we will modify in the next step. Remove the warning:

   ```text
   $ sed -i  '/Warning/d' 040_migrated_genesis.json
   ```

3. Update the evidence params as below:

   ```text
   $ sed -i 's/{"max_age_duration":"172800000000000","max_age_num_blocks":"100000"}/{"max_age_duration":"172800000000000","max_age_num_blocks":"100000","max_bytes":"1048576"}/g' 040_migrated_genesis.json
   ```

4. Add IBC and Akash parameters to the genesis file:

   ```text
   $ cat 040_migrated_genesis.json | jq '.app_state |= . + {"ibc":{"client_genesis":{"clients":[],"clients_consensus":[],"create_localhost":false},"connection_genesis":{"connections":[],"client_connection_paths":[]},"channel_genesis":{"channels":[],"acknowledgements":[],"commitments":[],"receipts":[],"send_sequences":[],"recv_sequences":[],"ack_sequences":[]}},"transfer":{"port_id":"transfer","denom_traces":[],"params":{"send_enabled":false,"receive_enabled":false}},"capability":{"index":"1","owners":[]}} + {"deployment":{"deployments":[],"params":{"deployment_min_deposit":{"denom":"uakt","amount":"5000000"}}},"market":{"orders":[],"leases":[],"params":{"bid_min_deposit":{"denom":"uakt","amount":"50000000"},"order_max_bids": 20}}} + {"provider":{"providers":[]}} + {"cert":{"certificates":[]}} + {"audit":{"attributes":[]}} + {"escrow":{"accounts":[],"payments":[]}}' > new_genesis.json
   ```

5. Verify the SHA256 of the final genesis JSON:

   ```text
   $ jq -S -c -M '' new_genesis.json | shasum -a 256
   ```

   HASH: TBA

6. Creating a new home directory for `akash`

   ```text
   $ akash init <moniker> --chain-id akashnet-2
   ```

7. Update the fast-sync option to `v2` in `config.toml`

   ```text
   version = "v2"
   ```

8. Make the following changes in `app.toml`

   \`\`\`

   **State sync snapshots allow other nodes to rapidly join the network without replaying historical**

   **blocks, instead downloading and applying a snapshot of the application state at a given height.**

   \[state-sync\]

## snapshot-interval specifies the block interval at which local state sync snapshots are

## taken \(0 to disable\). Must be a multiple of pruning-keep-every.

snapshot-interval = 500

## snapshot-keep-recent specifies the number of recent snapshots to keep and serve \(0 to keep all\).

snapshot-keep-recent = 2

```text
16. Copying the node and priv_val_key and new genesis to the new home directory (Only applicable for the ones who are using the file-based FilePV implementation for their consensus keys)
```

$ cp .akashd/config/node\_key.json .akash/config/node\_key.json $ cp .akashd/config/priv\_validator\_key.json .akash/config/priv\_validator\_key.json $ cp new\_genesis.json .akash/config/genesis.json

```text
17. Add Peers to `.akash/config/config.toml`


18. Update systemd
Edit your systemd file  to use `akash` instead of `akashd` and also rename the service file to `akash`

19. Start your validator
```

sudo service akash start

\`\`\`

Note Migrate keys or recover using mnemonic \(For all non-ledger users\) `akashctl keys export <keyname>` `akash keys import <key_name> <key_file_json>` or `akash keys add <key-name> --recover`

