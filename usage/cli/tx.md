# Transactions subcommands

**Usage**

```shell
$  akash tx [command]
```

**Example**

```shell

Usage:
  akash tx [command]

Available Commands:
  auth         Auth transaction subcommands
  bank         Bank transaction subcommands
  broadcast    Broadcast transactions generated offline
  deployment   Deployment transaction subcommands
  distribution Distribution transactions subcommands
  encode       Encode transactions generated offline
  gov          Governance transactions subcommands
  market       Transaction subcommands
  multisign    Generate multisig signatures for transactions generated offline
  provider     Deployment transaction subcommands
  send         Create and sign a send tx
  sign         Sign transactions generated offline
  slashing     Slashing transactions subcommands
  staking      Staking transaction subcommands

Flags:
  -h, --help   help for tx

Global Flags:
   -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors


Use "akash tx [command] --help" for more information about a command.
```

Use `akash tx` to create transactions.

**Available Commands**

| Command      | Description                                                     |
|:-------------|:----------------------------------------------------------------|
| auth         | Auth transaction subcommands                                    |
| bank         | Bank transaction subcommands                                    |
| broadcast    | Broadcast transactions generated offline                        |
| deployment   | Deployment transaction subcommands                              |
| distribution | Distribution transactions subcommands                           |
| encode       | Encode transactions generated offline                           |
| gov          | Governance transactions subcommands                             |
| market       | Transaction subcommands                                         |
| multisign    | Generate multisig signatures for transactions generated offline |
| provider     | Deployment transaction subcommands                              |
| send         | Create and sign a send tx                                       |
| sign         | Sign transactions generated offline                             |
| slashing     | Slashing transactions subcommands                               |
| staking      | Staking transaction subcommands                                 |

## deployment

Deployment transaction subcommands

**Usage**

```text
$ akash tx deployment [flags]
$ akash tx deployment [command]
```

**Available Commands**

```text
  close       Close deployment
  create      Create deployment
  update      update deployment
```

**Flags**

| Short | Verbose | Required | Description         |
|:------|:--------|:---------|:--------------------|:-|
| -h    | --help  | N        | help for deployment |

### create

Create deployment

**Usage**

```text
$ akash tx deployment create [sdl-file] [flags]
```

**Example**

```shell
 $ akash tx deployment create ~/Downloads/Files/riot.yml --from my-account

 {"chain_id":"mychain","account_number":"3","sequence":"3","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"deployment/msg-create","value":{"owner":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","groups":[{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"akash","amount":"30"}}]}]}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
height: 0
txhash: C354ED8B810FD3CF6A81D7D072AA5441F4F5BAC8AFA77D69E268D67E0B63C5EB
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
**Arguments**

| Argument | Type   | Required | Description                 |
|:---------|:-------|:---------|:----------------------------|
| sdl-file | string | Y        | Deployment config file path |

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | N        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

### close

Close deployment

**Usage**

```shell
$ akash tx deployment close [flags]
```

**Example**

```shell
$ akash tx deployment close --dseq 83 --from master
{"chain_id":"devnet","account_number":"9","sequence":"12","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"deployment/msg-close","value":{"ID":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83"}}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
{"height":"8521","txhash":"62032590BD6BEE6551584631335471623CC9FA86E0F3ED01D4D3E6B31A54E708","codespace":"deployment","code":5,"raw_log":"Deployment closed: failed to execute message; message index: 0","gas_wanted":"200000","gas_used":"35885"}
```

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --dseq            | Y        | uint   | Deployment Sequence                                                                                                                                       |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for close                                                                                                                                            |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
|       | --owner           | N        | string | Deployment Owner                                                                                                                                          |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

### update

update deployment

**Usage**

```text
$ akash tx deployment update [sdl-file] [flags]
```

**Example**

```shell
$ akash tx deployment update riot.yml --from master

{"chain_id":"devnet","account_number":"9","sequence":"13","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"deployment/msg-update","value":{"ID":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"0"},"Version":""}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
{"height":"0","txhash":"F021BDE4DA5F4F46D4DAEE21499A134082C5829A9BB195AAD9DABF6AF62DE175","codespace":"undefined","code":111222,"raw_log":"internal error"}
```

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --dseq            | N        | uint   | Deployment Sequence                                                                                                                                       |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | N        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
|       | --owner           | N        | string | Deployment Owner                                                                                                                                          |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |



## market

**Usage**

```text
 $ akash tx market [flags]
 $ akash tx market [command]
```

**Available Commands**

```text
  bid-close   Close bid
  bid-create  Create bid
  order-close Create bid
```

**Flags**

| Short | Verbose | Required | Description     |
|:------|:--------|:---------|:----------------|:-|
| -h    | --help  | N        | help for market |

### bid-create

Create bid

**Usage**

```shell
  $ akash tx market bid-create [flags]
```

**Example**

```shell
$ akash tx market bid-create --owner akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf --dseq 14 --gseq 1 --oseq 5 --price 20stake  --from provider

{"chain_id":"devnet","account_number":"9","sequence":"13","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"market/msg-create-bid","value":{"order":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":5},"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","price":{"denom":"stake","amount":"20"}}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
{"height":"8642","txhash":"BBF7AAB09655A28F238741B7A9FB8948BE95CDF80598BB112BC0C3FB7EB20D2B","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-bid\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"bid-created\"},{\"key\":\"owner\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"},{\"key\":\"dseq\",\"value\":\"14\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"5\"},{\"key\":\"provider\",\"value\":\"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"create-bid"},{"key":"module","value":"market"},{"key":"action","value":"bid-created"},{"key":"owner","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"},{"key":"dseq","value":"14"},{"key":"gseq","value":"1"},{"key":"oseq","value":"5"},{"key":"provider","value":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"}]}]}],"gas_wanted":"200000","gas_used":"42627"}
```

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --dseq            | Y        | uint   | Deployment Sequence                                                                                                                                       |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
|       | --gseq            | Y        | uint32 | Group sequence number                                                                                                                                     |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
|       | --oseq            | Y        | uint32 | Order sequence number                                                                                                                                     |
|       | --owner           | Y        | string | Deployment Owner                                                                                                                                          |
|       | --price           | Y        | string | Bid Price                                                                                                                                                 |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

### bid-close

Close bid

**Usage**

```shell
  $ akash tx market bid-close [flags]

```

**Example**

```shell
    $ akash tx market bid-close --owner akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf --dseq 14 --gseq 1 --oseq 5 --from provider

    {"chain_id":"mychain","account_number":"3","sequence":"4","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"market/msg-close-bid","value":{"id":{"owner":"","dseq":"23","gseq":1,"oseq":1,"provider":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84"}}}],"memo":""}

    confirm transaction before signing and broadcasting [y/N]: y
    height: 0
    txhash: 92DFAD06434F6ADEB6F8C5E1280871E4E67A76DCEAF03B5A5F1E6E74374C7F51
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

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --dseq            | Y        | uint   | Deployment Sequence                                                                                                                                       |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
|       | --gseq            | Y        | uint32 | Group sequence number                                                                                                                                     |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
|       | --oseq            | Y        | uint32 | Order sequence number                                                                                                                                     |
|       | --owner           | Y        | string | Deployment Owner                                                                                                                                          |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |



### order-close

Close order

**Usage**

```shell
  $ akash tx market order-close [flags]

```

**Example**

```shell
$ akash tx market order-close --owner akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf --dseq 14 --gseq 1 --oseq 5 --from master -y

{"height":"8682","txhash":"7FC55085F67B47433C3B677FFEE4DA6469A6F61589DFF0F966A934DB1EA18878","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"close-order\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"order-closed\"},{\"key\":\"owner\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"},{\"key\":\"dseq\",\"value\":\"14\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"5\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"lease-closed\"},{\"key\":\"owner\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"},{\"key\":\"dseq\",\"value\":\"14\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"5\"},{\"key\":\"provider\",\"value\":\"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"close-order"},{"key":"module","value":"market"},{"key":"action","value":"order-closed"},{"key":"owner","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"},{"key":"dseq","value":"14"},{"key":"gseq","value":"1"},{"key":"oseq","value":"5"},{"key":"module","value":"market"},{"key":"action","value":"lease-closed"},{"key":"owner","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"},{"key":"dseq","value":"14"},{"key":"gseq","value":"1"},{"key":"oseq","value":"5"},{"key":"provider","value":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"}]}]}],"gas_wanted":"200000","gas_used":"53641"}

```

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --dseq            | Y        | uint   | Deployment Sequence                                                                                                                                       |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
|       | --gseq            | Y        | uint32 | Group sequence number                                                                                                                                     |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
|       | --oseq            | Y        | uint32 | Order sequence number                                                                                                                                     |
|       | --owner           | Y        | string | Deployment Owner                                                                                                                                          |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |



## provider

Deployment transaction subcommands

**Usage**

```text
  $ akash tx provider [flags]
  $ akash tx provider [command]
```

**Available Commands**

```text
  create      Create provider
  update      Update provider
```

**Flags**

| Short | Verbose | Required | Description     |
|:------|:--------|:---------|:----------------|:-|
| -h    | --help  | N        | help for market |


### create

Create provider

**Usage**

```shell
  $ akash tx provider create [config-file] [flags]

```

**Example**

```shell
$ akash tx provider create ~/Downloads/Files/provider.yml --from my-account

{"chain_id":"mychain","account_number":"3","sequence":"5","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"provider/msg-create","value":{"owner":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","host-uri":"http://akash.ovrclk.com","attributes":[{"key":"cmVnaW9u","value":"c2Zv"},{"key":"bW9uaWtlcg==","value":"YWtoaWw="}]}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
height: 0
txhash: 226E9AF9FD7018EDEB9EEC6B8ED9EECC80912C58490249FAC36DCD11685C748C
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
**Arguments**

| Argument    | Type   | Required | Description               |
|:------------|:-------|:---------|:--------------------------|
| config-file | string | Y        | Provider config file path |

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | N        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

### update

Update provider

**Usage**

```shell
  $ akash tx provider update [config-file] [flags]

```

**Example**

```shell
$ akash tx provider update ~/Downloads/Files/provider.yml --from my-account

{"chain_id":"mychain","account_number":"3","sequence":"5","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"provider/msg-create","value":{"owner":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","host-uri":"http://akash.ovrclk.com","attributes":[{"key":"cmVnaW9u","value":"c2Zv"},{"key":"bW9uaWtlcg==","value":"YWtoaWw="}]}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
height: 0
txhash: 226E9AF9FD7018EDEB9EEC6B8ED9EECC80912C58490249FAC36DCD11685C748C
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
**Arguments**

| Argument    | Type   | Required | Description                                 |
|:------------|:-------|:---------|:--------------------------------------------|
| config-file | string | Y        | Provider config file path with updated data |

**Flags**

| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | N        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for update                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |
