# Transfer Tokens

> **Usage**

```text
akashctl tx send [from_key_or_address] [to_address] [amount] [flags]
```

> **Example**

```sh
$ akashctl tx send akash180w6py0ke8f8su2u7zhvrrf57qt5s9dzhn7qzd akash1yg7y928farnqeggrduu7l4j427vez9j3uf40jp 10akash --memo "send monies" -y --fees 10akash --trace
height: 0
txhash: 2D3E80443E491B9246351229D543C66D9BE8815EF35B569DD6EBE187A7D0AF9D
codespace: ""
code: 0
data: ""
rawlog: '[]'
logs: []
info: ""
gaswanted: 0
gasused: 0
tx: null
timestamp: ""
```

> In the example above, the amount is given in AKASH. You may also specify the amount in microAKASH \(AKASH \* 10^-6\) using the `u` unit suffix \(e.g. `100u` for 100 microAKASH\).

Use `akashctl tx send` to send tokens from one account to another.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| from-accout | string | Y | The key addres of the senders account. |
| to-account | string | Y | The key value for the recipient account. |
| amount | float | Y | The amount of tokens to send. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
|  | --dry-run | string | N | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it |
|    | --fees | string | N | Fees to pay along with transaction; eg: 10uakash |
|  | --gas | string | N | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000") |
|  | --gas-adjustment | float | N | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|  | --gas-prices | string | N | Gas prices to determine the transaction fee (e.g. 10uakt) |
|  | --keyring-backend | string | N | Select keyring's backend (os|file|test) (default "os") |
|  | --memo | string | N | Memo to send along with transaction |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
|  | --nonce | uint | N | Nonce. |
| -y | --yes | bool | N | Skip tx broadcasting prompt confirmation |


**Global Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
|  | --chain-id | string | N | Chain ID of tendermint node |
| -e | --encoding | string | Binary encoding (hex|b64|btc) (default "hex") |
|  | --home | string | N | data directory (default "~/.akashctl") |
| -o | --output | string | N | Output format (text|json) (default "text") |
|  | --trace | string | N | print out full stack trace on errors |
