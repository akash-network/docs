# Running a Local Node

This section contains instructions to run a Akash node locally in your workstation

## Before We Begin

Make sure to have Akash client installed on your workstation, check [install guide](../usage/install.md) for instructions.

## Initiating the Chain

Initiating the chain by providing a moniker and chain id will generate a genesis file using the below command

```bash
akashd init node0 --chain-id devnet
```

The above command will create the necessary configurations under `$HOME/.akashd` with the below structure:

```text
├── config
│   ├── app.toml
│   ├── config.toml
│   ├── genesis.json
│   ├── node_key.json
│   └── priv_validator_key.json
└── data
    └── priv_validator_state.json
```

The Genesis file is generated under `$HOME/.akashd/config/genesis.json` will have a structure similar to:

```javascript
{
  "app_message": {
    "auth": {
      "accounts": [],
      "params": {
        "max_memo_characters": "256",
        "sig_verify_cost_ed25519": "590",
        "sig_verify_cost_secp256k1": "1000",
        "tx_sig_limit": "7",
        "tx_size_cost_per_byte": "10"
      }
    },
    "bank": {
      "send_enabled": true
    },
    "deployment": {
      "deployments": null
    },
    "distribution": {
      "delegator_starting_infos": [],
      "delegator_withdraw_infos": [],
      "fee_pool": {
        "community_pool": []
      },
      "outstanding_rewards": [],
      "params": {
        "base_proposer_reward": "0.010000000000000000",
        "bonus_proposer_reward": "0.040000000000000000",
        "community_tax": "0.020000000000000000",
        "withdraw_addr_enabled": true
      },
      "previous_proposer": "",
      "validator_accumulated_commissions": [],
      "validator_current_rewards": [],
      "validator_historical_rewards": [],
      "validator_slash_events": []
    },
    "genutil": {
      "gentxs": []
    },
    "market": {
      "leases": null,
      "orders": null
    },
    "mint": {
      "minter": {
        "annual_provisions": "0.000000000000000000",
        "inflation": "0.130000000000000000"
      },
      "params": {
        "blocks_per_year": "6311520",
        "goal_bonded": "0.670000000000000000",
        "inflation_max": "0.200000000000000000",
        "inflation_min": "0.070000000000000000",
        "inflation_rate_change": "0.130000000000000000",
        "mint_denom": "stake"
      }
    },
    "params": null,
    "provider": {
      "providers": null
    },
    "slashing": {
      "missed_blocks": {},
      "params": {
        "downtime_jail_duration": "600000000000",
        "min_signed_per_window": "0.500000000000000000",
        "signed_blocks_window": "100",
        "slash_fraction_double_sign": "0.050000000000000000",
        "slash_fraction_downtime": "0.010000000000000000"
      },
      "signing_infos": {}
    },
    "staking": {
      "delegations": null,
      "exported": false,
      "last_total_power": "0",
      "last_validator_powers": null,
      "params": {
        "bond_denom": "stake",
        "historical_entries": 0,
        "max_entries": 7,
        "max_validators": 100,
        "unbonding_time": "1814400000000000"
      },
      "redelegations": null,
      "unbonding_delegations": null,
      "validators": null
    },
    "supply": {
      "supply": []
    }
  },
  "chain_id": "devnet",
  "gentxs_dir": "",
  "moniker": "node0",
  "node_id": "ce0f230d7f3223fa48f6a070f813bfea33bfa27d"
}
```

### Configure defaults

```bash
akashctl config chain-id devnet 
akashctl config output json
akashctl config indent true
akashctl config trust-node true
```

The above commands will customize the `akashctl` utility with configuration saved under `$HOME/.akashctl/config/config.toml` and looks similar to:

```text
chain-id = "devnet"
indent = true
output = "json"
trust-node = true
```

## Add a Master Account to Genesis

Generate a key using:

```bash
akashctl keys add master
```

Output looks similar to:

```text
- name: master
  type: local
  address: akash14kauksr2wmtsg3jd6kct48kejrmdstx4g46tv0
  pubkey: akashpub1addwnpepqwgwmmxscnq60rzl7z2sam9rx7uhgpvzxk8ltv6xjym280u4ftzcc9zc0zw
  mnemonic: ""
  threshold: 0
  pubkeys: []


**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

average move castle eager beauty focus sugar gesture method biology brick lonely spice grunt clay sniff sketch artist cigar burden occur spider shiver exit
```

Add 100M tokens to genesis Master account

```bash
akashd add-genesis-account master 100000000uakt,100000000stake
```

## Create a Validator

Create a genesis transaction to create a validator.

```bash
akashd gentx --name master
```

Output will be similar to:

```text
Genesis transaction written to "/Users/gosuri/.akashd/config/gentx/gentx-53f9f81b76c350196cfc816b8cdf001e199e88ee.json
```

## Collect The Genesis Transaction

```bash
akashd collect-gentxs
```

Output will be similar to:

```javascript
{
  "app_message": {
    "auth": {
      "accounts": [
        {
          "type": "cosmos-sdk/Account",
          "value": {
            "account_number": 0,
            "address": "akash12hs4sudwjxvucjd204uug8vv2zu3z2fqz3jlqz",
            "coins": [
              {
                "amount": "100000000",
                "denom": "akash"
              },
              {
                "amount": "100000000",
                "denom": "stake"
              }
            ],
            "public_key": "",
            "sequence": 0
          }
        }
      ],
      "params": {
        "max_memo_characters": "256",
        "sig_verify_cost_ed25519": "590",
        "sig_verify_cost_secp256k1": "1000",
        "tx_sig_limit": "7",
        "tx_size_cost_per_byte": "10"
      }
    },
    "bank": {
      "send_enabled": true
    },
    "deployment": {
      "deployments": null
    },
    "distribution": {
      "delegator_starting_infos": [],
      "delegator_withdraw_infos": [],
      "fee_pool": {
        "community_pool": []
      },
      "outstanding_rewards": [],
      "params": {
        "base_proposer_reward": "0.010000000000000000",
        "bonus_proposer_reward": "0.040000000000000000",
        "community_tax": "0.020000000000000000",
        "withdraw_addr_enabled": true
      },
      "previous_proposer": "",
      "validator_accumulated_commissions": [],
      "validator_current_rewards": [],
      "validator_historical_rewards": [],
      "validator_slash_events": []
    },
    "genutil": {
      "gentxs": [
        {
          "type": "cosmos-sdk/StdTx",
          "value": {
            "fee": {
              "amount": [],
              "gas": "200000"
            },
            "memo": "ce0f230d7f3223fa48f6a070f813bfea33bfa27d@10.0.1.9:26656",
            "msg": [
              {
                "type": "cosmos-sdk/MsgCreateValidator",
                "value": {
                  "commission": {
                    "max_change_rate": "0.010000000000000000",
                    "max_rate": "0.200000000000000000",
                    "rate": "0.100000000000000000"
                  },
                  "delegator_address": "akash12hs4sudwjxvucjd204uug8vv2zu3z2fqz3jlqz",
                  "description": {
                    "details": "",
                    "identity": "",
                    "moniker": "node0",
                    "security_contact": "",
                    "website": ""
                  },
                  "min_self_delegation": "1",
                  "pubkey": "akashvalconspub1zcjduepq285g7q754xtqa38cwxnkmmqzkfvy4e0zhu3mkelswp3d6j8rx8pq9ag7h3",
                  "validator_address": "akashvaloper12hs4sudwjxvucjd204uug8vv2zu3z2fqgnuesg",
                  "value": {
                    "amount": "100000000",
                    "denom": "stake"
                  }
                }
              }
            ],
            "signatures": [
              {
                "pub_key": {
                  "type": "tendermint/PubKeySecp256k1",
                  "value": "AtMoRg/d8LeEa0WY0FlQKs2gEMOZ8jKlEVaf4hN7AXRJ"
                },
                "signature": "HN4TaaSvl5BSDP6jadiAXhkVXbOzNSr/JyQPYFJoChlR/4pXYQ6yr1POupXkduXJL0TxtjNVq5K9CSuxJO5iaQ=="
              }
            ]
          }
        }
      ]
    },
    "market": {
      "leases": null,
      "orders": null
    },
    "mint": {
      "minter": {
        "annual_provisions": "0.000000000000000000",
        "inflation": "0.130000000000000000"
      },
      "params": {
        "blocks_per_year": "6311520",
        "goal_bonded": "0.670000000000000000",
        "inflation_max": "0.200000000000000000",
        "inflation_min": "0.070000000000000000",
        "inflation_rate_change": "0.130000000000000000",
        "mint_denom": "stake"
      }
    },
    "params": null,
    "provider": {
      "providers": null
    },
    "slashing": {
      "missed_blocks": {},
      "params": {
        "downtime_jail_duration": "600000000000",
        "min_signed_per_window": "0.500000000000000000",
        "signed_blocks_window": "100",
        "slash_fraction_double_sign": "0.050000000000000000",
        "slash_fraction_downtime": "0.010000000000000000"
      },
      "signing_infos": {}
    },
    "staking": {
      "delegations": null,
      "exported": false,
      "last_total_power": "0",
      "last_validator_powers": null,
      "params": {
        "bond_denom": "stake",
        "historical_entries": 0,
        "max_entries": 7,
        "max_validators": 100,
        "unbonding_time": "1814400000000000"
      },
      "redelegations": null,
      "unbonding_delegations": null,
      "validators": null
    },
    "supply": {
      "supply": []
    }
  },
  "chain_id": "devnet",
  "gentxs_dir": "/Users/gosuri/.akashd/config/gentx",
  "moniker": "node0",
  "node_id": "ce0f230d7f3223fa48f6a070f813bfea33bfa27d"
}
```

## Validate Genesis and Start the Node

Finally, validate the genesis file and start the akashctl node

```bash
akashd validate-genesis
```

You should see an output similar to:

```text
validating genesis file at /Users/gosuri/.akashd/config/genesis.json
File at /Users/gosuri/.akashd/config/genesis.json is a valid genesis file
```

Start the node using:

```bash
akashd start
```

Output should be similar to:

```text
I[2020-03-02|20:07:59.087] starting ABCI with Tendermint                module=main
I[2020-03-02|20:08:04.376] processed active leases                      module=main count=0
I[2020-03-02|20:08:04.376] Executed block                               module=state height=1 validTxs=0 invalidTxs=0
I[2020-03-02|20:08:04.393] Committed state                              module=state height=1 txs=0 appHash=F8D8809D329495E8A4F8027D2F75D66444E675EE72CEB1F5092C7738839094C4
I[2020-03-02|20:08:09.438] processed active leases                      module=main count=0
I[2020-03-02|20:08:09.438] Executed block                               module=state height=2 validTxs=0 invalidTxs=0
I[2020-03-02|20:08:09.449] Committed state                              module=state height=2 txs=0 appHash=1B936A4C6334DFFB0C0B98E7BBD7FD98BBBBD1B266DA1B13A97F3B7EC7921A63
I[2020-03-02|20:08:14.508] processed active leases                      module=main count=0
I[2020-03-02|20:08:14.508] Executed block                               module=state height=3 validTxs=0 invalidTxs=0
I[2020-03-02|20:08:14.519] Committed state                              module=state height=3 txs=0 appHash=73158B8C64F610A7D07708CD3EF3241B0F5806119E1B5456C3CBF328BA476E35
I[2020-03-02|20:08:19.570] processed active leases                      module=main count=0
I[2020-03-02|20:08:19.570] Executed block                               module=state height=4 validTxs=0 invalidTxs=0
I[2020-03-02|20:08:19.581] Committed state                              module=state height=4 txs=0 appHash=A7D6DE44F9120351708DECF3B2E4DC8A55F94E0DBB27C887EED7085AFD07DFC8
```

## Check Status

In a separate terminal, run the below to check status of the chain:

```text
akashctl status
```

You should see a response similar to:

```javascript
{
  "node_info": {
    "protocol_version": {
      "p2p": "7",
      "block": "10",
      "app": "0"
    },
    "id": "ce0f230d7f3223fa48f6a070f813bfea33bfa27d",
    "listen_addr": "tcp://0.0.0.0:26656",
    "network": "devnet",
    "version": "0.33.0",
    "channels": "4020212223303800",
    "moniker": "node0",
    "other": {
      "tx_index": "on",
      "rpc_address": "tcp://127.0.0.1:26657"
    }
  },
  "sync_info": {
    "latest_block_hash": "421502A91936647AEBDC9D69B2C453954797AA126EB1CD474608332109E17FFA",
    "latest_app_hash": "28C2215A4AE011FD0D5A51CEE5A99CAF3D4364DCBB34CCC9C259C10BE1BDCA11",
    "latest_block_height": "59",
    "latest_block_time": "2020-03-03T21:04:42.676534Z",
    "catching_up": false
  },
  "validator_info": {
    "address": "9D8D54A645B0FE913612C187A72F287532E9220D",
    "pub_key": {
      "type": "tendermint/PubKeyEd25519",
      "value": "UeiPA9Splg7E+HGnbewCslhK5eK/I7tn8HBi3UjjMcI="
    },
    "voting_power": "100"
  }
}
```

