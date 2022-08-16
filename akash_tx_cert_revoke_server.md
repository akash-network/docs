## akash tx cert revoke server

revoke server api certificate

```
akash tx cert revoke server [space separated dns names and/or IP addresses] [flags]
```

### Options

```
  -a, --account-number uint      The account number of the signing account (offline mode only)
  -b, --broadcast-mode string    Transaction broadcasting mode (sync|async|block) (default "sync")
      --dry-run                  ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
      --fees string              Fees to pay along with transaction; eg: 10uatom
      --from string              Name or address of private key with which to sign
      --gas string               gas limit to set per-transaction; set to "auto" to calculate sufficient gas automatically (default 200000)
      --gas-adjustment float     adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string        Gas prices in decimal format to determine the transaction fee (e.g. 0.1uatom)
      --generate-only            Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible)
  -h, --help                     help for server
      --keyring-backend string   Select keyring's backend (os|file|kwallet|pass|test) (default "os")
      --keyring-dir string       The client Keyring directory; if omitted, the default 'home' directory will be used
      --ledger                   Use a connected Ledger device
      --memo string              Memo to send along with transaction
      --naf string               certificate is not valid after this date. default 365d. days or RFC3339
      --nbf string               certificate is not valid before this date. default current timestamp. RFC3339
      --node string              <host>:<port> to tendermint rpc interface for this chain (default "tcp://localhost:26657")
      --offline                  Offline mode (does not allow any online functionality
      --rie                      revoke current certificate if it already present on chain
  -s, --sequence uint            The sequence number of the signing account (offline mode only)
      --sign-mode string         Choose sign mode (direct|amino-json), this is an advanced feature
      --timeout-height uint      Set a block timeout height to prevent the tx from being committed past a certain height
      --to-genesis               export certificate to genesis
  -y, --yes                      Skip tx broadcasting prompt confirmation
```

### Options inherited from parent commands

```
--chain-id string   The network chain ID
```

### SEE ALSO

* [akash tx cert revoke client](akash_tx_cert_revoke_client.md)	 - Remove client certificate
* [akash tx cert generate](akash_tx_cert_generate.md)	 - create/update api certificates

