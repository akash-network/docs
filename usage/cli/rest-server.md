# Run Light Client (Rest Server)

**Usage**

Use `akash rest-server` to start light client.

```
$ akash rest-server [flags]
```

**Example**

```
$ akash rest-server --node tcp://127.0.0.1:26657 --laddr tcp://127.0.0.1:1319
I[2020-02-27|16:25:57.343] Starting application REST service (chain-id: "")...  module=rest-server 
I[2020-02-27|16:25:57.343] Starting RPC HTTP server on 127.0.0.1:1319   module=rest-server
```

> In the example above, the rest client will listen on `127.0.0.1:1319` and connects to the node running at `127.0.0.1:26657`

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| | --height | int  | N | Use a specific height to query state at (this can error if the node is pruning state) |
| | --indent | bool | N |  Add indent to JSON response |
| | --laddr | string | N | The address for the server to listen on (default "tcp://localhost:1317") |
| | --ledger | bool N | N |Use a connected Ledger device |
| | --max-open | uint | N | The number of maximum open connections (default 1000) |
| | --node | string | N | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
| | --read-timeout | uint | N |  The RPC read timeout (in seconds) (default 10) |
| | --trust-node | bool | N | Trust connected full node (don't verify proofs for responses) |
| | --write-timeout| uint | N | The RPC write timeout (in seconds) (default 10) |
