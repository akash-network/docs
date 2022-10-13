# Edit SDL with Known IDs

In this step we will revisit and edit our initial SDL file with the known Validator and Node IDs.

## Validator Service Update

* Update the following entry in the SDL under the Validator service

`AKASH_UNCONDITIONAL_PEER_IDS`

* Use the node1 and node2 IDs captured in the previous steps as the comma separated values of this variable
* Once populated this variable should appear as below in the greater section (example IDs shown and should be your own)

```
   validator:
    image: ghcr.io/ovrclk/cosmos-omnibus:v0.1.6-akash-v0.16.3
    env:
      - MONIKER=validator
      - CHAIN_JSON=https://raw.githubusercontent.com/ovrclk/net/master/mainnet/meta.json
      - MINIMUM_GAS_PRICES=0.025uakt
      - FASTSYNC_VERSION=v2
      - AKASH_MODE=validator
      - AKASH_P2P_PEX=true
      - AKASH_UNCONDITIONAL_PEER_IDS=c955c77516b4c6fc62406a63303395fc97662c1e,b3035d5dfbfeb359c716bcb714ab383e6b73a5fd
      - AKASH_ADDR_BOOK_STRICT=false
      - AKASH_DOUBLE_SIGN_CHECK_HEIGHT=10
      - P2P_PERSISTENT_PEERS=f997dbd1048af671527857db422291a11d067975@65.21.198.247:26656,20180c45451739668f6e272e007818139dba31e7@88.198.62.198:2020,43544bc781b88d6785420427926d86a5332940b3@142.132.131.184:26656,ef80a9b5e100dd6a4bb0fa536322f437565aad39@38.146.3.167:26656,aa01698ec0d8bb96398e89b57ecb08bcca50fa21@65.21.199.148:26636,d2643edd1b3dce6615bc9925e20122c44d2ff763@172.106.17.158:26656,30b8008d4ea5069a8724a0aa73833493efa88e67@65.108.140.62:26656,157f7c0e1363bea36a10bfae2a9127f5c6dd2991@18.220.238.235:26656,8e8e0282408001bc9dfd8bc3696ed2a5201245b0@168.119.190.132:26656,a8da9010d07b69894765cfd27b1eca62f1cb1d55@13.214.178.23:26656,be3a538cebb28e7224db10920bb7fe32456e1aad@116.202.244.153:26656,070b3c936e2995bc269a2981702b87de05411baa@148.251.13.186:28656,eeacfa49aa225f5232d0456bd3e4111be11b516e@65.108.6.185:26656,e18d9d0c1ad94d6394913fbf902c9fc0f38b369e@34.148.214.23:26656
      - STATESYNC_RPC_SERVERS=https://akash-rpc.polkachu.com:443,https://akash-rpc.polkachu.com:443
      - S3_KEY=<redacted>
      - S3_SECRET=<redacted>
      - KEY_PASSWORD=<redacted>
      - KEY_PATH=akashvalidator
```

## Node Service Update

* Update the following entries in the SDL under the node1 and node2 services

`AKASH_PRIVATE_PEER_IDS`

`AKASH_UNCONDITIONAL_PEER_IDS`

* Use the validator ID captured in the previous steps as the comma separated values of this variable
* Once populated these variables should appear as below in the greater section (example ID shown and should be your own)
* Only `node1` example shown. Identical updates should be made to the `node2` service as well.

```
  node1:
    image: ghcr.io/ovrclk/cosmos-omnibus:v0.1.6-akash-v0.16.3
    env:
      - MONIKER=private_node_1
      - CHAIN_JSON=https://raw.githubusercontent.com/ovrclk/net/master/mainnet/meta.json
      - MINIMUM_GAS_PRICES=0.025uakt
      - FASTSYNC_VERSION=v2
      - AKASH_MODE=full
      - AKASH_P2P_PEX=true
      - AKASH_PRIVATE_PEER_IDS=2d76800f5a149510229aadf480f8ec02ac6e5297
      - AKASH_UNCONDITIONAL_PEER_IDS=2d76800f5a149510229aadf480f8ec02ac6e5297
      - AKASH_ADDR_BOOK_STRICT=false
      - STATESYNC_RPC_SERVERS=https://akash-rpc.polkachu.com:443,https://akash-rpc.polkachu.com:443
      - STATESYNC_SNAPSHOT_INTERVAL=500
      - S3_KEY=<redacted>
      - S3_SECRET=<redacted>
      - KEY_PASSWORD=<redacted>
      - KEY_PATH=akashnode1
```
