# Transaction Commands

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
      --home string       directory for config and data (default "/home/ubuntu/.akash ")
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

## `auth`

Transaction commands for the auth module

**Usage**

```text
  akash tx auth [flags]
  akash tx auth [command]
```

**Available Commands**

```text
  multisign   Generate multisig signatures for transactions generated offline
  sign        Sign transactions generated offline
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `multisign`

Sign transactions created with the --generate-only flag that require multisig signatures.
Read signature(s) from [signature] file(s), generate a multisig signature compliant to the
multisig key [name], and attach it to the transaction read from [file].

**Usage**

```text
  akash tx auth multisign [file] [name] [[signature]...] [flags]
```

**Example**

```text
$ akash tx auth multisign transaction.json k1k2k3 k1sig.json k2sig.json k3sig.json
```
If the flag --signature-only flag is on, it outputs a JSON representation
of the generated signature only.

The --offline flag makes sure that the client will not reach out to an external node.
Thus account number or sequence number lookups will not be performed and it is
recommended to set such parameters manually

**Arguments**

| Argument        | Type   | Required | Description                                 |
|:----------------|:-------|:---------|:--------------------------------------------|
| file            | string | Y        | Path of file generated with --generate flag |
| name            | string | Y        | Name of the key                             |
| signature files | string | N        | Path of signature files (can be multiple)   |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
|       | --offline         | N        |        | Offline mode. Do not query a full node                                                                                                                    |
|       | --output-document | N        | string | The document will be written to the given file instead of STDOUT                                                                                          |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --signature-only  | N        |        | Print only the generated signature, then exit                                                                                                             |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `sign`

It will read a transaction from [file], sign it, and print its JSON encoding.

If the flag --signature-only flag is set, it will output a JSON representation
of the generated signature only.

The --multisig=<multisig_key> flag generates a signature on behalf of a multisig account
key. It implies --signature-only. Full multisig signed transactions may eventually
be generated via the 'multisign' command.

**Usage**

```text
  akash tx auth sign [file] [flags]
```

**Example**

```shell
$ akash tx auth sign ./1.json --from master
{"type":"cosmos-sdk/StdTx","value":{"msg":[{"type":"cosmos-sdk/MsgSend","value":{"from_address":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","to_address":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","amount":[{"denom":"stake","amount":"10"}]}}],"fee":{"amount":[],"gas":"200000"},"signatures":[{"pub_key":{"type":"tendermint/PubKeySecp256k1","value":"A+hCkyWd4cWG0KD+GgCxHEOUzll1cl5VvoGgDvVIwF3E"},"signature":"Fc3Wk30fixtfA/68mtxasQPntGOOoQiXJwBw7ZGKmrs+n8wXlnk2/WuAlT7bgGXBfJNUGe2rxLmg6eEoRYj0QQ=="}],"memo":""}}
```

**Arguments**

| Argument | Type   | Required | Description                                 |
|:---------|:-------|:---------|:--------------------------------------------|
| file     | string | Y        | Path of file generated with --generate flag |

**Flags**
| Short | Verbose               | Required | Type   | Description                                                                                                                                               |
|:------|:----------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number      | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode      | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run             | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees                | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from                | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas                 | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment      | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices          | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only       | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help                | N        |        | help for create                                                                                                                                           |
|       | --indent              | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend     | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger              | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo                | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --multisig            | N        | string | Address of the multisig account on behalf of which the transaction shall be signed                                                                        |
|       | --node                | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
|       | --offline             | N        |        | Offline mode. Do not query a full node                                                                                                                    |
|       | --output-document     | N        | string | The document will be written to the given file instead of STDOUT                                                                                          |
| -s,   | --sequence            | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --signature-only      | N        |        | Print only the generated signature, then exit                                                                                                             |
|       | --trust-node          | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
|       | --validate-signatures | N        |        | Print the addresses that must sign the transaction, those who have already signed it, and make sure that signatures are in the correct order              |
| -y,   | --yes                 | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `bank`

Transaction commands for the bank module

**Usage**

```text
  akash tx bank [flags]
  akash tx bank [command]
```

**Available Commands**

```text
  send        Create and sign a send tx
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `send`

Create and sign a send tx.

**Usage**

```text
  akash tx bank send [from_key_or_address] [to_address] [amount] [flags]
```

**Example**

```shell
$ akash tx bank send bob akash12wlzqjelrt87r3u56ps4m8lk7wavx5m5jg9cax 10000000uakt -y -o json

{"height":"0","txhash":"116ED246AFF9F9B58036AECAA5EFE81AA7A788CC625CC2A4ADAFC68378834413","raw_log":"[]"}
```
**Arguments**

| Argument            | Type   | Required | Description                        |
|:--------------------|:-------|:---------|:-----------------------------------|
| from_key_or_address | string | Y        | From address or key name           |
| to_address          | string | Y        | To address                         |
| amount              | string | Y        | Amount need to send Eg: 10uakt |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `broadcast`

Broadcast transactions created with the --generate-only
flag and signed with the sign command. Read a transaction from [file_path] and
broadcast it to a node. If you supply a dash (-) argument in place of an input
filename, the command reads from standard input.

**Usage**

```text
  akash tx broadcast [file_path] [flags]
```

**Example**

```shell
$ akash tx broadcast ./1.json 
{
  "height": "0",
  "txhash": "7A902A6BFB2B03DC5420BA0EE6D2C990886838714F3BF52984BA63E0190C2548",
  "codespace": "sdk",
  "code": 15,
  "raw_log": "no signatures supplied",
  "gas_wanted": "200000"
}
```
**Arguments**

| Argument  | Type   | Required | Description                         |
|:----------|:-------|:---------|:------------------------------------|
| file_path | string | Y        | Path of generated transaction file. |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `distribution`

Transaction commands for the distribution module

**Usage**

```text
  akash tx distribution [flags]
  akash tx distribution [command]
```

**Available Commands**

```text
  fund-community-pool  Funds the community pool with the specified amount
  set-withdraw-addr    change the default withdraw address for rewards associated with an address
  withdraw-all-rewards withdraw all delegations rewards for a delegator
  withdraw-rewards     Withdraw rewards from a given delegation address, and optionally withdraw validator commission if the delegation address given is a validator operator
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `fund-community-pool`

Funds the community pool with the specified amount.

**Usage**

```text
  akash tx distribution fund-community-pool [amount] [flags]
```

**Example**

```shell
$ akash tx distribution fund-community-pool 10stake --from master
```
**Arguments**

| Argument | Type   | Required | Description                                        |
|:---------|:-------|:---------|:---------------------------------------------------|
| amount   | string | Y        | Amount to be funded in community pool. Eg: 10stake |

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `set-withdraw-addr`

Set the withdraw address for rewards associated with a delegator address.

**Usage**

```text
  akash tx distribution set-withdraw-addr [withdraw-addr] [flags]
```

**Example**

```shell
$ akash tx distribution set-withdraw-addr akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf --from master -y
{"height":"10128","txhash":"0C27E99ACF377EB7B9B219F8CB23E013FB10EA427E399498EE38A8E9C3C68349","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"set_withdraw_address\"},{\"key\":\"module\",\"value\":\"distribution\"},{\"key\":\"sender\",\"value\":\"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug\"}]},{\"type\":\"set_withdraw_address\",\"attributes\":[{\"key\":\"withdraw_address\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"set_withdraw_address"},{"key":"module","value":"distribution"},{"key":"sender","value":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"}]},{"type":"set_withdraw_address","attributes":[{"key":"withdraw_address","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"}]}]}],"gas_wanted":"200000","gas_used":"37593"}
```
**Arguments**

| Argument      | Type   | Required | Description                  |
|:--------------|:-------|:---------|:-----------------------------|
| withdraw-addr | string | Y        | Withdraw address for rewards |

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `withdraw-all-rewards`

Withdraw all rewards for a single delegator.

**Usage**

```text
  akash tx distribution withdraw-all-rewards [flags]
```

**Example**

```shell
$ akash tx distribution withdraw-all-rewards --from master -y
{"height":"10214","txhash":"D5AF2E82A30CE29D265F39764DDE6F3821439B70427692EB729F20039DB5E54D","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"withdraw_delegator_reward\"},{\"key\":\"sender\",\"value\":\"akash1jv65s3grqf6v6jl3dp4t6c9t9rk99cd82yfms9\"},{\"key\":\"module\",\"value\":\"distribution\"},{\"key\":\"sender\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"},{\"key\":\"amount\",\"value\":\"549533stake\"}]},{\"type\":\"withdraw_rewards\",\"attributes\":[{\"key\":\"amount\",\"value\":\"549533stake\"},{\"key\":\"validator\",\"value\":\"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"withdraw_delegator_reward"},{"key":"sender","value":"akash1jv65s3grqf6v6jl3dp4t6c9t9rk99cd82yfms9"},{"key":"module","value":"distribution"},{"key":"sender","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"},{"key":"amount","value":"549533stake"}]},{"type":"withdraw_rewards","attributes":[{"key":"amount","value":"549533stake"},{"key":"validator","value":"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr"}]}]}],"gas_wanted":"200000","gas_used":"88842"}
```
**Arguments**

None

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `withdraw-rewards`

Withdraw rewards from a given delegation address, and optionally withdraw validator commission if the delegation address given is a validator operator.

**Usage**

```text
   akash tx distribution withdraw-rewards [validator-addr] [flags]
```

**Example**

```shell
$ akash tx distribution withdraw-rewards akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr --from akhil -y
{"height":"10270","txhash":"5EF865C0E489FFC58B3D7D6FCC67395A68ACDCF4449CCF6A620B9275F02896C1","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"withdraw_delegator_reward\"},{\"key\":\"sender\",\"value\":\"akash1jv65s3grqf6v6jl3dp4t6c9t9rk99cd82yfms9\"},{\"key\":\"module\",\"value\":\"distribution\"},{\"key\":\"sender\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"},{\"key\":\"amount\",\"value\":\"3012stake\"}]},{\"type\":\"withdraw_rewards\",\"attributes\":[{\"key\":\"amount\",\"value\":\"3012stake\"},{\"key\":\"validator\",\"value\":\"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"withdraw_delegator_reward"},{"key":"sender","value":"akash1jv65s3grqf6v6jl3dp4t6c9t9rk99cd82yfms9"},{"key":"module","value":"distribution"},{"key":"sender","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"},{"key":"amount","value":"3012stake"}]},{"type":"withdraw_rewards","attributes":[{"key":"amount","value":"3012stake"},{"key":"validator","value":"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr"}]}]}],"gas_wanted":"200000","gas_used":"89979"}
```
**Arguments**

| Argument          | Type   | Required | Description       |
|:------------------|:-------|:---------|:------------------|
| validator_address | string | Y        | Validator address |

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --commission      | N        |        | also withdraw validator's commission                                                                                                                      |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `encode`

Encode transactions created with the --generate-only flag and signed with the sign command.
Read a transaction from <file>, serialize it to the Amino wire protocol, and output it as base64.
If you supply a dash (-) argument in place of an input filename, the command reads from standard input.

**Usage**

```text
  akash tx encode [file_path] [flags]
```

**Example**

```shell
$ akash tx encode ./mytx.json 
"SSgoFqkKPaijYZoKFNA1B6+8xHFoU5Dyaec2B8H+BFZAEhQUECznTGGLVWK40Vnz0K4vRT96RxoLCgVzdGFrZRICMTASBBDAmgw="
```
**Arguments**

| Argument  | Type   | Required | Description                         |
|:----------|:-------|:---------|:------------------------------------|
| file_path | string | Y        | Path of generated transaction file. |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `gov`

Transaction commands for the gov module

**Usage**

```text
  akash tx gov [flags]
  akash tx gov [command]
```

**Available Commands**

```text
  deposit         Deposit tokens for an active proposal
  submit-proposal Submit a proposal along with an initial deposit
  vote            Vote for an active proposal, options: yes/no/no_with_veto/abstain
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `submit-proposal`

Submit a proposal along with an initial deposit.
Proposal title, description, type and deposit can be given directly or through a proposal JSON file.

**Usage**

```text
  akash tx gov submit-proposal [flags]
  akash tx gov submit-proposal [command]
```

**Example**

```shell
$ akash tx gov submit-proposal --title="Test Proposal" --description="My awesome proposal" --type="Text" --deposit="10stake" --from master -y
{"height":"10426","txhash":"AF59A2F204346A2BCFE8B81F5369F348EE5F8B1FF1CF4BC96719CBD002FB5268","data":"0000000000000002","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"submit_proposal\"},{\"key\":\"sender\",\"value\":\"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0\"},{\"key\":\"module\",\"value\":\"governance\"},{\"key\":\"sender\",\"value\":\"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0\"}]},{\"type\":\"proposal_deposit\",\"attributes\":[{\"key\":\"amount\",\"value\":\"10stake\"},{\"key\":\"proposal_id\",\"value\":\"2\"}]},{\"type\":\"submit_proposal\",\"attributes\":[{\"key\":\"proposal_id\",\"value\":\"2\"},{\"key\":\"proposal_type\",\"value\":\"Text\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash10d07y265gmmuvt4z0w9aw880jnsr700jhe7z0f\"},{\"key\":\"amount\",\"value\":\"10stake\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"submit_proposal"},{"key":"sender","value":"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0"},{"key":"module","value":"governance"},{"key":"sender","value":"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0"}]},{"type":"proposal_deposit","attributes":[{"key":"amount","value":"10stake"},{"key":"proposal_id","value":"2"}]},{"type":"submit_proposal","attributes":[{"key":"proposal_id","value":"2"},{"key":"proposal_type","value":"Text"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash10d07y265gmmuvt4z0w9aw880jnsr700jhe7z0f"},{"key":"amount","value":"10stake"}]}]}],"gas_wanted":"200000","gas_used":"73548"}
```
**Available Commands**

```text
  community-pool-spend Submit a community pool spend proposal
  param-change         Submit a parameter change proposal
  software-upgrade     Submit a software upgrade proposal
```

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --deposit         | N        | string | deposit of proposal                                                                                                                                       |
|       | --description     | N        | string | description of proposal                                                                                                                                   |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --title           | N        | string | title of proposal                                                                                                                                         |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
|       | --type            | N        | string | proposalType of proposal, types: text/parameter_change/software_upgrade                                                                                   |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `deposit`

Submit a deposit for an active proposal. You can find the proposal-id by running "akash query gov proposals".

**Usage**

```text
  akash tx gov deposit [proposal-id] [deposit] [flags]
```

**Example**

```shell
$ akash tx gov deposit 2 10stake --from bob -y
{"height":"10509","txhash":"B039C8E5542E9B58BFC4C3C5196684904D43AAEFBCCB9593A7002EEFC14FEE60","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"deposit\"},{\"key\":\"sender\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"},{\"key\":\"module\",\"value\":\"governance\"},{\"key\":\"sender\",\"value\":\"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf\"}]},{\"type\":\"proposal_deposit\",\"attributes\":[{\"key\":\"amount\",\"value\":\"10stake\"},{\"key\":\"proposal_id\",\"value\":\"2\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash10d07y265gmmuvt4z0w9aw880jnsr700jhe7z0f\"},{\"key\":\"amount\",\"value\":\"10stake\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"deposit"},{"key":"sender","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"},{"key":"module","value":"governance"},{"key":"sender","value":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"}]},{"type":"proposal_deposit","attributes":[{"key":"amount","value":"10stake"},{"key":"proposal_id","value":"2"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash10d07y265gmmuvt4z0w9aw880jnsr700jhe7z0f"},{"key":"amount","value":"10stake"}]}]}],"gas_wanted":"200000","gas_used":"60960"}
```
**Arguments**

| Argument    | Type   | Required | Description                        |
|:------------|:-------|:---------|:-----------------------------------|
| proposal-id | int    | Y        | Proposal id to deposit             |
| deposit     | string | Y        | Amount to be deposited in proposal |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `vote`

Submit a vote for an active proposal. You can find the proposal-id by running "akash query gov proposals".

**Usage**

```text
  akash tx gov vote [proposal-id] [option] [flags]
```

**Example**

```shell
$ akash tx gov vote 2 yes --from provider -y
{"height":"10554","txhash":"A2F98498FD8DCC184B270B513B1137AFA2D34474783EE7ABFFAE1465D2FB52CC","codespace":"gov","code":2,"raw_log":"inactive proposal: 2: failed to execute message; message index: 0","gas_wanted":"200000","gas_used":"35179"}
```
**Arguments**

| Argument    | Type   | Required | Description                                          |
|:------------|:-------|:---------|:-----------------------------------------------------|
| proposal-id | int    | Y        | Proposal id to deposit                               |
| option      | string | Y        | Option to vote. Options: yes/no/no_with_veto/abstain |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `multisign`

Sign transactions created with the --generate-only flag that require multisig signatures.
Read signature(s) from [signature] file(s), generate a multisig signature compliant to the
multisig key [name], and attach it to the transaction read from [file].

**Usage**

```text
  akash tx multisign [file] [name] [[signature]...] [flags]
```

**Example**

```text
$ akash tx multisign transaction.json k1k2k3 k1sig.json k2sig.json k3sig.json
```
If the flag --signature-only flag is on, it outputs a JSON representation
of the generated signature only.

The --offline flag makes sure that the client will not reach out to an external node.
Thus account number or sequence number lookups will not be performed and it is
recommended to set such parameters manually

**Arguments**

| Argument        | Type   | Required | Description                                 |
|:----------------|:-------|:---------|:--------------------------------------------|
| file            | string | Y        | Path of file generated with --generate flag |
| name            | string | Y        | Name of the key                             |
| signature files | string | N        | Path of signature files (can be multiple)   |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
|       | --offline         | N        |        | Offline mode. Do not query a full node                                                                                                                    |
|       | --output-document | N        | string | The document will be written to the given file instead of STDOUT                                                                                          |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --signature-only  | N        |        | Print only the generated signature, then exit                                                                                                             |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `send`

Create and sign a send tx.

**Usage**

```text
  akash tx send [from_key_or_address] [to_address] [amount] [flags]
```

**Example**

```shell
$ akash tx send bob akash12wlzqjelrt87r3u56ps4m8lk7wavx5m5jg9cax 10000000uakt -y -o json

{"height":"0","txhash":"116ED246AFF9F9B58036AECAA5EFE81AA7A788CC625CC2A4ADAFC68378834413","raw_log":"[]"}
```
**Arguments**

| Argument            | Type   | Required | Description                        |
|:--------------------|:-------|:---------|:-----------------------------------|
| from_key_or_address | string | Y        | From address or key name           |
| to_address          | string | Y        | To address                         |
| amount              | string | Y        | Amount need to send Eg: 10uakt |

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
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `sign`

It will read a transaction from [file], sign it, and print its JSON encoding.

If the flag --signature-only flag is set, it will output a JSON representation
of the generated signature only.

The --multisig=<multisig_key> flag generates a signature on behalf of a multisig account
key. It implies --signature-only. Full multisig signed transactions may eventually
be generated via the 'multisign' command.

**Usage**

```text
  akash tx sign [file] [flags]
```

**Example**

```shell
$ akash tx sign ./1.json --from master
{"type":"cosmos-sdk/StdTx","value":{"msg":[{"type":"cosmos-sdk/MsgSend","value":{"from_address":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","to_address":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","amount":[{"denom":"stake","amount":"10"}]}}],"fee":{"amount":[],"gas":"200000"},"signatures":[{"pub_key":{"type":"tendermint/PubKeySecp256k1","value":"A+hCkyWd4cWG0KD+GgCxHEOUzll1cl5VvoGgDvVIwF3E"},"signature":"Fc3Wk30fixtfA/68mtxasQPntGOOoQiXJwBw7ZGKmrs+n8wXlnk2/WuAlT7bgGXBfJNUGe2rxLmg6eEoRYj0QQ=="}],"memo":""}}
```

**Arguments**

| Argument | Type   | Required | Description                                 |
|:---------|:-------|:---------|:--------------------------------------------|
| file     | string | Y        | Path of file generated with --generate flag |

**Flags**
| Short | Verbose               | Required | Type   | Description                                                                                                                                               |
|:------|:----------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number      | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode      | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run             | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees                | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from                | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas                 | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment      | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices          | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only       | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help                | N        |        | help for create                                                                                                                                           |
|       | --indent              | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend     | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger              | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo                | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --multisig            | N        | string | Address of the multisig account on behalf of which the transaction shall be signed                                                                        |
|       | --node                | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
|       | --offline             | N        |        | Offline mode. Do not query a full node                                                                                                                    |
|       | --output-document     | N        | string | The document will be written to the given file instead of STDOUT                                                                                          |
| -s,   | --sequence            | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --signature-only      | N        |        | Print only the generated signature, then exit                                                                                                             |
|       | --trust-node          | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
|       | --validate-signatures | N        |        | Print the addresses that must sign the transaction, those who have already signed it, and make sure that signatures are in the correct order              |
| -y,   | --yes                 | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `slashing`

Transaction commands for the slashing module

**Usage**

```text
  akash tx slashing [flags]
  akash tx slashing [command]
```

**Available Commands**

```text
  unjail      unjail validator previously jailed for downtime
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `unjail`

Unjail a jailed validator.

**Usage**

```text
  akash tx slashing unjail [flags]
```

**Example**

```shell
$ akash tx slashing unjail --from master -y
{"height":"11147","txhash":"26E8F341704D62E28680BF2E92559D412873F08D6B7495D6B9D1E1325A3067C2","codespace":"slashing","code":1,"raw_log":"internal error","gas_wanted":"200000","gas_used":"34806"}
```
**Arguments**

None

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

## `staking`

Transaction commands for the staking module

**Usage**

```text
  akash tx staking [flags]
  akash tx staking [command]
```

**Available Commands**

```text
  create-validator create new validator initialized with a self-delegation to it
  delegate         Delegate liquid tokens to a validator
  edit-validator   edit an existing validator account
  redelegate       Redelegate illiquid tokens from one validator to another
  unbond           Unbond shares from a validator
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `create-validator`

Create new validator initialized with a self-delegation to it.

**Usage**

```text
  akash tx staking create-validator [flags]
```

**Example**

```shell
$ akash tx staking create-validator --amount 100stake --from master --pubkey akashvalconspub1zcjduepq285g7q754xtqa38cwxnkmmqzkfvy4e0zhu3mkelswp3d6j8rx8pq9ag7h3 --moniker anil --commission-max-change-rate "0.01" --commission-max-rate "0.2" --commission-rate "0.1" --min-self-delegation 1 -y

{"height":"11323","txhash":"9472D16A09A74E43DCAA20CF438B275FD7699FB6F9089180DDD2855EF1FC505C","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"create_validator\",\"attributes\":[{\"key\":\"validator\",\"value\":\"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9\"},{\"key\":\"amount\",\"value\":\"100\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create_validator\"},{\"key\":\"module\",\"value\":\"staking\"},{\"key\":\"sender\",\"value\":\"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"create_validator","attributes":[{"key":"validator","value":"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9"},{"key":"amount","value":"100"}]},{"type":"message","attributes":[{"key":"action","value":"create_validator"},{"key":"module","value":"staking"},{"key":"sender","value":"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0"}]}]}],"gas_wanted":"200000","gas_used":"123455"}
```
**Arguments**

None

**Flags**
| Short | Verbose                      | Required | Type   | Description                                                                                                                                               |
|:------|:-----------------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number             | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode             | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --commission-max-change-rate | Y        | string | The maximum commission change rate percentage (per day)                                                                                                   |
|       | --commission-max-rate        | Y        | string | The maximum commission rate percentage                                                                                                                    |
|       | --commission-rate            | Y        | string | The initial commission rate percentage                                                                                                                    |
|       | --details                    | N        | string | The validator's (optional) details                                                                                                                        |
|       | --dry-run                    | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees                       | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from                       | N        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas                        | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment             | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices                 | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only              | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help                       | N        |        | help for create                                                                                                                                           |
|       | --identity                   | N        | string | The optional identity signature (ex. UPort or Keybase)                                                                                                    |
|       | --indent                     | N        |        | Add indent to JSON response                                                                                                                               |
|       | --ip                         | N        | string | The node's public IP. It takes effect only when used in combination with --generate-only                                                                  |
|       | --keyring-backend            | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger                     | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo                       | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --min-self-delegation        | Y        | string | The minimum self delegation required on the validator                                                                                                     |
|       | --moniker                    | Y        | string | The validator's name                                                                                                                                      |
|       | --node                       | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
|       | --node-id                    | N        | string | The node's ID                                                                                                                                             |
|       | --pubkey                     | Y        | string | The Bech32 encoded PubKey of the validator                                                                                                                |
|       | --security-contact           | N        | string | The validator's (optional) security contact email                                                                                                         |
| -s,   | --sequence                   | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node                 | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
|       | --website                    | N        | string | The validator's (optional) website                                                                                                                        |
| -y,   | --yes                        | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `delegate`

Delegate an amount of liquid coins to a validator from your wallet.

**Usage**

```text
  akash tx staking delegate [validator-addr] [amount] [flags]
```

**Example**

```shell
$ akash tx staking delegate akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9 100stake --from alice -y
{"height":"11470","txhash":"753A1294606915A4C00956DDEFF3857A9BC8B1A5D3433E6CC35A0C112D0338D8","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"delegate\",\"attributes\":[{\"key\":\"validator\",\"value\":\"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9\"},{\"key\":\"amount\",\"value\":\"100\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"delegate\"},{\"key\":\"module\",\"value\":\"staking\"},{\"key\":\"sender\",\"value\":\"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"delegate","attributes":[{"key":"validator","value":"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9"},{"key":"amount","value":"100"}]},{"type":"message","attributes":[{"key":"action","value":"delegate"},{"key":"module","value":"staking"},{"key":"sender","value":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"}]}]}],"gas_wanted":"200000","gas_used":"89731"}
```
**Arguments**

| Argument       | Type   | Required | Description        |
|:---------------|:-------|:---------|:-------------------|
| validator-addr | string | Y        | Validator address  |
| amount         | string | Y        | Amount to delegate |

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

### `edit-validator`

Edit an existing validator account.

**Usage**

```text
  akash tx staking edit-validator [flags]
```

**Example**

```shell
$ akash tx staking edit-validator --min-self-delegation "2" --moniker "Test" --from master -y
{"height":"11521","txhash":"2423B2BA924FEA43F030CE94CAA58C5A2FB27E1B3837C9BA0C01E15037CEB4A1","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"edit_validator\",\"attributes\":[{\"key\":\"commission_rate\",\"value\":\"rate: 0.100000000000000000, maxRate: 0.200000000000000000, maxChangeRate: 0.010000000000000000, updateTime: 2020-04-23 10:22:37.17675536 +0000 UTC\"},{\"key\":\"min_self_delegation\",\"value\":\"2\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"edit_validator\"},{\"key\":\"module\",\"value\":\"staking\"},{\"key\":\"sender\",\"value\":\"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"edit_validator","attributes":[{"key":"commission_rate","value":"rate: 0.100000000000000000, maxRate: 0.200000000000000000, maxChangeRate: 0.010000000000000000, updateTime: 2020-04-23 10:22:37.17675536 +0000 UTC"},{"key":"min_self_delegation","value":"2"}]},{"type":"message","attributes":[{"key":"action","value":"edit_validator"},{"key":"module","value":"staking"},{"key":"sender","value":"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9"}]}]}],"gas_wanted":"200000","gas_used":"43470"}
```
**Arguments**

None

**Flags**
| Short | Verbose               | Required | Type   | Description                                                                                                                                               |
|:------|:----------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number      | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode      | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --commission-rate     | Y        | string | The initial commission rate percentage                                                                                                                    |
|       | --details             | N        | string | The validator's (optional) details                                                                                                                        |
|       | --dry-run             | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees                | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from                | N        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas                 | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment      | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices          | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only       | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help                | N        |        | help for create                                                                                                                                           |
|       | --identity            | N        | string | The optional identity signature (ex. UPort or Keybase)                                                                                                    |
|       | --indent              | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend     | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger              | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo                | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --min-self-delegation | Y        | string | The minimum self delegation required on the validator                                                                                                     |
|       | --moniker             | Y        | string | The validator's name                                                                                                                                      |
|       | --node                | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
|       | --security-contact    | N        | string | The validator's (optional) security contact email                                                                                                         |
| -s,   | --sequence            | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node          | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
|       | --website             | N        | string | The validator's (optional) website                                                                                                                        |
| -y,   | --yes                 | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |


### `redelegate`

Redelegate an amount of illiquid staking tokens from one validator to another.

**Usage**

```text
  akash tx staking redelegate [src-validator-addr] [dst-validator-addr] [amount] [flags]
```

**Example**

```shell
$ akash tx staking redelegate akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9 akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr 10stake --from master -y
{"height":"11567","txhash":"3F880AF1C7C03BC555AD30F63826BF628DB13C680CDFA2A84051B51B06730681","data":"0B088092B8C398FEFFFFFF01","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"begin_redelegate\"},{\"key\":\"sender\",\"value\":\"akash1tygms3xhhs3yv487phx3dw4a95jn7t7lvqceke\"},{\"key\":\"module\",\"value\":\"staking\"},{\"key\":\"sender\",\"value\":\"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0\"}]},{\"type\":\"redelegate\",\"attributes\":[{\"key\":\"source_validator\",\"value\":\"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9\"},{\"key\":\"destination_validator\",\"value\":\"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr\"},{\"key\":\"amount\",\"value\":\"10\"},{\"key\":\"completion_time\",\"value\":\"0001-01-01T00:00:00Z\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash1fl48vsnmsdzcv85q5d2q4z5ajdha8yu3cqygqd\"},{\"key\":\"amount\",\"value\":\"10stake\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"message","attributes":[{"key":"action","value":"begin_redelegate"},{"key":"sender","value":"akash1tygms3xhhs3yv487phx3dw4a95jn7t7lvqceke"},{"key":"module","value":"staking"},{"key":"sender","value":"akash1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3u3cse0"}]},{"type":"redelegate","attributes":[{"key":"source_validator","value":"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9"},{"key":"destination_validator","value":"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr"},{"key":"amount","value":"10"},{"key":"completion_time","value":"0001-01-01T00:00:00Z"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash1fl48vsnmsdzcv85q5d2q4z5ajdha8yu3cqygqd"},{"key":"amount","value":"10stake"}]}]}],"gas_wanted":"200000","gas_used":"154869"}
```
**Arguments**

| Argument           | Type   | Required | Description                   |
|:-------------------|:-------|:---------|:------------------------------|
| src-validator-addr | string | Y        | Source validator address      |
| dst-validator-addr | string | Y        | Destination validator address |
| amount             | string | Y        | Amount to delegate            |

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |

#### `unbond`

Unbond an amount of bonded shares from a validator.

**Usage**

```text
  akash tx staking unbond [validator-addr] [amount] [flags]
```

**Example**

```shell
$ akash tx staking delegate akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9 100stake --from provider -y
{"height":"11597","txhash":"5E1BDD99521E284787BDBF96AD25A17F2C467AC0B1D11286456616807252B985","raw_log":"[{\"msg_index\":0,\"log\":\"\",\"events\":[{\"type\":\"delegate\",\"attributes\":[{\"key\":\"validator\",\"value\":\"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9\"},{\"key\":\"amount\",\"value\":\"100\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"delegate\"},{\"key\":\"module\",\"value\":\"staking\"},{\"key\":\"sender\",\"value\":\"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"delegate","attributes":[{"key":"validator","value":"akashvaloper1kzpa4zlvxyqlz4kqe0rneap3l5c9r2x3knkkf9"},{"key":"amount","value":"100"}]},{"type":"message","attributes":[{"key":"action","value":"delegate"},{"key":"module","value":"staking"},{"key":"sender","value":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"}]}]}],"gas_wanted":"200000","gas_used":"106528"}
```
**Arguments**

| Argument       | Type   | Required | Description        |
|:---------------|:-------|:---------|:-------------------|
| validator-addr | string | Y        | Validator address  |
| amount         | string | Y        | Amount to delegate |

**Flags**
| Short | Verbose           | Required | Type   | Description                                                                                                                                               |
|:------|:------------------|:---------|:-------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -a,   | --account-number  | N        | uint   | The account number of the signing account (offline mode only)                                                                                             |
| -b,   | --broadcast-mode  | N        | string | Transaction broadcasting mode (sync/async/block) (default "sync")                                                                                         |
|       | --dry-run         | N        |        | ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it                                                                   |
|       | --fees            | N        | string | Fees to pay along with transaction; eg: 10uatom                                                                                                           |
|       | --from            | Y        | string | Name or address of private key with which to sign                                                                                                         |
|       | --gas             | N        | string | gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")                               |
|       | --gas-adjustment  | N        | float  | adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1) |
|       | --gas-prices      | N        | string | Gas prices to determine the transaction fee (e.g. 10uatom)                                                                                                |
|       | --generate-only   | N        |        | Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)                    |
| -h,   | --help            | N        |        | help for create                                                                                                                                           |
|       | --indent          | N        |        | Add indent to JSON response                                                                                                                               |
|       | --keyring-backend | N        | string | Select keyring's backend (os/file/test) (default "os")                                                                                                    |
|       | --ledger          | N        |        | Use a connected Ledger device                                                                                                                             |
|       | --memo            | N        | string | Memo to send along with transaction                                                                                                                       |
|       | --node            | N        | string | host:port to tendermint rpc interface for this chain (default "tcp://localhost:26657")                                                                    |
| -s,   | --sequence        | N        | uint   | The sequence number of the signing account (offline mode only)                                                                                            |
|       | --trust-node      | N        |        | Trust connected full node (don't verify proofs for responses) (default true)                                                                              |
| -y,   | --yes             | N        |        | Skip tx broadcasting prompt confirmation                                                                                                                  |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                       |
|:------|:-----------|:---------|:---------|:------------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                    |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash ") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                        |
|       | --trace    |          | N        | print out full stack trace on errors                              |
