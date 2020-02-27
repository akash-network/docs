# General Commands
### Start Akash Light Client
> **Usage**
```
$ akash rest-server [flags]
```
> **Example**
```
$ akash rest-server --node tcp://localhost:26657 --laddr tcp://127.0.0.1:1319
I[2020-02-27|16:25:57.343] Starting application REST service (chain-id: "")...  module=rest-server 
I[2020-02-27|16:25:57.343] Starting RPC HTTP server on 127.0.0.1:1319   module=rest-server
```

Use `akash rest-server` to start light client.

> **More info**
```
$ akash rest-server --help
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
      --home string       directory for config and data (default "/home/vitwit/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

### Send Tokens

Sign and send tokens to other account.
>**Usage**

`akash tx send <from-account> <to-account> <amount-with-denom>`
> **Example**
```
$ akash tx send bob akash12wlzqjelrt87r3u56ps4m8lk7wavx5m5jg9cax 10000000stake
{"chain_id":"akashchain","account_number":"3","sequence":"1","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"cosmos-sdk/MsgSend","value":{"from_address":"akash1qgjla78dk2yk2eh6dmjeejz6m374ykdtt20r66","to_address":"akash12wlzqjelrt87r3u56ps4m8lk7wavx5m5jg9cax","amount":[{"denom":"stake","amount":"10000000"}]}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
height: 0
txhash: 116ED246AFF9F9B58036AECAA5EFE81AA7A788CC625CC2A4ADAFC68378834413
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
>**More Info**
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
      --home string       directory for config and data (default "/home/vitwit/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```

### Bond(Stake) Tokens
Delegate some tokens to validator i.e., bonding tokens.
> **Usage**
```
$ akash tx staking delegate <validator-address> <amout-with-denom> --from <from-account>
```
> **Example**
```
$ akash tx staking delegate akashvaloper1qgjla78dk2yk2eh6dmjeejz6m374ykdtpgp92s 1000000stake --from alice
{"chain_id":"akashchain","account_number":"6","sequence":"0","fee":{"amount":[],"gas":"200000"},"msgs":[{"type":"cosmos-sdk/MsgDelegate","value":{"delegator_address":"akash12wlzqjelrt87r3u56ps4m8lk7wavx5m5jg9cax","validator_address":"akashvaloper1qgjla78dk2yk2eh6dmjeejz6m374ykdtpgp92s","amount":{"denom":"stake","amount":"1000000"}}}],"memo":""}

confirm transaction before signing and broadcasting [y/N]: y
height: 0
txhash: F48C925F2F37766660D044DCAD0DC9A4CF51E454E184BC817EFD32ADA501ADD7
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

> **More info**
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
      --home string       directory for config and data (default "/home/vitwit/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors
```


### Recover Key
Provide seed phrase to recover existing key instead of creating.
> **Usage**
```
$ akash keys add <key-name> --recover
```
> **Example**
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