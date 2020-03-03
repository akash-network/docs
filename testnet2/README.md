# Running a Node

## Initiating the Chain

Initiating the chain by providing a moniker and chain id will generate a genesis file using the below command


```sh
akashd init node-0 --chain-id akash-testnet
```

You will see an output similar to:


Genesis file is generated to `$HOME/.akashd/genesis.json`

```json
{
  "genesis_time": "2020-03-03T03:17:05.784224Z",
  "chain_id": "devnet",
  "consensus_params": {
    "block": {
      "max_bytes": "22020096",
      "max_gas": "-1",
      "time_iota_ms": "1000"
    },
    "evidence": {
      "max_age_num_blocks": "100000",
      "max_age_duration": "172800000000000"
    },
    "validator": {
      "pub_key_types": [
        "ed25519"
      ]
    }
  },
  "app_hash": "",
  "app_state": {
    "auth": {
      "params": {
        "max_memo_characters": "256",
        "tx_sig_limit": "7",
        "tx_size_cost_per_byte": "10",
        "sig_verify_cost_ed25519": "590",
        "sig_verify_cost_secp256k1": "1000"
      },
      "accounts": []
    },
    "supply": {
      "supply": []
    },
    "distribution": {
      "params": {
        "community_tax": "0.020000000000000000",
        "base_proposer_reward": "0.010000000000000000",
        "bonus_proposer_reward": "0.040000000000000000",
        "withdraw_addr_enabled": true
      },
      "fee_pool": {
        "community_pool": []
      },
      "delegator_withdraw_infos": [],
      "previous_proposer": "",
      "outstanding_rewards": [],
      "validator_accumulated_commissions": [],
      "validator_historical_rewards": [],
      "validator_current_rewards": [],
      "delegator_starting_infos": [],
      "validator_slash_events": []
    },
    "deployment": {
      "deployments": null
    },
    "bank": {
      "send_enabled": true
    },
    "staking": {
      "params": {
        "unbonding_time": "1814400000000000",
        "max_validators": 100,
        "max_entries": 7,
        "historical_entries": 0,
        "bond_denom": "stake"
      },
      "last_total_power": "0",
      "last_validator_powers": null,
      "validators": null,
      "delegations": null,
      "unbonding_delegations": null,
      "redelegations": null,
      "exported": false
    },
    "slashing": {
      "params": {
        "signed_blocks_window": "100",
        "min_signed_per_window": "0.500000000000000000",
        "downtime_jail_duration": "600000000000",
        "slash_fraction_double_sign": "0.050000000000000000",
        "slash_fraction_downtime": "0.010000000000000000"
      },
      "signing_infos": {},
      "missed_blocks": {}
    },
    "genutil": {
      "gentxs": []
    },
    "params": null,
    "mint": {
      "minter": {
        "inflation": "0.130000000000000000",
        "annual_provisions": "0.000000000000000000"
      },
      "params": {
        "mint_denom": "stake",
        "inflation_rate_change": "0.130000000000000000",
        "inflation_max": "0.200000000000000000",
        "inflation_min": "0.070000000000000000",
        "goal_bonded": "0.670000000000000000",
        "blocks_per_year": "6311520"
      }
    },
    "market": {
      "orders": null,
      "leases": null
    },
    "provider": {
      "providers": null
    }
  }
}

```

## Create Key

```sh
akash keys add master
```
outputs:

```
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

## Attach Genesis Account

Add 100M tokens to genesis master account

```sh
akashd add-genesis-account master 100000000stake
```

## Generate Transaction

```sh
akashd gentx --name master
```

Outputs:

```
Genesis transaction written to "/Users/gosuri/.akashd/config/gentx/gentx-53f9f81b76c350196cfc816b8cdf001e199e88ee.json
```

## Collect Transaction

```sh
akashd collect-gentxs
```

## Start the Node

```sh
akashd start
```

Outputs:

```
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
