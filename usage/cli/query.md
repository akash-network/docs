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

```

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

```

# `block`

Get verified data for a the block at given height

**Usage**

```text

akash query block [height] [flags]

```

**Example**

```text
$ akash query block 100 -o json

{"block_id":{"hash":"808F36F63C25D9699E133DED2E687A5BA730FDDD91B18DD7D535FF3AB27F378C","parts":{"total":"1","hash":"F8EF622C895DCF37AC5B92FEF958B1C84BE1B0BD875953465043D4DD52434182"}},"block":{"header":{"version":{"block":"10","app":"0"},"chain_id":"mychain","height":"100","time":"2020-03-10T10:45:25.393189106Z","last_block_id":{"hash":"DE1E1D77285934318BD43B766A85E7B1F93E770FFA9D6A3417DDBA306BBAE427","parts":{"total":"1","hash":"4F25970582F60D8D55AD470172B601C95E86345A13D71D3E16F1CD0EE2979924"}},"last_commit_hash":"4948EECA76794BCEF8618AA2D0F51E175357CB094857C69243C9E409A1BB5A40","data_hash":"","validators_hash":"AA3DB9F361351ED65B9C73A72703CA3E469B9F3CABAD7707639C93496C2E14D7","next_validators_hash":"AA3DB9F361351ED65B9C73A72703CA3E469B9F3CABAD7707639C93496C2E14D7","consensus_hash":"048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F","app_hash":"070839326D9A0F5643248C9EAC01B0B0124106DC6E6003F0E6C8A7906631D607","last_results_hash":"","evidence_hash":"","proposer_address":"15A9E2C091AED0734D0BCB47781E54CF81F0F4F8"},"data":{"txs":null},"evidence":{"evidence":null},"last_commit":{"height":"99","round":"0","block_id":{"hash":"DE1E1D77285934318BD43B766A85E7B1F93E770FFA9D6A3417DDBA306BBAE427","parts":{"total":"1","hash":"4F25970582F60D8D55AD470172B601C95E86345A13D71D3E16F1CD0EE2979924"}},"signatures":[{"block_id_flag":2,"validator_address":"15A9E2C091AED0734D0BCB47781E54CF81F0F4F8","timestamp":"2020-03-10T10:45:25.393189106Z","signature":"tx2v3hKYxkWHDXXVXZt4x9EqKr7VAJ48ETyXAmUPmqmILQrouEERtSdKsAe808Nkx1FD/X4/a5t/8/m41vaiDg=="}]}}}

```
**Arguments**

| Argument | Type   | Required | Description                                                |
| :------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------- |
| block  | int | Y       | To get block data at given height. |

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -h    | --help     |        | N       | help for block |
| -n    | --node     | string | N       | Node to connect to (default "tcp://localhost:26657") |
|       | --trust-node |      | N       | Trust connected full node (don't verify proofs for responses) |


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


## `distribution`

Querying commands for the distribution module

**Usage**

```text
  akash query distribution [flags]
  akash query distribution [command]
```

```
Available Commands:
  commission                    Query distribution validator commission
  community-pool                Query the amount of coins in the community pool
  params                        Query distribution params
  rewards                       Query all distribution delegator rewards or rewards from a particular validator
  slashes                       Query distribution validator slashes
  validator-outstanding-rewards Query distribution outstanding (un-withdrawn) rewards for a validator and all their delegations
```

## `commission`

Query validator commission rewards from delegators to that validator.

**Usage**

```text
  akash query distribution commission [validator] [flags]
```

**Example**

```text
TODO

```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| commision | string | Y        | validator commission rewards from delegators to that validator.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for commision.                                           |
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


## `community-pool`

Query all coins in the community pool which is under Governance control.  

**Usage**

```text
  akash query distribution community-pool [flags]
```

**Example**

```text
$ akash query distribution community-pool

- denom: stake
  amount: "695.200000000000000000"

```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| community-pool | string | Y        | Query all coins in the community pool which is under Governance control.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for community-pool.                                           |
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

## `params`

Query distribution params.

**Usage**

```text
  akash query distribution params [flags]
```

**Example**

```text
$ akash query distribution params

community_tax: "0.020000000000000000"
base_proposer_reward: "0.010000000000000000"
bonus_proposer_reward: "0.040000000000000000"
withdraw_addr_enabled: true

```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| params | string | Y        | Query distribution params.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for params.                                           |
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


## `rewards`

Query all rewards earned by a delegator, optionally restrict to rewards from a single validator.

**Usage**

```text
  akash query distribution rewards [delegator-addr] [<validator-addr>] [flags]
```

**Example**

```text
$ akash query distribution rewards akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84

rewards:
- validator_address: akashvaloper1zwksclwdjkjaa9whc8rdxtxlkca9zwgcu57thl
  reward:
  - denom: stake
    amount: "47328.120000000000000000"
total:
- denom: stake
  amount: "47328.120000000000000000"

```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| rewards | string | Y        | Query all rewards earned by a delegator.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for rewards.                                           |
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

## `slashes`

Query all slashes of a validator for a given block range.

**Usage**

```text
  akash query distribution slashes [validator] [start-height] [end-height] [flags]
```

**Example**

```text
TODO
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| slashes | string | Y        | Query all slashes of a validator for a given block range.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for slashes.                                           |
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


## `validator-outstanding-rewards`

Query distribution outstanding (un-withdrawn) rewards
for a validator and all their delegations.

**Usage**

```text
  akash query distribution validator-outstanding-rewards [validator] [flags]
```

**Example**

```text
TODO
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| validator-outstanding-rewards | string | Y        | Query distribution outstanding (un-withdrawn) rewards for a validator and all their delegations.|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for validator-outstading-rewards.                                           |
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


## `mint`

Querying commands for the minting module.

**Usage**

```text
  akash query mint [flags]
  akash query mint [command]
```

**Available Commands**

```text
  annual-provisions Query the current minting annual provisions value
  inflation         Query the current minting inflation value
  params            Query the current minting parameters
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -h    | --help   | string   | N        | help for mint.                                           |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |



## `annual-provisions`

Query the current minting annual provisions value

**Usage**

```text
  akash query mint annual-provisions [flags]
```

**Example**

```text
$ akash query mint annual-provisions

"130062221.481762115300279620"

```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| annual-provisions | string | Y        | current minting annual provisions value|

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for annual provisions.                                           |
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



## `inflation`

Query the current minting inflation value

**Usage**

```text
  akash query mint inflation [flags]
```

**Example**

```text
$ akash query mint inflation

"0.130064607864796538"

```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| inflation | string | Y        | Query the current minting inflation value |

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for inflation.                                           |
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

## `params`

Query the current minting parameters

**Usage**

```text
 akash query mint params [flags]
```

**Example**

```text
$ akash query mint params -o json

{
  "mint_denom":"stake",
  "inflation_rate_change":"0.130000000000000000",
  "inflation_max":"0.200000000000000000",
  "inflation_min":"0.070000000000000000",
  "goal_bonded":"0.670000000000000000",
  "blocks_per_year":"6311520"
}
```
**Arguments**

| Argument   | Type   | Required | Description                                                                                                               |
| :--------- | :----- | :------- | :------------------------------------------------------------------------------------------------------------------------ |
| params | string | Y        | Query the current minting parameters. |

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for params.                                           |
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


## `slashing`

Querying commands for the slashing module

**Usage**

```text
 akash query slashing [flags]
  akash query slashing [command]
```

**Available Commands**

```text
  params       Query the current slashing parameters
  signing-info  Query a validator's signing information
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |

| -h    | --help   | string   | N        | help for slashing.                          |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |


## `params`

Query genesis parameters for the slashing module

**Usage**

```text
   akash query slashing params [flags]
```

**Example**

```text
  $ akash query slashing params -o json

  {
  "signed_blocks_window":"100",
  "min_signed_per_window":"0.500000000000000000",
  "downtime_jail_duration":"600000000000","slash_fraction_double_sign":"0.050000000000000000","slash_fraction_downtime":"0.010000000000000000"
  }
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for params.                                           |
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

## `signing-info`

Use a validators' consensus public key to find the signing-info for that validator.

**Usage**

```text
   akash query slashing signing-info [validator-conspub] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for signing-info.                                           |
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

## `staking`

Querying commands for the staking module

**Usage**

```text
  akash query staking [flags]
  akash query staking [command]
```

**Available Commands**

```text
  delegation                 Query a delegation based on address and validator address
  delegations                Query all delegations made by one delegator
  delegations-to             Query all delegations made to one validator
  historical-info            Query historical info at given height
  params                     Query the current staking parameters information
  pool                       Query the current staking pool values
  redelegation               Query a redelegation record based on delegator and a source and destination validator address
  redelegations              Query all redelegations records for one delegator
  redelegations-from         Query all outgoing redelegatations from a validator
  unbonding-delegation       Query an unbonding-delegation record based on delegator and validator address
  unbonding-delegations      Query all unbonding-delegations records for one delegator
  unbonding-delegations-from Query all unbonding delegatations from a validator
  validator                  Query a validator
  validators                 Query for all validators
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |

| -h    | --help   | string   | N        | help for staking.                          |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |

## `staking -> delegation`

Query delegations for an individual delegator on an individual validator.

**Usage**

```text
   akash query staking delegation [delegator-addr] [validator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for delegation.                                           |
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

## `staking -> delegations`

Query delegations for an individual delegator on all validators.

**Usage**

```text
   akash query staking delegations [delegator-addr] [flags]
```

**Example**

```text
 $ akash query staking delegations akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84 -o json

 [{
   "delegator_address":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","validator_address":"akashvaloper1zwksclwdjkjaa9whc8rdxtxlkca9zwgcu57thl","shares":"100000000.000000000000000000",
   "balance":{"denom":"stake","amount":"100000000"}
 }]
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for delegations.                                           |
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


## `staking -> delegations-to`

Query delegations on an individual validator.

**Usage**

```text
   akash query staking delegations-to [validator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for delegations-to.                                           |
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


## `staking -> historical-info`

Query historical info at given height.

**Usage**

```text
   akash query staking historical-info [height] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for historical-info.                                           |
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


## `staking -> params`

Query values set as staking parameters.

**Usage**

```text
  akash query staking params [flags]
```

**Example**

```text
 $ akash query staking params -o json

 {
   "unbonding_time":"1814400000000000",
   "max_validators":100,
   "max_entries":7,
   "historical_entries":0,
   "bond_denom":"stake"
 }
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for params.                                           |
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



## `staking -> pool`

Query values for amounts stored in the staking pool.

**Usage**

```text
  akash query staking pool [flags]
```

**Example**

```text
 $ akash query staking pool -o json

 {
   "not_bonded_tokens":"0",
   "bonded_tokens":"100000000"
 }
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for pool.                                           |
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



## `staking -> redelegation`

Query a redelegation record for an individual delegator between a source and destination validator.


**Usage**

```text
  akash query staking redelegation [delegator-addr] [src-validator-addr] [dst-validator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for redelegation.                                           |
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


## `staking -> redelegations`

Query all redelegation records for an individual delegator.


**Usage**

```text
  akash query staking redelegations [delegator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for redelegations.                                           |
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


## `staking -> redelegations-from`

Query delegations that are redelegating from a validator.


**Usage**

```text
  akash query staking redelegations-from [validator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for redelegations-from.                                           |
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

## `staking -> unbonding-delegation`

Query unbonding delegations for an individual delegator on an individual validator.


**Usage**

```text
  akash query staking unbonding-delegation [delegator-addr] [validator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for unbonding-delegation.                                           |
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

## `staking -> unbonding-delegations`

Query unbonding delegations for an individual delegator.

**Usage**

```text
  akash query staking unbonding-delegations [delegator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for unbonding-delegations.                                           |
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


## `staking -> unbonding-delegations-from`

Query delegations that are unbonding from a validator

**Usage**

```text
  akash query staking unbonding-delegations-from [validator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for unbonding-delegations-from.                                           |
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


## `staking -> validator`

Query details about an individual validator.

**Usage**

```text
  akash query staking validator [validator-addr] [flags]
```

**Example**

```text
 TODO
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for validator.                                           |
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

## `staking -> validators`

Query details about all validators on a network.

**Usage**

```text
  akash query staking validators [flags]
```

**Example**

```text
 $ akash query staking validators -o json

  [{"operator_address":"akashvaloper1zwksclwdjkjaa9whc8rdxtxlkca9zwgcu57thl","consensus_pubkey":"akashvalconspub1zcjduepqyt48xd5vj5tqmwq0k2j6puzm4palql6qq56juf4hmajxfefngwkqcs3v6d","jailed":false,"status":2,"tokens":"100000000","delegator_shares":"100000000.000000000000000000","description":{"moniker":"mychain","identity":"","website":"","security_contact":"","details":""},"unbonding_height":"0","unbonding_time":"1970-01-01T00:00:00Z","commission":{"commission_rates":{"rate":"0.100000000000000000","max_rate":"0.200000000000000000","max_change_rate":"0.010000000000000000"},"update_time":"2020-03-10T10:20:12.545378114Z"},"min_self_delegation":"1"}]
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for validators.                                           |
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





## `supply`

Querying commands for the supply module

**Usage**

```text
  akash query supply [flags]
  akash query supply [command]
```

**Available Commands**

```text
  total       Query the total supply of coins of the chain
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |

| -h    | --help   | string   | N        | help for supply.                          |

**Global Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
| -e    | --encoding | string | N       | Binary encoding (hex|b64|btc) (default "hex").   |
|       | --home     | string | N       | directory for config and data (default "/home/ubuntu/.akash") |
| -o    |  --output  | string | N       | Output format (text|json) (default "text")|
|       | --trace    |        | N       | print out full stack trace on errors |


## `supply -> total`

Query total supply of coins that are held by accounts in the chain.

**Usage**

```text
  akash query supply total [denom] [flags]
```

**Example**

```text
    $ akash query supply total -o json

    [{"denom":"akt","amount":"1000000000"},{"denom":"stake","amount":"1000101980"}]
```
**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for total.                                           |
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



## `tendermint-validator-set`

Get the full tendermint validator set at given height

**Usage**

```text
 akash query tendermint-validator-set [height] [flags]
```

**Example**

```text
    $ akash query tendermint-validator-set -o json

    {"block_height":"5132","validators":[{"address":"akashvalcons1zk579sy34mg8xngtedrhs8j5e7qlpa8cxdye2t","pub_key":"akashvalconspub1zcjduepqyt48xd5vj5tqmwq0k2j6puzm4palql6qq56juf4hmajxfefngwkqcs3v6d","proposer_priority":"0","voting_power":"100"}]}
```

**Flags**

| Short | Verbose | Argument | Required | Description                                                                             |
| :---- | :------ | :------- | :------- | :-------------------------------------------------------------------------------------- |
|       | --height | int      | N        | Use a specific height to query state at (this can error if the node is pruning state) |
| -h    | --help   | string   | N        | help for tendermint-validator-set.                                           |
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
