# Akash SDL Review

Akash deployments are created using [Stack Definition Language (SDL)](../../readme/stack-definition-language.md) files that serve as the recipe for your deployments.  In this section we detail the Omnibus SDL used for the Akash Validator deployment.

## Akash Validator SDL Template

The SDL template for the Akash Validator build is located in this [GitHub repository](https://github.com/ovrclk/cosmos-omnibus/blob/master/\_examples/validator-and-private-sentries/deploy.yml).

Copy the SDL located in the repository into a local editor for customizations covered in upcoming steps.

## Initial SDL Customizations

All SDL edits necessary are environment variable related.  Within the SDL, we will only edit values within the `services` section and  `env` subsections.  All other segments of the SDL can be used from the template without need to edit.

### Validator Service

* The first service listed in the SDL and which requires customization is the `validator` service
* Recommended `env` variable updates are detailed in the code block below
* **NOTE** - eventually we will need to additionally update the AKASH\_UNCONDITIONAL\_PEER\_IDS variable. But at this point in the process these IDs - which are the IDs of the Sentry nodes - are not known.  Based on this we will update this field later.

Update the following env variables with suggested values:

```
AKASH_P2P_PEX=true

P2P_PERSISTENT_PEERS=f997dbd1048af671527857db422291a11d067975@65.21.198.247:26656,20180c45451739668f6e272e007818139dba31e7@88.198.62.198:2020,43544bc781b88d6785420427926d86a5332940b3@142.132.131.184:26656,ef80a9b5e100dd6a4bb0fa536322f437565aad39@38.146.3.167:26656,aa01698ec0d8bb96398e89b57ecb08bcca50fa21@65.21.199.148:26636,d2643edd1b3dce6615bc9925e20122c44d2ff763@172.106.17.158:26656,30b8008d4ea5069a8724a0aa73833493efa88e67@65.108.140.62:26656,157f7c0e1363bea36a10bfae2a9127f5c6dd2991@18.220.238.235:26656,8e8e0282408001bc9dfd8bc3696ed2a5201245b0@168.119.190.132:26656,a8da9010d07b69894765cfd27b1eca62f1cb1d55@13.214.178.23:26656,be3a538cebb28e7224db10920bb7fe32456e1aad@116.202.244.153:26656,070b3c936e2995bc269a2981702b87de05411baa@148.251.13.186:28656,eeacfa49aa225f5232d0456bd3e4111be11b516e@65.108.6.185:26656,e18d9d0c1ad94d6394913fbf902c9fc0f38b369e@34.148.214.23:26656

STATESYNC_RPC_SERVERS=https://akash-rpc.polkachu.com:443,https://akash-rpc.polkachu.com:443

S3_KEY=<specify the key captured in FileBase>

S3_SECRET=<specify the secret captured in FileBase>

KEY_PASSWORD=<password of your choice that is used in encryption of files in FileBase>

KEY_PATH=akashvalidator
```

#### Example/Populated Variables

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
      - AKASH_UNCONDITIONAL_PEER_IDS=<node-1-id>,<node-2-id>...
      - AKASH_ADDR_BOOK_STRICT=false
      - AKASH_DOUBLE_SIGN_CHECK_HEIGHT=10
      - P2P_PERSISTENT_PEERS=f997dbd1048af671527857db422291a11d067975@65.21.198.247:26656,20180c45451739668f6e272e007818139dba31e7@88.198.62.198:2020,43544bc781b88d6785420427926d86a5332940b3@142.132.131.184:26656,ef80a9b5e100dd6a4bb0fa536322f437565aad39@38.146.3.167:26656,aa01698ec0d8bb96398e89b57ecb08bcca50fa21@65.21.199.148:26636,d2643edd1b3dce6615bc9925e20122c44d2ff763@172.106.17.158:26656,30b8008d4ea5069a8724a0aa73833493efa88e67@65.108.140.62:26656,157f7c0e1363bea36a10bfae2a9127f5c6dd2991@18.220.238.235:26656,8e8e0282408001bc9dfd8bc3696ed2a5201245b0@168.119.190.132:26656,a8da9010d07b69894765cfd27b1eca62f1cb1d55@13.214.178.23:26656,be3a538cebb28e7224db10920bb7fe32456e1aad@116.202.244.153:26656,070b3c936e2995bc269a2981702b87de05411baa@148.251.13.186:28656,eeacfa49aa225f5232d0456bd3e4111be11b516e@65.108.6.185:26656,e18d9d0c1ad94d6394913fbf902c9fc0f38b369e@34.148.214.23:26656
      - STATESYNC_RPC_SERVERS=node1,node2
      - S3_KEY=A397A7<redacted>
      - S3_SECRET=7ZHVFsE2<redaacted>
      - KEY_PASSWORD=Validator4Akash!#!
      - KEY_PATH=akashvalidator

```

### Sentry Node #1 Service

* The second service listed in the SDL that requires customization is for the `node1` service.
* Recommended `env` variable updates are detailed in the code block below
* **NOTE** - eventually we will need to additionally update the `AKASH_PRIVATE_PEER_IDS` and `AKASH_UNCONDITIONAL_PEER_IDS`  variables.  But at this point in the process these IDs - which is the ID of the Validator node - is not known. We will update these fields later.

Update the following env variables with suggested values:

```
STATESYNC_RPC_SERVERS=https://akash-rpc.polkachu.com:443,https://akash-rpc.polkachu.com:443

S3_KEY=<specify the key captured in FileBase>

S3_SECRET=<specify the secret captured in FileBase>

KEY_PASSWORD=<password of your choice that is used in encryption of files in FileBase>

KEY_PATH=akashnode1
```

#### Example/Populated Variables

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
      - AKASH_PRIVATE_PEER_IDS=<validatorid>
      - AKASH_UNCONDITIONAL_PEER_IDS=<validatorid>
      - AKASH_ADDR_BOOK_STRICT=false
      - STATESYNC_RPC_SERVERS=https://akash-rpc.polkachu.com:443,https://akash-rpc.polkachu.com:443
      - STATESYNC_SNAPSHOT_INTERVAL=500
      - S3_KEY=<redacted>
      - S3_SECRET=<redacted>
      - KEY_PASSWORD=<redacted>
      - KEY_PATH=akashnode1
```

### Sentry Node #2 Service

* The third and final service list in the SDL that requires customization is for the `node2` service.
* Recommended `env` variable updates are detailed in the code block below
* **NOTE** - eventually we will need to additionally update the `AKASH_PRIVATE_PEER_IDS` and `AKASH_UNCONDITIONAL_PEER_IDS` variables. But at this point in the process these IDs - which is the ID of the Validator node is not known - and based on this we will update this field later.

Update the following env variables with suggested values:

```
STATESYNC_RPC_SERVERS=https://akash-rpc.polkachu.com:443,https://akash-rpc.polkachu.com:443

S3_KEY=<specify the key captured in FileBase>

S3_SECRET=<specify the secret captured in FileBase>

KEY_PASSWORD=<password of your choice that is used in encryption of files in FileBase>

KEY_PATH=akashnode2
```

#### Example/Populated Variables

```
  node2:
    image: ghcr.io/ovrclk/cosmos-omnibus:v0.1.6-akash-v0.16.3
    env:
      - MONIKER=private_node_1
      - CHAIN_JSON=https://raw.githubusercontent.com/ovrclk/net/master/mainnet/meta.json
      - MINIMUM_GAS_PRICES=0.025uakt
      - FASTSYNC_VERSION=v2
      - AKASH_MODE=full
      - AKASH_P2P_PEX=true
      - AKASH_PRIVATE_PEER_IDS=<validatorid>
      - AKASH_UNCONDITIONAL_PEER_IDS=<validatorid>
      - AKASH_ADDR_BOOK_STRICT=false
      - STATESYNC_RPC_SERVERS=https://akash-rpc.polkachu.com:443,https://akash-rpc.polkachu.com:443
      - STATESYNC_SNAPSHOT_INTERVAL=500
      - S3_KEY=<redacted>
      - S3_SECRET=<redacted>
      - KEY_PASSWORD=<redacted>
      - KEY_PATH=akashnode2
```
