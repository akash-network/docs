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
  -e, --encoding string   Binary encoding (hex/b64/btc) (default "hex")
      --home string       directory for config and data (default "/home/vitwit/.akash")
  -o, --output string     Output format (text/json) (default "text")
      --trace             print out full stack trace on errors

Use "akash query [command] --help" for more information about a command.

```

Use `akash query` to query all the things that need querying.

**Available Commands**

| Command                  | Description                                                 |
|:-------------------------|:------------------------------------------------------------|
| account                  | Query account balance.                                      |
| auth                     | Querying commands for the auth module.                      |
| block                    | Get verified data for a the block at given height.          |
| deployment               | Deployment query commands.                                  |
| distribution             | Querying commands for the distribution module               |
| market                   | Market query commands.                                      |
| mint                     | Querying commands for the minting module.                   |
| provider                 | Provider query commands.                                    |
| slashing                 | Querying commands for the slashing module.                  |
| staking                  | Querying commands for the staking module.                   |
| supply                   | Querying commands for the supply module.                    |
| tendermint-validator-set | Get the full tendermint validator set at given height.      |
| tx                       | Query for a transaction by hash in a committed block.       |
| txs                      | Query for paginated transactions that match a set of events |

## `account`

**Usage**

Query account balance

```text
akash query account [address] [flags]
```

**Example**

```text
$ akash query account akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
{
  "type": "cosmos-sdk/Account",
  "value": {
    "address": "akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf",
    "coins": [
      {
        "denom": "stake",
        "amount": "869997740"
      }
    ],
    "public_key": "akashpub1addwnpepq05y9ye9nhsutpks5rlp5q93r3pefnjew4e9u4d7sxsqaa2gcpwug9szhl2",
    "account_number": 4,
    "sequence": 9
  }
}
```

**Arguments**

| Argument | Type   | Required | Description                                                     |
|:---------|:-------|:---------|:----------------------------------------------------------------|
| address  | string | Y        | Account address to query. Omitting this argument returns error. |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state). |
| -h    | --help       |          | N        | help for account                                                                       |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


## `auth`

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
{
  "type": "cosmos-sdk/Account",
  "value": {
    "address": "akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf",
    "coins": [
      {
        "denom": "stake",
        "amount": "869997740"
      }
    ],
    "public_key": "akashpub1addwnpepq05y9ye9nhsutpks5rlp5q93r3pefnjew4e9u4d7sxsqaa2gcpwug9szhl2",
    "account_number": 4,
    "sequence": 9
  }
}
```

**Arguments**

| Argument | Type   | Required | Description                                                     |
|:---------|:-------|:---------|:----------------------------------------------------------------|
| account  | string | Y        | Account address to query. Omitting this argument returns error. |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state). |
| -h    | --help       |          | N        | help for auth                                                                          |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

## `block`

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

| Argument | Type | Required | Description                        |
|:---------|:-----|:---------|:-----------------------------------|
| height   | int  | Y        | To get block data at given height. |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                   |
|:------|:-------------|:---------|:---------|:--------------------------------------------------------------|
| -h    | --help       |          | N        | help for block                                                |
| -n    | --node       | string   | N        | Node to connect to (default "tcp://localhost:26657")          |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses) |


**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


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

### `commission`

Query validator commission rewards from delegators to that validator.

**Usage**

```text
  akash query distribution commission [validator] [flags]
```

**Example**

```text
$ akash query distribution commission akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
[
  {
    "denom": "stake",
    "amount": "17880.198000000000000000"
  }
]
```
**Arguments**

| Argument  | Type   | Required | Description                                                     |
|:----------|:-------|:---------|:----------------------------------------------------------------|
| validator | string | Y        | validator commission rewards from delegators to that validator. |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for commision.                                                                    |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `community-pool`

Query all coins in the community pool which is under Governance control.  

**Usage**

```text
  akash query distribution community-pool [flags]
```

**Example**

```text
$ akash query distribution community-pool
[
  {
    "denom": "stake",
    "amount": "3677.080000000000000000"
  }
]
```
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for community-pool.                                                               |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `params`

Query distribution params.

**Usage**

```text
  akash query distribution params [flags]
```

**Example**

```text
$ akash query distribution params
{
  "community_tax": "0.020000000000000000",
  "base_proposer_reward": "0.010000000000000000",
  "bonus_proposer_reward": "0.040000000000000000",
  "withdraw_addr_enabled": true
}
```
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for params.                                                                       |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `rewards`

Query all rewards earned by a delegator, optionally restrict to rewards from a single validator.

**Usage**

```text
  akash query distribution rewards [delegator-addr] [<validator-addr>] [flags]
```

**Example**

```text
$ akash query distribution rewards akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
{
  "rewards": [
    {
      "validator_address": "akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr",
      "reward": [
        {
          "denom": "stake",
          "amount": "163504.278000000000000000"
        }
      ]
    }
  ],
  "total": [
    {
      "denom": "stake",
      "amount": "163504.278000000000000000"
    }
  ]
}
```
**Arguments**

| Argument       | Type   | Required | Description                                                   |
|:---------------|:-------|:---------|:--------------------------------------------------------------|
| delegator-addr | string | Y        | Query all rewards earned by a delegator.                      |
| validator-addr | string | N        | Query all rewards earned by a delegator with given validator. |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for rewards.                                                                      |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `slashes`

Query all slashes of a validator for a given block range.

**Usage**

```text
  akash query distribution slashes [validator] [start-height] [end-height] [flags]
```

**Example**

```text
$ akash query distribution slashes akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr 2 300
null
```
**Arguments**

| Argument     | Type   | Required | Description                        |
|:-------------|:-------|:---------|:-----------------------------------|
| validator    | string | Y        | Validator address to query slashes |
| start-height | int    | Y        | Start height of block range        |
| end-height   | int    | Y        | End height of block range          |


**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for slashes.                                                                      |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `validator-outstanding-rewards`

Query distribution outstanding (un-withdrawn) rewards
for a validator and all their delegations.

**Usage**

```text
  akash query distribution validator-outstanding-rewards [validator] [flags]
```

**Example**

```text
$ akash query distribution validator-outstanding-rewards akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
[
  {
    "denom": "stake",
    "amount": "184182.180000000000000000"
  }
]
```
**Arguments**

| Argument  | Type   | Required | Description       |
|:----------|:-------|:---------|:------------------|
| validator | string | Y        | validator address |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for validator-outstading-rewards.                                                 |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

## `gov`

Querying commands for the governance module

**Usage**

```text
  akash query gov [flags]
  akash query gov [command]
```

**Available Commands**

```text
  deposit     Query details of a deposit
  deposits    Query deposits on a proposal
  param       Query the parameters (voting|tallying|deposit) of the governance process
  params      Query the parameters of the governance process
  proposal    Query details of a single proposal
  proposals   Query proposals with optional filters
  proposer    Query the proposer of a governance proposal
  tally       Get the tally of a proposal vote
  vote        Query details of a single vote
  votes       Query votes on a proposal
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `deposit`

Query details for a single proposal deposit on a proposal by its identifier.

**Usage**

```text
  akash query gov deposit [proposal-id] [depositor-addr] [flags]
```

**Example**

```text
$ akash query gov deposit 1 akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf
{
  "proposal_id": "1",
  "depositor": "akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf",
  "amount": [
    {
      "denom": "stake",
      "amount": "20"
    }
  ]
}
```
**Arguments**

| Argument       | Type   | Required | Description              |
|:---------------|:-------|:---------|:-------------------------|
| proposal-id    | int    | Y        | ID of proposal           |
| depositor-addr | string | Y        | Address of the depositor |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `deposits`

Query details for a single proposal deposit on a proposal by its identifier.

**Usage**

```text
  akash query gov deposits [proposal-id] [flags]
```

**Example**

```text
$ akash query gov deposits 1
[
  {
    "proposal_id": "1",
    "depositor": "akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf",
    "amount": [
      {
        "denom": "stake",
        "amount": "20"
      }
    ]
  }
]
```
**Arguments**

| Argument    | Type | Required | Description    |
|:------------|:-----|:---------|:---------------|
| proposal-id | int  | Y        | ID of proposal |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `param`

Query the all the parameters for the governance process.

**Usage**

```text
  akash query gov param [param-type] [flags]
```

**Example**

```text
$ akash query gov param voting
{
  "voting_period": "172800000000000"
}
```
**Arguments**

| Argument   | Type   | Required | Description                             |
|:-----------|:-------|:---------|:----------------------------------------|
| param-type | string | Y        | Type of param (voting/tallying/deposit) |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `params`

Query the all the parameters for the governance process.

**Usage**

```text
  akash query gov params [flags]
```

**Example**

```text
$ akash query gov params
{
  "voting_params": {
    "voting_period": "172800000000000"
  },
  "tally_params": {
    "quorum": "0.334000000000000000",
    "threshold": "0.500000000000000000",
    "veto": "0.334000000000000000"
  },
  "deposit_params": {
    "min_deposit": [
      {
        "denom": "stake",
        "amount": "10000000"
      }
    ],
    "max_deposit_period": "172800000000000"
  }
}
```
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `proposal`

Query details for a proposal. You can find the proposal-id by running "akash query gov proposals".

**Usage**

```text
  akash query gov proposal [proposal-id] [flags]
```

**Example**

```text
$ akash query gov proposal 1
{
  "content": {
    "type": "cosmos-sdk/TextProposal",
    "value": {
      "title": "Test Proposal",
      "description": "My awesome proposal"
    }
  },
  "id": "1",
  "proposal_status": "DepositPeriod",
  "final_tally_result": {
    "yes": "0",
    "abstain": "0",
    "no": "0",
    "no_with_veto": "0"
  },
  "submit_time": "2020-04-22T10:40:40.658115495Z",
  "deposit_end_time": "2020-04-24T10:40:40.658115495Z",
  "total_deposit": [
    {
      "denom": "stake",
      "amount": "20"
    }
  ],
  "voting_start_time": "0001-01-01T00:00:00Z",
  "voting_end_time": "0001-01-01T00:00:00Z"
}
```
**Arguments**

| Argument    | Type | Required | Description    |
|:------------|:-----|:---------|:---------------|
| proposal-id | int  | Y        | ID of proposal |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `proposals`

Query for a all paginated proposals.

**Usage**

```text
  akash query gov proposals [flags]
```

**Example**

```text
$ akash query gov proposals
[
  {
    "content": {
      "type": "cosmos-sdk/TextProposal",
      "value": {
        "title": "Test Proposal",
        "description": "My awesome proposal"
      }
    },
    "id": "1",
    "proposal_status": "DepositPeriod",
    "final_tally_result": {
      "yes": "0",
      "abstain": "0",
      "no": "0",
      "no_with_veto": "0"
    },
    "submit_time": "2020-04-22T10:40:40.658115495Z",
    "deposit_end_time": "2020-04-24T10:40:40.658115495Z",
    "total_deposit": [
      {
        "denom": "stake",
        "amount": "20"
      }
    ],
    "voting_start_time": "0001-01-01T00:00:00Z",
    "voting_end_time": "0001-01-01T00:00:00Z"
  }
]
```
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                                          |
|:------|:-------------|:---------|:---------|:-----------------------------------------------------------------------------------------------------|
|       | --depositor  | string   | N        | (optional) filter by proposals deposited on by depositor                                             |
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)                |
| -h    | --help       | string   | N        | help for annual provisions.                                                                          |
|       | --indent     |          | N        | Add indent to JSON response                                                                          |
|       | --ledger     |          | N        | Use a connected Ledger device                                                                        |
|       | --limit      | int      | N        | pagination limit of proposals to query for (default 100)                                             |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657")               |
|       | --page       | int      | N        | pagination page of proposals to to query for (default 1)                                             |
|       | --status     | string   | N        | (optional) filter proposals by proposal status, status: deposit_period/voting_period/passed/rejected |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                                        |
|       | --voter      | string   | N        | (optional) filter by proposals voted on by voted                                                     |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `proposer`

Query which address proposed a proposal with a given ID.

**Usage**

```text
  akash query gov proposer [proposal-id] [flags]
```

**Example**

```text
$ akash query gov proposer 1
{
  "proposal_id": "1",
  "proposer": "akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf"
}
```
**Arguments**

| Argument    | Type | Required | Description    |
|:------------|:-----|:---------|:---------------|
| proposal-id | int  | Y        | ID of proposal |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `deposits`

Query tally of votes on a proposal with a given proposal ID.

**Usage**

```text
  akash query gov tally [proposal-id] [flags]
```

**Example**

```text
$ akash query gov tally 1
{
  "yes": "0",
  "abstain": "0",
  "no": "0",
  "no_with_veto": "0"
}
```
**Arguments**

| Argument    | Type | Required | Description    |
|:------------|:-----|:---------|:---------------|
| proposal-id | int  | Y        | ID of proposal |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `vote`

Query details for a single vote on a proposal given its identifier.

**Usage**

```text
  akash query gov vote [proposal-id] [voter-addr] [flags]
```

**Example**

```text
$ akash query gov vote 1 akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf
ERROR: address 'akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf' did not vote on proposalID 1
```
**Arguments**

| Argument    | Type   | Required | Description    |
|:------------|:-------|:---------|:---------------|
| proposal-id | int    | Y        | ID of proposal |
| voter-addr  | string | Y        | Voted Address  |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `votes`

Query vote details for a single proposal by its identifier.

**Usage**

```text
  akash query gov votes [proposal-id] [flags]
```

**Example**

```text
$ akash query gov votes 1
null
```
**Arguments**

| Argument    | Type | Required | Description    |
|:------------|:-----|:---------|:---------------|
| proposal-id | int  | Y        | ID of proposal |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --limit      | int      | N        | pagination limit of votes to query for (default 100)                                   |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --page       | int      | N        | pagination page of votes to to query for (default 1)                                   |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

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

| Short | Verbose | Argument | Required | Description    |
|:------|:--------|:---------|:---------|:---------------|
| -h    | --help  | string   | N        | help for mint. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |



### `annual-provisions`

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

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |



### `inflation`

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

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for inflation.                                                                    |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `params`

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

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for params.                                                                       |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

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

| Short | Verbose | Argument | Required | Description        |
|:------|:--------|:---------|:---------|:-------------------|
| -h    | --help  | string   | N        | help for slashing. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `params`

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
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for params.                                                                       |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `signing-info`

Use a validators' consensus public key to find the signing-info for that validator.

**Usage**

```text
   akash query slashing signing-info [validator-conspub] [flags]
```

**Example**

```text
 $ akash query slashing signing-info akashvalconspub1zcjduepq684h6mwk9ttnh7xhtzazhnpse4mcths2t086wmyj2dhxymqm35dstmj96y
{
  "address": "akashvalcons156gt0up7ajnxudhr08nvn7gpz06k8c8pwhk32v",
  "start_height": "0",
  "index_offset": "3821",
  "jailed_until": "1970-01-01T00:00:00Z",
  "tombstoned": false,
  "missed_blocks_counter": "0"
}
```
**Arguments**

| Argument          | Type   | Required | Description                   |
|:------------------|:-------|:---------|:------------------------------|
| validator-conspub | string | Y        | Consensus pubkey of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for signing-info.                                                                 |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

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

| Short | Verbose | Argument | Required | Description       |
|:------|:--------|:---------|:---------|:------------------|
| -h    | --help  | string   | N        | help for staking. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `delegation`

Query delegations for an individual delegator on an individual validator.

**Usage**

```text
   akash query staking delegation [delegator-addr] [validator-addr] [flags]
```

**Example**

```text
$ akash query staking delegation akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
{
  "delegator_address": "akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf",
  "validator_address": "akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr",
  "shares": "100000000.000000000000000000",
  "balance": {
    "denom": "stake",
    "amount": "100000000"
  }
}
```
**Arguments**

| Argument       | Type   | Required | Description                    |
|:---------------|:-------|:---------|:-------------------------------|
| delegator-addr | string | Y        | Delegator address of validator |
| validator-addr | string | Y        | Operator address of validator  |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for delegation.                                                                   |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `delegations`

Query delegations for an individual delegator on all validators.

**Usage**

```text
   akash query staking delegations [delegator-addr] [flags]
```

**Example**

```text
 $ akash query staking delegations akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84
 [{
   "delegator_address":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","validator_address":"akashvaloper1zwksclwdjkjaa9whc8rdxtxlkca9zwgcu57thl","shares":"100000000.000000000000000000",
   "balance":{"denom":"stake","amount":"100000000"}
 }]
```
**Arguments**

| Argument       | Type   | Required | Description                    |
|:---------------|:-------|:---------|:-------------------------------|
| delegator-addr | string | Y        | Delegator address of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for delegations.                                                                  |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `delegations-to`

Query delegations on an individual validator.

**Usage**

```text
   akash query staking delegations-to [validator-addr] [flags]
```

**Example**

```text
 $ akash query staking delegations-to akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
[
  {
    "delegator_address": "akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf",
    "validator_address": "akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr",
    "shares": "100000000.000000000000000000",
    "balance": {
      "denom": "stake",
      "amount": "100000000"
    }
  }
]
```
**Arguments**

| Argument       | Type   | Required | Description                   |
|:---------------|:-------|:---------|:------------------------------|
| validator-addr | string | Y        | Operator address of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for delegations-to.                                                               |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `historical-info`

Query historical info at given height.

**Usage**

```text
   akash query staking historical-info [height] [flags]
```

**Example**

```text
$ akash query staking historical-info 100
ERROR: no historical info found
```
**Arguments**

| Argument | Type | Required | Description  |
|:---------|:-----|:---------|:-------------|
| height   | int  | Y        | Block height |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for historical-info.                                                              |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `params`

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
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for params.                                                                       |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |



### `pool`

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
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for pool.                                                                         |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `redelegation`

Query a redelegation record for an individual delegator between a source and destination validator.

**Usage**

```text
  akash query staking redelegation [delegator-addr] [src-validator-addr] [dst-validator-addr] [flags]
```

**Example**

```text
$ akash query staking redelegation akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr akashvaloper1zwksclwdjkjaa9whc8rdxtxlkca9zwgcu57thl
ERROR: no redelegation found
```
**Arguments**

| Argument           | Type   | Required | Description                    |
|:-------------------|:-------|:---------|:-------------------------------|
| delegator-addr     | string | Y        | Delegator address of validator |
| src-validator-addr | string | Y        | Source validator address       |
| dst-validator-addr | string | Y        | Destination validator address  |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for redelegation.                                                                 |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `redelegations`

Query all redelegation records for an individual delegator.

**Usage**

```text
  akash query staking redelegations [delegator-addr] [flags]
```

**Example**

```text
$ akash query staking redelegations akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf
null
```
**Arguments**

| Argument       | Type   | Required | Description                    |
|:---------------|:-------|:---------|:-------------------------------|
| delegator-addr | string | Y        | Delegator address of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for redelegations.                                                                |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `redelegations-from`

Query delegations that are redelegating from a validator.

**Usage**

```text
  akash query staking redelegations-from [validator-addr] [flags]
```

**Example**

```text
$ akash query staking redelegations-from akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
null
```
**Arguments**

| Argument       | Type   | Required | Description                   |
|:---------------|:-------|:---------|:------------------------------|
| validator-addr | string | Y        | Operator address of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for redelegations-from.                                                           |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `unbonding-delegation`

Query unbonding delegations for an individual delegator on an individual validator.


**Usage**

```text
  akash query staking unbonding-delegation [delegator-addr] [validator-addr] [flags]
```

**Example**

```text
$ akash query staking unbonding-delegation akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
ERROR: no unbonding delegation found
```
**Arguments**

| Argument       | Type   | Required | Description                    |
|:---------------|:-------|:---------|:-------------------------------|
| delegator-addr | string | Y        | Delegator address of validator |
| validator-addr | string | Y        | Operator address of validator  |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for unbonding-delegation.                                                         |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `unbonding-delegations`

Query unbonding delegations for an individual delegator.

**Usage**

```text
  akash query staking unbonding-delegations [delegator-addr] [flags]
```

**Example**

```text
$ akash query staking unbonding-delegations akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf
null
```
**Arguments**

| Argument       | Type   | Required | Description                    |
|:---------------|:-------|:---------|:-------------------------------|
| delegator-addr | string | Y        | Delegator address of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for unbonding-delegations.                                                        |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `unbonding-delegations-from`

Query delegations that are unbonding from a validator

**Usage**

```text
  akash query staking unbonding-delegations-from [validator-addr] [flags]
```

**Example**

```text
$ akash query staking unbonding-delegations-from akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
null
```
**Arguments**

| Argument       | Type   | Required | Description                   |
|:---------------|:-------|:---------|:------------------------------|
| validator-addr | string | Y        | Operator address of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for unbonding-delegations-from.                                                   |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `validator`

Query details about an individual validator.

**Usage**

```text
  akash query staking validator [validator-addr] [flags]
```

**Example**

```text
$ akash query staking validator akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr
{
  "operator_address": "akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr",
  "consensus_pubkey": "akashvalconspub1zcjduepq684h6mwk9ttnh7xhtzazhnpse4mcths2t086wmyj2dhxymqm35dstmj96y",
  "jailed": false,
  "status": 2,
  "tokens": "100000000",
  "delegator_shares": "100000000.000000000000000000",
  "description": {
    "moniker": "node0",
    "identity": "",
    "website": "",
    "security_contact": "",
    "details": ""
  },
  "unbonding_height": "0",
  "unbonding_time": "1970-01-01T00:00:00Z",
  "commission": {
    "commission_rates": {
      "rate": "0.100000000000000000",
      "max_rate": "0.200000000000000000",
      "max_change_rate": "0.010000000000000000"
    },
    "update_time": "2020-04-16T06:20:21.408537921Z"
  },
  "min_self_delegation": "1"
}
```
**Arguments**

| Argument       | Type   | Required | Description                   |
|:---------------|:-------|:---------|:------------------------------|
| validator-addr | string | Y        | Operator address of validator |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for validator.                                                                    |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `validators`

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
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for validators.                                                                   |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


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

| Short | Verbose | Argument | Required | Description      |
|:------|:--------|:---------|:---------|:-----------------|
| -h    | --help  | string   | N        | help for supply. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


### `total`

Query total supply of coins that are held by accounts in the chain.

**Usage**

```text
  akash query supply total [denom] [flags]
```

**Example**

```text
    $ akash query supply total

    [{"denom":"akt","amount":"1000000000"},{"denom":"stake","amount":"1000101980"}]
```
**Arguments**

| Argument | Type   | Required | Description   |
|:---------|:-------|:---------|:--------------|
| denom    | string | N        | Name of Denom |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for total.                                                                        |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |



## `tendermint-validator-set`

Get the full tendermint validator set at given height

**Usage**

```text
 akash query tendermint-validator-set [height] [flags]
```

**Example**

```text
    $ akash query tendermint-validator-set

    {"block_height":"5132","validators":[{"address":"akashvalcons1zk579sy34mg8xngtedrhs8j5e7qlpa8cxdye2t","pub_key":"akashvalconspub1zcjduepqyt48xd5vj5tqmwq0k2j6puzm4palql6qq56juf4hmajxfefngwkqcs3v6d","proposer_priority":"0","voting_power":"100"}]}
```
**Arguments**

| Argument | Type | Required | Description  |
|:---------|:-----|:---------|:-------------|
| height   | int  | N        | Block height |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for tendermint-validator-set.                                                     |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

## `tx`

Query for a transaction by hash in a committed block

**Usage**

```text
  akash query tx [hash] [flags]
```

**Example**

```text
$ akash query tx 295A56A7B4DA7DE3266329981945307FF73ACFF1CCD319D1E1AE53DF16E0125E -o json

{"height":"338","txhash":"295A56A7B4DA7DE3266329981945307FF73ACFF1CCD319D1E1AE53DF16E0125E","codespace":"staking","code":3,"raw_log":"validator does not exist: failed to execute message; message index: 0","gas_wanted":"200000","gas_used":"35496","tx":{"type":"cosmos-sdk/StdTx","value":{"msg":[{"type":"cosmos-sdk/MsgBeginRedelegate","value":{"delegator_address":"akash16q6s0tauc3cks5us7f57wds8c8lqg4jqs0qtaf","validator_src_address":"akashvaloper1qgjla78dk2yk2eh6dmjeejz6m374ykdtpgp92s","validator_dst_address":"akashvaloper16q6s0tauc3cks5us7f57wds8c8lqg4jq6dwddr","amount":{"denom":"stake","amount":"10000"}}}],"fee":{"amount":[],"gas":"200000"},"signatures":[{"pub_key":{"type":"tendermint/PubKeySecp256k1","value":"A+hCkyWd4cWG0KD+GgCxHEOUzll1cl5VvoGgDvVIwF3E"},"signature":"XI1XhIXlSCPnQVHQamu+sbqiZxAxLM8OnXSF2gqNVkkpP1bi6Au3v8N4EUAaPrZGYigechb2ekt6MUEjrFWdgw=="}],"memo":""}},"timestamp":"2020-03-06T10:39:57Z"}
```
**Arguments**

| Argument | Type   | Required | Description      |
|:---------|:-------|:---------|:-----------------|
| hash     | string | N        | Transaction hash |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
| -h    | --help       | string   | N        | help for tx.                                                                           |
| -n    | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |


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
$ akash query txs --events 'message.action=bid-close'
{
  "total_count": "0",
  "count": "0",
  "page_number": "1",
  "page_total": "0",
  "limit": "30",
  "txs": []
}
```
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --events     | string   | Y        | list of transaction events in the form of eventType.eventAttribute=value               |
| -h    | --help       | string   | N        | help for tx.                                                                           |
|       | --limit      | uint32   | N        | Query number of transactions results per page returned (default 30)                    |
| -n    | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --page       | uint32   | N        | Query a specific page of paginated results (default 1)                                 |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

## `upgrade`

Querying commands for the upgrade module

**Usage**

```text
  akash query upgrade [flags]
  akash query upgrade [command]
```

**Available Commands**

```text
  applied     block header for height at which a completed upgrade was applied
  plan        get upgrade plan (if one exists)
```

**Flags**

| Short | Verbose | Argument | Required | Description   |
|:------|:--------|:---------|:---------|:--------------|
| -h    | --help  | string   | N        | help for gov. |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `applied`

If upgrade-name was previously executed on the chain, this returns the header for the block at which it was applied.
This helps a client determine which binary was valid over a given range of blocks, as well as more context to understand past migrations.

**Usage**

```text
  akash query upgrade applied [upgrade-name] [flags]
```

**Example**

```text
$ akash query upgrade applied new-upgrade
ERROR: no upgrade found
```
**Arguments**

| Argument     | Type   | Required | Description     |
|:-------------|:-------|:---------|:----------------|
| upgrade-name | string | Y        | Name of upgrade |

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |

### `plan`

Gets the currently scheduled upgrade plan, if one exists.

**Usage**

```text
  akash query upgrade plan [flags]
```

**Example**

```text
$ akash query upgrade plan
ERROR: no upgrade scheduled
```
**Arguments**

None

**Flags**

| Short | Verbose      | Argument | Required | Description                                                                            |
|:------|:-------------|:---------|:---------|:---------------------------------------------------------------------------------------|
|       | --height     | int      | N        | Use a specific height to query state at (this can error if the node is pruning state)  |
| -h    | --help       | string   | N        | help for annual provisions.                                                            |
|       | --indent     |          | N        | Add indent to JSON response                                                            |
|       | --ledger     |          | N        | Use a connected Ledger device                                                          |
|       | --node       | string   | N        | host:port to Tendermint RPC interface for this chain (default "tcp://localhost:26657") |
|       | --trust-node |          | N        | Trust connected full node (don't verify proofs for responses)                          |

**Global Flags**

| Short | Verbose    | Argument | Required | Description                                                   |
|:------|:-----------|:---------|:---------|:--------------------------------------------------------------|
| -e    | --encoding | string   | N        | Binary encoding (hex/b64/btc) (default "hex").                |
|       | --home     | string   | N        | directory for config and data (default "/home/ubuntu/.akash") |
| -o    | --output   | string   | N        | Output format (text/json) (default "text")                    |
|       | --trace    |          | N        | print out full stack trace on errors                          |
