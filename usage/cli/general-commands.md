# General Commands

## Start Akash Light Client

**Usage**

```shell
akash rest-server [flags]
```

**Example**

```
$ akash rest-server --node tcp://localhost:26657 --laddr tcp://127.0.0.1:1319
I[2020-02-27|16:25:57.343] Starting application REST service (chain-id: "")...  module=rest-server 
I[2020-02-27|16:25:57.343] Starting RPC HTTP server on 127.0.0.1:1319   module=rest-server
```

Use `akash rest-server` to start light client.

**More info**

```text
akash rest-server --help

Start LCD (light-client daemon), a local REST server

Usage:
  akash rest-server [flags]

Flags:
      --height int           Use a specific height to query state at (this can error if the node is pruning state)
  -h, --help                 help for rest-server
      --indent               Add indent to JSON response
      --laddr string         The address for the server to listen on (default "tcp://localhost:1317")
      --ledger               Use a connected Ledger device
      --max-open uint        The number of maximum open connections (default 1000)
      --node string          <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657")
      --read-timeout uint    The RPC read timeout (in seconds) (default 10)
      --trust-node           Trust connected full node (don't verify proofs for responses)
      --write-timeout uint   The RPC write timeout (in seconds) (default 10)

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Send Tokens

Sign and send tokens to other account.

**Usage**

```
akash tx send [from_key_or_address] [to_address] [amount] [flags]
```

 **Example**

```
$ akash tx send bob akash12wlzqjelrt87r3u56ps4m8lk7wavx5m5jg9cax 10000000uakt -y -o json

{"height":"0","txhash":"116ED246AFF9F9B58036AECAA5EFE81AA7A788CC625CC2A4ADAFC68378834413","raw_log":"[]"}
```

**More Info**

```
$ akash tx send -h
Create and sign a send tx

Usage:
  akash tx send [from_key_or_address] [to_address] [amount] [flags]

Flags:
  -a, --account-number uint      The account number of the signing account (offline mode only)
  -b, --broadcast-mode string    Transaction broadcasting mode (sync|async|block) (default "sync")
      --dry-run                  ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
      --fees string              Fees to pay along with transaction; eg: 10uatom
      --from string              Name or address of private key with which to sign
      --gas string               gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
      --gas-adjustment float     adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string        Gas prices to determine the transaction fee (e.g. 10uatom)
      --generate-only            Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
  -h, --help                     help for send
      --indent                   Add indent to JSON response
      --keyring-backend string   Select keyring's backend (os|file|test) (default "os")
      --ledger                   Use a connected Ledger device
      --memo string              Memo to send along with transaction
      --node string              <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
  -s, --sequence uint            The sequence number of the signing account (offline mode only)
      --trust-node               Trust connected full node (don't verify proofs for responses) (default true)
  -y, --yes                      Skip tx broadcasting prompt confirmation

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Query Transaction

Query for a transaction by hash in a committed block.

**Usage**
```
$ akash query tx <txhash> -o json
```

**Examples**

```
$ akash query tx 295A56A7B4DA7DE3266329981945307FF73ACFF1CCD319D1E1AE53DF16E0125E -o json

{"height":"338","txhash":"295A56A7B4DA7DE3266329981945307FF73ACFF1CCD319D1E1AE53DF16E0125E","codespace":"staking","code":3,"raw_log":"validator does not exist: failed to execute message; message index: 0","gas_wanted":"200000","gas_used":"35496","tx":{"type":"cosmos-sdk/StdTx","value":{"msg":[{"type":"cosmos-sdk/MsgBeginRedelegate","value":{"delegator_address":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","validator_src_address":"akashvaloper1qgjla78dk2yk2eh6dmjeejz6m374ykdtpgp92s","validator_dst_address":"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr","amount":{"denom":"uakt","amount":"10000"}}}],"fee":{"amount":[],"gas":"200000"},"signatures":[{"pub_key":{"type":"tendermint/PubKeySecp256k1","value":"A+hCkyWd4cWG0KD+GgCxHEOUzll1cl5VvoGgDvVIwF3E"},"signature":"XI1XhIXlSCPnQVHQamu+sbqiZxAxLM8OnXSF2gqNVkkpP1bi6Au3v8N4EUAaPrZGYigechb2ekt6MUEjrFWdgw=="}],"memo":""}},"timestamp":"2020-03-06T10:39:57Z"}
```

**More info**

```
$ akash query tx -h

Usage:
  akash query tx [hash] [flags]

Flags:
  -h, --help          help for tx
  -n, --node string   Node to connect to (default "tcp://localhost:26657")
      --trust-node    Trust connected full node (don't verify proofs for responses)

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Bond(Stake) Tokens

Delegate some tokens to validator i.e., bonding tokens.

**Usage**

```
$ akash tx staking delegate <validator-address> <amount-with-denom> --from <from-account> -y -o json
```

**Example**

```
$ akash tx staking delegate akashvaloper1qgjla78dk2yk2eh6dmjeejz6m374ykdtpgp92s 1000000uakt --from alice -y -o json

{"height":"0","txhash":"F48C925F2F37766660D044DCAD0DC9A4CF51E454E184BC817EFD32ADA501ADD7","raw_log":"[]"}
```

**More info**

```
$ akash tx staking delegate -h
Delegate an amount of liquid coins to a validator from your wallet.

Usage:
  akash tx staking delegate [validator-addr] [amount] [flags]

Flags:
  -a, --account-number uint      The account number of the signing account (offline mode only)
  -b, --broadcast-mode string    Transaction broadcasting mode (sync|async|block) (default "sync")
      --dry-run                  ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
      --fees string              Fees to pay along with transaction; eg: 10uatom
      --from string              Name or address of private key with which to sign
      --gas string               gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
      --gas-adjustment float     adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string        Gas prices to determine the transaction fee (e.g. 10uatom)
      --generate-only            Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
  -h, --help                     help for delegate
      --indent                   Add indent to JSON response
      --keyring-backend string   Select keyring's backend (os|file|test) (default "os")
      --ledger                   Use a connected Ledger device
      --memo string              Memo to send along with transaction
      --node string              <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
  -s, --sequence uint            The sequence number of the signing account (offline mode only)
      --trust-node               Trust connected full node (don't verify proofs for responses) (default true)
  -y, --yes                      Skip tx broadcasting prompt confirmation

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Redelegate Tokens

Redelegate some tokens from one validator to another.

**Usage**

```
$ akash tx staking redelegate <src-validator-address> <dest-validator-address> <amount-with-denom> --from <from-account> -y -o json
```

**Example**

```
$ akash tx staking redelegate akashvaloper1qgjla78dk2yk2eh6dmjeejz6m374ykdtpgp92s akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr 1000000uakt --from alice -y -o json

{"height":"0","txhash":"295A56A7B4DA7DE3266329981945307FF73ACFF1CCD319D1E1AE53DF16E0125E","raw_log":"[]"}
```

**More info**

```
$ akash tx staking redelegate -h
Redelegate an amount of illiquid staking tokens from one validator to another.

Example:
$ akash tx staking redelegate cosmosvaloper1gghjut3ccd8ay0zduzj64hwre2fxs9ldmqhffj cosmosvaloper1l2rsakp388kuv9k8qzq6lrm9taddae7fpx59wm 100uakt --from mykey

Usage:
  akash tx staking redelegate [src-validator-addr] [dst-validator-addr] [amount] [flags]

Flags:
  -a, --account-number uint      The account number of the signing account (offline mode only)
  -b, --broadcast-mode string    Transaction broadcasting mode (sync|async|block) (default "sync")
      --dry-run                  ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
      --fees string              Fees to pay along with transaction; eg: 10uatom
      --from string              Name or address of private key with which to sign
      --gas string               gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
      --gas-adjustment float     adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string        Gas prices to determine the transaction fee (e.g. 10uatom)
      --generate-only            Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
  -h, --help                     help for redelegate
      --indent                   Add indent to JSON response
      --keyring-backend string   Select keyring's backend (os|file|test) (default "os")
      --ledger                   Use a connected Ledger device
      --memo string              Memo to send along with transaction
      --node string              <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
  -s, --sequence uint            The sequence number of the signing account (offline mode only)
      --trust-node               Trust connected full node (don't verify proofs for responses) (default true)
  -y, --yes                      Skip tx broadcasting prompt confirmation

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Undelegate(unbond) Tokens

Undelegate some tokens from validator i.e., unbonding tokens.

**Usage**
```
$ akash tx staking unbond <validator-address> <amount-with-denom> --from <from-account> -y -o json
```

**Example**
```
$ akash tx staking unbond akashvaloper1qgjla78dk2yk2eh6dmjeejz6m374ykdtpgp92s 1000000uakt --from alice -y -o json

{"height":"0","txhash":"F48C925F2F37766660D044DCAD0DC9A4CF51E454E184BC817EFD32ADA501ADD7","raw_log":"[]"}
```

**More info**
```
$ akash tx staking unbond -h
Unbond an amount of bonded shares from a validator.

Example:
$ akash tx staking unbond cosmosvaloper1gghjut3ccd8ay0zduzj64hwre2fxs9ldmqhffj 100uakt --from mykey

Usage:
  akash tx staking unbond [validator-addr] [amount] [flags]

Flags:
  -a, --account-number uint      The account number of the signing account (offline mode only)
  -b, --broadcast-mode string    Transaction broadcasting mode (sync|async|block) (default "sync")
      --dry-run                  ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
      --fees string              Fees to pay along with transaction; eg: 10uatom
      --from string              Name or address of private key with which to sign
      --gas string               gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
      --gas-adjustment float     adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string        Gas prices to determine the transaction fee (e.g. 10uatom)
      --generate-only            Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
  -h, --help                     help for unbond
      --indent                   Add indent to JSON response
      --keyring-backend string   Select keyring's backend (os|file|test) (default "os")
      --ledger                   Use a connected Ledger device
      --memo string              Memo to send along with transaction
      --node string              <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
  -s, --sequence uint            The sequence number of the signing account (offline mode only)
      --trust-node               Trust connected full node (don't verify proofs for responses) (default true)
  -y, --yes                      Skip tx broadcasting prompt confirmation

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Withdraw Rewards

Withdraw rewards from validator

**Usage**
```
$ akash tx distribution withdraw-rewards <validator-address> <amount-with-denom> --from <from-account> -y -o json
```

**Example**
```
$ akash tx distribution withdraw-rewards akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr --from alice -y -o json

{"height":"0","txhash":"1BBB4A7A4D245C7534F366BABCE5BDD73776FB0430B3A241BFEEEF99445C52C3","raw_log":"[]"}
```

**More info**
```
$ akash tx distribution withdraw-rewards -h
Withdraw rewards from a given delegation address,
and optionally withdraw validator commission if the delegation address given is a validator operator.

Example:
$ akash tx distribution withdraw-rewards cosmosvaloper1gghjut3ccd8ay0zduzj64hwre2fxs9ldmqhffj --from mykey

### Withdraw commission
$ akash tx distribution withdraw-rewards cosmosvaloper1gghjut3ccd8ay0zduzj64hwre2fxs9ldmqhffj --from mykey --commission

Usage:
  akash tx distribution withdraw-rewards [validator-addr] [flags]

Flags:
  -a, --account-number uint      The account number of the signing account (offline mode only)
  -b, --broadcast-mode string    Transaction broadcasting mode (sync|async|block) (default "sync")
      --commission               also withdraw validator's commission
      --dry-run                  ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
      --fees string              Fees to pay along with transaction; eg: 10uatom
      --from string              Name or address of private key with which to sign
      --gas string               gas limit to set per-transaction; set to "auto" to calculate required gas automatically (default 200000) (default "200000")
      --gas-adjustment float     adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string        Gas prices to determine the transaction fee (e.g. 10uatom)
      --generate-only            Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible and the node operates offline)
  -h, --help                     help for withdraw-rewards
      --indent                   Add indent to JSON response
      --keyring-backend string   Select keyring's backend (os|file|test) (default "os")
      --ledger                   Use a connected Ledger device
      --memo string              Memo to send along with transaction
      --node string              <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
  -s, --sequence uint            The sequence number of the signing account (offline mode only)
      --trust-node               Trust connected full node (don't verify proofs for responses) (default true)
  -y, --yes                      Skip tx broadcasting prompt confirmation

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Query Rewards
Query all rewards earned by a delegator, optionally restrict to rewards from a single validator.

**Usage**
```
$ akash query distribution rewards <delegator-address> [<validator-address>] -o json
```

**Examples**
```
$ akash query distribution rewards akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr -o json

[{"denom":"uakt","amount":"69009.444000000000000000"}]

$ akash query distribution rewards akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf -o json

{"rewards":[{"validator_address":"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr","reward":[{"denom":"uakt","amount":"1089622.800000000000000000"}]}],"total":[{"denom":"uakt","amount":"1089622.800000000000000000"}]}
```

**More info**
```
$ akash query distribution rewards -h

Usage:
  akash query distribution rewards [delegator-addr] [<validator-addr>] [flags]

Flags:
      --height int    Use a specific height to query state at (this can error if the node is pruning state)
  -h, --help          help for rewards
      --indent        Add indent to JSON response
      --ledger        Use a connected Ledger device
      --node string   <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657")
      --trust-node    Trust connected full node (don't verify proofs for responses)

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Query Balance
Query account balance of given account address.

**Usage**
```
$ akash query account <account-address> -o json
```

**Examples**
```
$ akash query account akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf -o json

{"type":"cosmos-sdk/Account","value":{"address":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","coins":[{"denom":"uakt","amount":"99870156179"}],"public_key":"akashpub1addwnpepq05y9ye9nhsutpks5rlp5q93r3pefnjew4e9u4d7sxsqaa2gcpwug9szhl2","account_number":3,"sequence":5}}
```

**More info**
```
$ akash query account -h

Usage:
  akash query account [address] [flags]

Flags:
      --height int    Use a specific height to query state at (this can error if the node is pruning state)
  -h, --help          help for account
      --indent        Add indent to JSON response
      --ledger        Use a connected Ledger device
      --node string   <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657")
      --trust-node    Trust connected full node (don't verify proofs for responses)

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

## Recover Key

Provide seed phrase to recover existing key instead of creating.

**Usage**
```
$ akash keys add <key-name> --recover
```

**Example**
```
$ akash keys add alice --recover
> Enter your bip39 mnemonic
close super rare vicious core supreme collect fatigue maid cupboard throw surge notable phrase brand actual high track stay visual afraid lot dizzy wedding

- name: alice
  type: local
  address: akash12wlzqjelrt87r3u56ps4m8lk7wavx5m5jg9cax
  pubkey: akashpub1addwnpepqd80atzkr5c5teq933q80jkh27ljgwsm3r00fxjcl5nvaxkm9z0hqhw5h7e
  mnemonic: ""
  threshold: 0
  pubkeys: []
```

## Export Key

Export a private key from the local keybase in ASCII-armored encrypted format. Export key with entering new password.

**Usage**
```
akash keys export <key-name>
```

**Example**
```
$ akash keys export provider
Enter passphrase to decrypt your key:
Enter passphrase to encrypt the exported key:
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: FC01B9FACA831E315C867E07A586AEF7
type: secp256k1

VmSk+mQl2tpra7dHt2Dm2z4S2unH2kbjXaOZTK/9NGQsw3TSb6GkwBU7WizTCmN/
3dxPu/wdDa1uBLYg+zgYhTtK6HlPDrulxlDDQjg=
=KGDA
-----END TENDERMINT PRIVATE KEY-----
```

## Import Key

Import a file with ASCII armored private key into the local keybase. Required key password to import key.

**Usage**
```
$ akash keys import <key-name> <keyfile>
```

**Example**
```
$ akash keys import provider key
Enter passphrase to decrypt your key:
```
