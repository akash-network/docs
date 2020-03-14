# Manage rest-server

Start LCD (light-client daemon), a local REST server

**Usage**

```shell
$  akash rest-server [flags]
```

**Example**

```shell

$ akash rest-server

I[2020-03-12|15:18:05.969] Starting application REST service (chain-id: "my-chain")... module=rest-server 
I[2020-03-12|15:18:05.969] Starting RPC HTTP server on 127.0.0.1:1317   module=rest-server

```

```text
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