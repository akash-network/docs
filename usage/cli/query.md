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
      --home string       directory for config and data (default "/home/ubuntu/.akash")
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

## `deployment`

Deployment query commands

**Usage**

```text
  akash query deployment [flags]
  akash query deployment [command]
```

**Available Commands**

```text
  get         Query deployment
  group       Deployment group query commands
  list        Query for all deployments
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :------------------------------- |
| -h    | --help   | string   | N        | help for gov.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

### `get`

Query details of a deployment

**Usage**

```text
  akash query deployment get [flags]
```

**Example**

```text
$ akash query deployment get --owner akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug --dseq 83

{"deployment":{"id":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83"},"state":1,"version":null},"groups":[{"id":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83","gseq":1},"state":4,"spec":{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"stake","amount":"30"}}]}}]}
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --dseq   | uint      | Y         | Deployment sequence number |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --owner   | string  | Y        | Deployment owner address |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

### `list`

Query to get list of deployments

**Usage**

```text
  akash query deployment list [flags]
```

**Example**

```text
$ akash query deployment list

[{"deployment":{"id":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83"},"state":1,"version":null},"groups":[{"id":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83","gseq":1},"state":4,"spec":{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"stake","amount":"30"}}]}}]}]
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --owner   | string  | N        | (optional) deployment owner address to filter |
|       | --state   | string  | N        | (optional) deployment state to filter (active,closed) |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

### `group`

Deployment group query commands

**Usage**

```text
  akash query deployment group [flags]
  akash query deployment group [command]
```

**Available Commands**

```text
  get         Query group of deployment
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :------------------------------- |
| -h    | --help   | string   | N        | help for gov.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

#### `get`

Query details of a deployment group

**Usage**

```text
  akash query deployment group get [flags]
```

**Example**

```text
$ akash query deployment group get --owner akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug --dseq 83 --gseq 1

{"id":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83","gseq":1},"state":4,"spec":{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"stake","amount":"30"}}]}}
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --dseq   | uint      | Y         | Deployment sequence number |
|       | --gseq   | uint32      | Y         | Group sequence number |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --owner   | string  | Y        | Deployment owner address |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

## `market`

Market query commands

**Usage**

```text
  akash query market [flags]
  akash query market [command]
```

**Available Commands**

```text
  bid         Bid query commands
  lease       Lease query commands
  order       Order query commands
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :------------------------------- |
| -h    | --help   | string   | N        | help for gov.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

### `order`

Market order query commands

**Usage**

```text
  akash query market order [flags]
  akash query market order [command]
```

**Available Commands**

```text
  get         Query order
  list        Query for all orders
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :------------------------------- |
| -h    | --help   | string   | N        | help for gov.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

#### `get`

Query details of a order in market.

**Usage**

```text
  akash query market order get [flags]
```

**Example**

```text
$ akash query market order get --owner akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug --dseq 83 --gseq 1 --oseq 1

{"id":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83","gseq":1,"oseq":1},"state":2,"start-at":"88","spec":{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"stake","amount":"30"}}]}}
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --dseq   | uint     | Y        | Deployment sequence number |
|       | --gseq   | uint32   | Y        | Group sequence number |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --oseq   | uint32   | Y        | Order sequence number |
|       | --owner   | string  | Y        | Deployment owner address |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

#### `list`

Query to get list of orders in market.

**Usage**

```text
  akash query market order list [flags]
```

**Example**

```text
$ akash query market order list --state open

[{"id":{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","dseq":"83","gseq":1,"oseq":1},"state":2,"start-at":"88","spec":{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"stake","amount":"30"}}]}},{"id":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":1},"state":2,"start-at":"19","spec":{"name":"global","requirements":null,"resources":[{"unit":{"cpu":10,"memory":"134217728","storage":"536870912"},"count":1,"price":{"denom":"stake","amount":"30"}}]}}]
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --owner   | string  | N        | (optional) order owner address to filter |
|       | --state   | string  | N        | (optional) order state to filter (open,matched,closed) |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

### `bid`

Market bid query commands

**Usage**

```text
  akash query market bid [flags]
  akash query market bid [command]
```

**Available Commands**

```text
  get         Query bid
  list        Query for all bids
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :------------------------------- |
| -h    | --help   | string   | N        | help for gov.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

#### `get`

Query details of a bid in market.

**Usage**

```text
  akash query market bid get [flags]
```

**Example**

```text
$ akash query market bid get --owner akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf --dseq 14 --gseq 1 --oseq 1 --provider akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug

{"id":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":1,"provider":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"},"state":3,"price":{"denom":"stake","amount":"20"}}
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --dseq   | uint     | Y        | Deployment sequence number |
|       | --gseq   | uint32   | Y        | Group sequence number |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --oseq   | uint32   | Y        | Order sequence number |
|       | --owner   | string  | Y        | Deployment owner address |
|       | --provider | string | N        | Bid provider address |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

#### `list`

Query to get list of bids in market.

**Usage**

```text
  akash query market bid list [flags]
```

**Example**

```text
$ akash query market bid list

[{"id":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":1,"provider":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"},"state":3,"price":{"denom":"stake","amount":"20"}},{"id":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":2,"provider":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"},"state":1,"price":{"denom":"stake","amount":"20"}}]
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --owner   | string  | N        | (optional) bid owner address to filter |
|       | --state   | string  | N        | (optional) bid state to filter (open,matched,lost,closed) |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

### `lease`

Market lease query commands

**Usage**

```text
  akash query market lease [flags]
  akash query market lease [command]
```

**Available Commands**

```text
  get         Query lease
  list        Query for all leases
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :------------------------------- |
| -h    | --help   | string   | N        | help for gov.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

#### `get`

Query details of a lease in market.

**Usage**

```text
  akash query market lease get [flags]
```

**Example**

```text
$ akash query market lease get --owner akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf --dseq 14 --gseq 1 --oseq 1 --provider akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug

{"id":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":1,"provider":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"},"state":2,"price":{"denom":"stake","amount":"20"}}
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --dseq   | uint     | Y        | Deployment sequence number |
|       | --gseq   | uint32   | Y        | Group sequence number |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --oseq   | uint32   | Y        | Order sequence number |
|       | --owner   | string  | Y        | Deployment owner address |
|       | --provider | string | N        | Bid provider address |
|       | --trust-node |      | N        |  Trust connected full node (don't verify proofs for responses) |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

#### `list`

Query to get list of leases in market.

**Usage**

```text
  akash query market lease list [flags]
```

**Example**

```text
$ akash query market lease list

[{"id":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":1,"provider":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"},"state":2,"price":{"denom":"stake","amount":"20"}},{"id":{"owner":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","dseq":"14","gseq":1,"oseq":2,"provider":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug"},"state":2,"price":{"denom":"stake","amount":"20"}}]
```
**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
|       | --indent  |         | N        | Add indent to JSON response |
|       | --ledger  |         | N        | Use a connected Ledger device |
|       | --node    | string  | N        | <host>:<port> to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --owner   | string  | N        | (optional) lease owner address to filter |
|       | --state   | string  | N        | (optional) lease state to filter (active,insufficient,closed) |
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
  get         Query provider
  list        Query for all providers
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


### `get`

Query details of provider.

**Usage**

```text
 akash query provider get [address] [flags]
```

**Example**

```text
$ akash query provider get akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug

{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","host-uri":"http://akash.akhilkumar.online","attributes":[{"key":"cmVnaW9u","value":"c2Zv"},{"key":"bW9uaWtlcg==","value":"YWtoaWw="}]}
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| address | string | Y        | Provider address |

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


### `list`

Query for all providers

**Usage**

```text
 akash query provider list [flags]
```

**Example**

```text
$ akash query provider list

[{"owner":"akash1zsgzee6vvx942c4c69vl859w9azn77j8uhduug","host-uri":"http://akash.akhilkumar.online","attributes":[{"key":"cmVnaW9u","value":"c2Zv"},{"key":"bW9uaWtlcg==","value":"YWtoaWw="}]}]
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
