# Get remote node status

> **Usage**

```text
akash status [flags]
```

> **Example**

```text
$ akash status

{
    "node_info":{
        "protocol_version":{
            "p2p":"7","block":"10","app":"0"
            },
        "id":"e4f0a97eacc3222ea97c42bf93c50afcc98f6341",
        "listen_addr":"tcp://0.0.0.0:26656",
        "network":"mychain",
        "version":"0.33.0",
        "channels":"4020212223303800",
        "moniker":"mychain",
        "other":{"tx_index":"on","rpc_address":"tcp://127.0.0.1:26657"}
    },
    "sync_info":{
        "latest_block_hash":"781035A4F2F1FB97ACF0C127C2296623BBC82EEC9FDF8C00FE26CE58D363DF68","latest_app_hash":"BF27325B8BB1002D0F458F37D792E6E45D8F422B4B99A8B599A653CDAAE39145","latest_block_height":"10595","latest_block_time":"2020-03-12T09:51:12.171716104Z","catching_up":false
    },
    "validator_info":{
        "address":"15A9E2C091AED0734D0BCB47781E54CF81F0F4F8",
        "pub_key":{
            "type":"tendermint/PubKeyEd25519","value":"IupzNoyVFg24D7KloPBbqHvwf0AFNS4mt99kZOUzQ6w="},"voting_power":"100"
    }
}

```

> In the example above, the details are about node version and latest block on the network

Use `akash status` to check status of a node (default "http://api.akashtest.net:80").

**Arguments**

No arguments.

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

**Global Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -d | --data | string | N | data directory (default "~/.akash") |
| -m | --mode | string | N | output mode (interactive|shell|json) (default "interactive") |
