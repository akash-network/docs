# Query Network

**Usage**

```text
$ akash query [command]
```

**Example**

```text
$ akash query help

Querying subcommands

Usage:
  akash query [command]

Aliases:
  query, q

Available Commands:
  account                  Query account balance
  auth                     Querying commands for the auth module
  block                    Get verified data for a the block at given height
  deployment               Deployment query commands
  distribution             Querying commands for the distribution module
  market                   Market query commands
  mint                     Querying commands for the minting module
  provider                 Provider query commands
  slashing                 Querying commands for the slashing module
  staking                  Querying commands for the staking module
  supply                   Querying commands for the supply module
  tendermint-validator-set Get the full tendermint validator set at given height
  tx                       Query for a transaction by hash in a committed block
  txs                      Query for paginated transactions that match a set of events

Flags:
  -h, --help          help for query

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/vitwit/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

Use "akash query [command] --help" for more information about a command.

```

Use `akash query` to query all the things that need querying.

**Available Commands**

| Command                 | Description                                                    |
| :--------------------   | :------------------------------------------------------        |
| account                 | Query account balance.                                         |
| auth                    | Querying commands for the auth module.                         |
| block                   | Get verified data for a the block at given height.             |
| deployment              | Deployment query commands.                                     |
| distribution            | Querying commands for the distribution module                  |
| market                  | Market query commands.                                         |
| mint                    | Querying commands for the minting module.                      |
| provider                | Provider query commands.                                       |
| slashing                | Querying commands for the slashing module.                     |
| staking                 | Querying commands for the staking module.                      |
| supply                  | Querying commands for the supply module.                       |
| tendermint-validator-set | Get the full tendermint validator set at given height.        |
| tx                       | Query for a transaction by hash in a committed block.         |
| txs                      | Query for paginated transactions that match a set of events   |

# `account`

**Usage**

Query account balance

```text
akash query account [address] [flags]
```

**Example**

```text
$ akash query account akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
|
  address: akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
  coins:
  - denom: akt
    amount: "1000000000"
  - denom: stake
    amount: "900000000"
  public_key: akashpub1addwnpepq02ew0t8fs7qlfu6awxk6xemwvhyg0jt0jw9l9k5my52xr7n0286kqqnhgc
  account_number: 3
  sequence: 1
```

**Arguments**

| Argument | Type   | Required | Description                                                |
| :------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------- |
| account  | string | Y        | Account addresses to query. Omitting this argument returns error. |

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height   | int   | N        | Use a specific height to query state at (this can error if the node is pruning state).                                           |
| -h    | --help     |        | N       | help for account |
|       | --indent   |        | N       | Add indent to JSON response |
|       | --ledger   |        | N       | Use a connected Ledger device |
|       | --node     | string | N       | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node  |     | N       | Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |



# `auth`

Querying commands for the auth module

**Usage**

Query account balance

```text
  akash query auth [flags]
  akash query auth [command]
```

**Example**

```text
$ akash query auth account akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
|
  address: akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
  coins:
  - denom: akt
    amount: "1000000000"
  - denom: stake
    amount: "900000000"
  public_key: akashpub1addwnpepq02ew0t8fs7qlfu6awxk6xemwvhyg0jt0jw9l9k5my52xr7n0286kqqnhgc
  account_number: 3
  sequence: 1

```

**Arguments**

| Argument | Type   | Required | Description                                                |
| :------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------- |
| account  | string | Y        | Account addresses to query. Omitting this argument returns error. |

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height   | int   | N        | Use a specific height to query state at (this can error if the node is pruning state).                                           |
| -h    | --help     |        | N       | help for auth |
|       | --indent   |        | N       | Add indent to JSON response |
|       | --ledger   |        | N       | Use a connected Ledger device |
|       | --node     | string | N       | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node  |     | N       | Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |



## `deployment`

Deployment query commands

**Usage**

```text
  akash query deployment [flags]
  akash query deployment [command]
```

**Example**

```text
$ akash query deployment deployments -o json

[{"deployment":{"id":{"owner":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","dseq":"875"},"state":0,"version":null},"groups":[{"id":{"owner":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","dseq":"875","gseq":1},"state":1,"spec":{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"akash","amount":"30"}}]}}]}]

```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| deployments | string | N        | all deployments to query.|
| deployment  | string | N        | specific deployment to query.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -h    | --help   | string   | N        | help for deployment.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

## `market`

Market query commands.

**Usage**

```text
  akash query market [flags]
  akash query market [command]
```

**Available Commands**

```text
  bids        
  leases      
  orders
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |

| -h    | --help   | string   | N        | help for market.                             |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |


## `bids`

**Usage**

```text
  akash query market bids [flags]
```

**Example**

```text
$ akash query market bids

[]
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| bids | string | Y        | array of bids.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for bids.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

## `leases`

**Usage**

```text
  akash query market leases [flags]
```

**Example**

```text
$ akash query market leases

[]
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| leases | string | Y        | array of leases.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for leases.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

## `orders`

**Usage**

```text
  akash query market orders [flags]
```

**Example**

```text
$ akash query market orders

- orderid:
    owner: akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
    dseq: 875
    gseq: 1
    oseq: 1
  state: 0
  startat: 880
  spec:
    name: global
    requirements: []
    resources:
    - unit:
        cpu: 10
        memory: 134217728
        storage: 536870912
      count: 1
      price:
        denom: akash
        amount: "30"
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| orders | string | Y        | array of orders.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for orders.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |


## `provider`

Provider query commands

**Usage**

```text
  akash query provider [flags]
  akash query provider [command]
```

**Available Commands**

```text
  provider    
  providers
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |

| -h    | --help   | string   | N        | help for provider.                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |


## `provider`

**Usage**

```text
 akash query provider provider <address> [flags]
```

**Example**

```text
TODO
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| provider | string | Y        | Provider address. |

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for provider.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |


## `providers`

**Usage**

```text
 akash query provider providers [flags]
```

**Example**

```text
  $ akash query provider providers -o json

  [{
    "owner":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84",
    "host-uri":"http://akash.sahithnarahari.com",
    "attributes":[{
      "key":"cmVnaW9u","value":"c2Zv"
      },{
        "key":"bW9uaWtlcg==","value":"YWtoaWw="
        }]
    }]
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for providers.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |



## `tx`

Query for a transaction by hash in a committed block

**Usage**

```text
  akash query tx [hash] [flags]
```

**Example**

```text
    TODO
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -h    | --help   | string   | N        | help for tx.                                           |
|  -n   | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |


## `txs`

Search for transactions that match the exact given events where results are paginated.
Each event takes the form of '{eventType}.{eventAttribute}={value}'. Please refer
to each module's documentation for the full set of events to query for. Each module
documents its respective events under 'xx_events.md'.

**Usage**

```text
  akash query txs [flags]
```

**Example**

```text
    TODO
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       |  --events | string  | list of transaction events in the form of {eventType}.{eventAttribute}={value} |
| -h    | --help   | string   | N        | help for tx.                                 |
|       | --limit  | uint32   | N        | Query number of transactions results per page returned (default 30) |
|  -n   | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --page    | uint32  | N         | Query a specific page of paginated results (default 1) |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |
