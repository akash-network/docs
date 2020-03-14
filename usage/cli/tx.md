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

| Command | Description |
| :--- | :--- |
| auth  | Auth transaction subcommands
| bank  | Bank transaction subcommands
| broadcast    |  Broadcast transactions generated offline
|deployment   |Deployment transaction subcommands
|  distribution| Distribution transactions subcommands
|  encode     |  Encode transactions generated offline
|  market     |  Transaction subcommands
|  multisign  |  Generate multisig signatures for transactions generated offline
|  provider   |  Deployment transaction subcommands
|  send       |  Create and sign a send tx
|  sign       |  Sign transactions generated offline
|  slashing   |  Slashing transactions subcommands
|  staking    |  Staking transaction subcommands

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

| Short | Verbose  | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -h | --help |  N | help for deployment |


## deployment -> close

Close deployment

**Usage**

```text
$ akash tx deployment close [flags]
```

**Example**

```shell
TODO

```

**Flags**

| Short | Verbose  | Required | Type | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  -a,| --account-number |N| uint   |    The account number of the signing account (offline mode only)
|  -b,| --broadcast-mode |N|string   | Transaction broadcasting mode (sync|async|block) (default "sync")
|     | --dry-run        |N|          |ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
|      |--dseq |N| uint            |    Deployment Sequence
|      |--fees |N| string          |    Fees to pay along with transaction; eg: 10uatom
|      |--from |N| string          |    Name or address of private key with which to sign
|      |--gas  |N| string          |     gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
|      |--gas-adjustment |N |float  |   adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
|      |--gas-prices |N| string    |    Gas prices to determine the transaction fee (e.g. 10uatom)
|      |--generate-only |N| |           Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
|  -h, |--help        |N||             help for close
|      |--indent      |N||             Add indent to JSON response
|      |--keyring-backend |N| string|   Select keyring's backend (os|file|test) (default "os")
|      |--ledger        |N||           Use a connected Ledger device
|      |--memo    |N|string|           Memo to send along with transaction
|      |--node      |N|string|         <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
|     | --owner |N| string  |           Deployment Owner
|  -s,| --sequence |N| uint    |        The sequence number of the signing account (offline mode only)
|     | --trust-node |N||              Trust connected full node (don't verify proofs for responses) (default true)
|  -y, |--yes      |N||                Skip tx broadcasting prompt confirmation



## deployment -> create

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

**Flags**

| Short | Verbose  | Required | Type | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  -a,| --account-number |N| uint   |    The account number of the signing account (offline mode only)
|  -b,| --broadcast-mode |N|string   | Transaction broadcasting mode (sync|async|block) (default "sync")
|     | --dry-run        |N|          |ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
|      |--dseq |N| uint            |    Deployment Sequence
|      |--fees |N| string          |    Fees to pay along with transaction; eg: 10uatom
|      |--from |N| string          |    Name or address of private key with which to sign
|      |--gas  |N| string          |     gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
|      |--gas-adjustment |N |float  |   adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
|      |--gas-prices |N| string    |    Gas prices to determine the transaction fee (e.g. 10uatom)
|      |--generate-only |N| |           Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
|  -h, |--help        |N||             help for create
|      |--indent      |N||             Add indent to JSON response
|      |--keyring-backend |N| string|   Select keyring's backend (os|file|test) (default "os")
|      |--ledger        |N||           Use a connected Ledger device
|      |--memo    |N|string|           Memo to send along with transaction
|      |--node      |N|string|         <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
|     | --owner |N| string  |           Deployment Owner
|  -s,| --sequence |N| uint    |        The sequence number of the signing account (offline mode only)
|     | --trust-node |N||              Trust connected full node (don't verify proofs for responses) (default true)
|  -y, |--yes      |N||                Skip tx broadcasting prompt confirmation


## deployment -> update

update deployment

**Usage**

```text
$ akash tx deployment update [sdl-file] [flags]
```

**Example**

```shell
 $ akash tx deployment update ~/Downloads/Files/riot.yml --from my-account

TODO

```

**Flags**

| Short | Verbose  | Required | Type | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  -a,| --account-number |N| uint   |    The account number of the signing account (offline mode only)
|  -b,| --broadcast-mode |N|string   | Transaction broadcasting mode (sync|async|block) (default "sync")
|     | --dry-run        |N|          |ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
|      |--dseq |N| uint            |    Deployment Sequence
|      |--fees |N| string          |    Fees to pay along with transaction; eg: 10uatom
|      |--from |N| string          |    Name or address of private key with which to sign
|      |--gas  |N| string          |     gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
|      |--gas-adjustment |N |float  |   adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
|      |--gas-prices |N| string    |    Gas prices to determine the transaction fee (e.g. 10uatom)
|      |--generate-only |N| |           Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
|  -h, |--help        |N||             help for create
|      |--indent      |N||             Add indent to JSON response
|      |--keyring-backend |N| string|   Select keyring's backend (os|file|test) (default "os")
|      |--ledger        |N||           Use a connected Ledger device
|      |--memo    |N|string|           Memo to send along with transaction
|      |--node      |N|string|         <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
|     | --owner |N| string  |           Deployment Owner
|  -s,| --sequence |N| uint    |        The sequence number of the signing account (offline mode only)
|     | --trust-node |N||              Trust connected full node (don't verify proofs for responses) (default true)
|  -y, |--yes      |N||                Skip tx broadcasting prompt confirmation



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

| Short | Verbose  | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -h | --help |  N | help for market |

## market -> bid-create

Create bid

**Usage**

```shell
  $ akash tx market bid-create [flags]

```

**Example**

```shell
    TODO
```

**Flags**

| Short | Verbose  | Required | Type | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  -a,| --account-number |N| uint   |    The account number of the signing account (offline mode only)
|  -b,| --broadcast-mode |N|string   | Transaction broadcasting mode (sync|async|block) (default "sync")
|     | --dry-run        |N|          |ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
|      |--dseq |N| uint            |    Deployment Sequence
|      |--fees |N| string          |    Fees to pay along with transaction; eg: 10uatom
|      |--from |N| string          |    Name or address of private key with which to sign
|      |--gas  |N| string          |     gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
|      |--gas-adjustment |N |float  |   adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
|      |--gas-prices |N| string    |    Gas prices to determine the transaction fee (e.g. 10uatom)
|      |--generate-only |N| |           Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
|  -h, |--help        |N||             help for create
|      |--indent      |N||             Add indent to JSON response
|      |--keyring-backend |N| string|   Select keyring's backend (os|file|test) (default "os")
|      |--ledger        |N||           Use a connected Ledger device
|      |--memo    |N|string|           Memo to send along with transaction
|      |--node      |N|string|         <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
|     | --owner |N| string  |           Deployment Owner
|  -s,| --sequence |N| uint    |        The sequence number of the signing account (offline mode only)
|     | --trust-node |N||              Trust connected full node (don't verify proofs for responses) (default true)
|  -y, |--yes      |N||                Skip tx broadcasting prompt confirmation

## market -> bid-close

Close bid

**Usage**

```shell
  $ akash tx market bid-close [flags]

```

**Example**

```shell
    $ akash tx market bid-close --from my-account

    {"chain_id":"mychain","account_number":"3","sequence":"4","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"market/msg-close-bid","value":{"id":{"owner":"","dseq":"0","gseq":0,"oseq":0,"provider":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84"}}}],"memo":""}

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

| Short | Verbose  | Required | Type | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  -a,| --account-number |N| uint   |    The account number of the signing account (offline mode only)
|  -b,| --broadcast-mode |N|string   | Transaction broadcasting mode (sync|async|block) (default "sync")
|     | --dry-run        |N|          |ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
|      |--dseq |N| uint            |    Deployment Sequence
|      |--fees |N| string          |    Fees to pay along with transaction; eg: 10uatom
|      |--from |N| string          |    Name or address of private key with which to sign
|      |--gas  |N| string          |     gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
|      |--gas-adjustment |N |float  |   adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
|      |--gas-prices |N| string    |    Gas prices to determine the transaction fee (e.g. 10uatom)
|      |--generate-only |N| |           Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
|  -h, |--help        |N||             help for create
|      |--indent      |N||             Add indent to JSON response
|      |--keyring-backend |N| string|   Select keyring's backend (os|file|test) (default "os")
|      |--ledger        |N||           Use a connected Ledger device
|      |--memo    |N|string|           Memo to send along with transaction
|      |--node      |N|string|         <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
|     | --owner |N| string  |           Deployment Owner
|  -s,| --sequence |N| uint    |        The sequence number of the signing account (offline mode only)
|     | --trust-node |N||              Trust connected full node (don't verify proofs for responses) (default true)
|  -y, |--yes      |N||                Skip tx broadcasting prompt confirmation



## market -> order-close

Close order

**Usage**

```shell
  $ akash tx market order-close [flags]

```

**Example**

```shell
$ akash tx market order-close --from my-account

{"chain_id":"mychain","account_number":"3","sequence":"5","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"market/msg-close-order","value":{"id":{"owner":"","dseq":"0","gseq":0,"oseq":0}}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
height: 0
txhash: F9D8EF721679C955A4BA44AE1EAF245C06C0B794C3DD18D1D89DE72A56282298
codespace: ""
code: 8
data: ""
rawlog: 'invalid pubkey: pubKey does not match signer address  with signer index:
  0'
logs: []
info: ""
gaswanted: 0
gasused: 0
tx: null
timestamp: ""

```

**Flags**

| Short | Verbose  | Required | Type | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  -a,| --account-number |N| uint   |    The account number of the signing account (offline mode only)
|  -b,| --broadcast-mode |N|string   | Transaction broadcasting mode (sync|async|block) (default "sync")
|     | --dry-run        |N|          |ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
|      |--dseq |N| uint            |    Deployment Sequence
|      |--fees |N| string          |    Fees to pay along with transaction; eg: 10uatom
|      |--from |N| string          |    Name or address of private key with which to sign
|      |--gas  |N| string          |     gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
|      |--gas-adjustment |N |float  |   adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
|      |--gas-prices |N| string    |    Gas prices to determine the transaction fee (e.g. 10uatom)
|      |--generate-only |N| |           Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
|  -h, |--help        |N||             help for create
|      |--indent      |N||             Add indent to JSON response
|      |--keyring-backend |N| string|   Select keyring's backend (os|file|test) (default "os")
|      |--ledger        |N||           Use a connected Ledger device
|      |--memo    |N|string|           Memo to send along with transaction
|      |--node      |N|string|         <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
|     | --owner |N| string  |           Deployment Owner
|  -s,| --sequence |N| uint    |        The sequence number of the signing account (offline mode only)
|     | --trust-node |N||              Trust connected full node (don't verify proofs for responses) (default true)
|  -y, |--yes      |N||                Skip tx broadcasting prompt confirmation



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
  create      Update provider
```

**Flags**

| Short | Verbose  | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -h | --help |  N | help for market |


## provider -> create

Create provider

**Usage**

```shell
  $ akash tx provider create [config-file] [flags]

```

**Example**

```shell
$ akash tx provider create ~/Downloads/Files/provider.yml --from my-account

{"chain_id":"mychain","account_number":"3","sequence":"5","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"provider/msg-create","value":{"owner":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","host-uri":"http://akash.sahithnarahari.com","attributes":[{"key":"cmVnaW9u","value":"c2Zv"},{"key":"bW9uaWtlcg==","value":"YWtoaWw="}]}}],"memo":""}

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

**Flags**

| Short | Verbose  | Required | Type | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  -a,| --account-number |N| uint   |    The account number of the signing account (offline mode only)
|  -b,| --broadcast-mode |N|string   | Transaction broadcasting mode (sync|async|block) (default "sync")
|     | --dry-run        |N|          |ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
|      |--dseq |N| uint            |    Deployment Sequence
|      |--fees |N| string          |    Fees to pay along with transaction; eg: 10uatom
|      |--from |N| string          |    Name or address of private key with which to sign
|      |--gas  |N| string          |     gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
|      |--gas-adjustment |N |float  |   adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
|      |--gas-prices |N| string    |    Gas prices to determine the transaction fee (e.g. 10uatom)
|      |--generate-only |N| |           Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
|  -h, |--help        |N||             help for create
|      |--indent      |N||             Add indent to JSON response
|      |--keyring-backend |N| string|   Select keyring's backend (os|file|test) (default "os")
|      |--ledger        |N||           Use a connected Ledger device
|      |--memo    |N|string|           Memo to send along with transaction
|      |--node      |N|string|         <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
|     | --owner |N| string  |           Deployment Owner
|  -s,| --sequence |N| uint    |        The sequence number of the signing account (offline mode only)
|     | --trust-node |N||              Trust connected full node (don't verify proofs for responses) (default true)
|  -y, |--yes      |N||                Skip tx broadcasting prompt confirmation
