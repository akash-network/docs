# STEP4 - Initialize New Node

In this step we will initialize our new Akash Node.  In the background several configuration files will be created which can be edited later as needed.

_**Before starting the node, we specify the Akash network and chain ID**_

```
AKASH_NET="https://raw.githubusercontent.com/akash-network/net/master/mainnet"

export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

_**Start the node**_

```
akash init --chain-id "$AKASH_CHAIN_ID" "$AKASH_MONIKER"
```

_**Example/Expected Result**_

```
{"app_message":{"audit":{"attributes":[]},"auth":{"accounts":[],"params":{"max_memo_characters":"256","sig_verify_cost_ed25519":"590","sig_verify_cost

<output truncated>

},"upgrade":{},"vesting":{}},"chain_id":"akashnet-2","gentxs_dir":"","moniker":"chainzero","node_id":"2f4491952df08e69fd988c6f5d6ed21e25318fbc"}
```
