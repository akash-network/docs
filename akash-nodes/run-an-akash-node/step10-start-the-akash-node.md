# STEP10 - Start the Akash Node



## Start the Node

In this section we will create a script and a related service to start the node.  The service will additionally ensure that the node is restarted following reboots.

### Create Script to Start Node

* Create a script to start the Akash Node

```
cd ~

cat <<EOF | tee /usr/local/bin/start-node.sh
#!/usr/bin/env bash

/root/bin/akash start
EOF
```

* Make the script an executable

```
chmod 744 /usr/local/bin/start-node.sh
```

### Create Related Service

```
cat > /etc/systemd/system/akash-node.service << 'EOF'
[Unit]
Description=Akash Node
After=network.target

[Service]
User=root
Group=root
ExecStart=/usr/local/bin/start-node.sh
KillSignal=SIGINT
Restart=on-failure
RestartSec=15
StartLimitInterval=200
StartLimitBurst=10
#LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

### Start the Service

```
systemctl daemon-reload
systemctl start akash-node
systemctl enable akash-node
```

## Check the Status of the Node

* At first the node will show it is catching up.&#x20;
* Eventually the node will show the height of the latest block.&#x20;
*   The latest block number can be found on the [Mintscan](https://www.mintscan.io/akash) website for comparison.

    ```
    akash status
    ```

### Example/Sample Output

* Status output while Node is catching up to current block

```
akash status

{"NodeInfo":{"protocol_version":{"p2p":"8","block":"11","app":"0"},"id":"f2b42b91d103996efa12ab860c05dac66b8e9f7c","listen_addr":"tcp://0.0.0.0:26656","network":"akashnet-2","version":"0.34.19","channels":"40202122233038606100","moniker":"node","other":{"tx_index":"on","rpc_address":"tcp://0.0.0.0:26657"}},"SyncInfo":{"latest_block_hash":"D18299F966825C5886B7F88D677413F6564F323ADBF55C5E80AF76CA8E151E06","latest_app_hash":"4E6A696D911E7A238F4E4BD437712B197858E3A7ED319B12F38961B2C2960C47","latest_block_height":"6493433","latest_block_time":"2022-06-27T04:03:30.370092856Z","earliest_block_hash":"E25CE5DD10565D6D63CDA65C8653A15F962A4D2960D5EC45D1DC0A4DE06F8EE3","earliest_app_hash":"19526102DDBCE254BA71CC8E44185721D611635F638624C6F950EF31D3074E2B","earliest_block_height":"5851001","earliest_block_time":"2022-05-12T17:51:58.430492536Z","catching_up":true},"ValidatorInfo":{"Address":"CF6AC143794B35885AA4B29CA012DABFAEB88EAB","PubKey":{"type":"tendermint/PubKeyEd25519","value":"f0mUYVv5z2HCi4UmK72C/pxwbIu5tdDHEVc94yCLZQc="},"VotingPower":"0"}}
```
