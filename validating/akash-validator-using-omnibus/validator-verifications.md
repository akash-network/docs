# Validator Verifications

## Confirm Your Validator is Running

### Ensure Validator Sync

* Ensure that the field \`catching\_up\` is false and that the latest block corresponds to the current block of the blockchain
* Execute this verification on both the sentry and validator nodes

```
akash status
```

#### Example Output when Validator is in Sync

```
{"NodeInfo":{"protocol_version":{"p2p":"8","block":"11","app":"0"},"id":"136d67725800cb5a8baeb3e97dbdc3923879461e","listen_addr":"tcp://0.0.0.0:26656","network":"akashnet-2","version":"0.34.19","channels":"40202122233038606100","moniker":"cznode","other":{"tx_index":"on","rpc_address":"tcp://0.0.0.0:26657"}},"SyncInfo":{"latest_block_hash":"4441B6D626166822979597F252B333C131C1DCB2F0467FF282EF0EAA3936B8CC","latest_app_hash":"1ED64AE88E5CFD53651CD2B6B4E970292778071C8FBE23289393B4A06F57975F","latest_block_height":"8284780","latest_block_time":"2022-10-31T15:28:17.565762161Z","earliest_block_hash":"E25CE5DD10565D6D63CDA65C8653A15F962A4D2960D5EC45D1DC0A4DE06F8EE3","earliest_app_hash":"19526102DDBCE254BA71CC8E44185721D611635F638624C6F950EF31D3074E2B","earliest_block_height":"5851001","earliest_block_time":"2022-05-12T17:51:58.430492536Z","catching_up":false},"ValidatorInfo":{"Address":"354E7FA2BF8C5B9C0F1C80F1C222818EC992D377","PubKey":{"type":"tendermint/PubKeyEd25519","value":"1+dVHZD7kfqnDU6I+bKbCv4ZE1LPieyMH+mwsOowhqY="},"VotingPower":"0"}}
```

### Confirm Validator's Staking Status

#### Template

```
akash query staking validator <akashvaloper-address>
```

#### Example

```
akash query staking validator akashvaloper16j3ge9lkpgtdkzntlja08gt6l63fql60xdupxq
```

#### Example Output

* Status will display as \`BOND\_STATUS\_UNBONDED\` after initial build

```
commission:
  commission_rates:
    max_change_rate: "0.010000000000000000"
    max_rate: "0.200000000000000000"
    rate: "0.100000000000000000"
  update_time: "2022-10-31T15:24:25.040091667Z"
consensus_pubkey:
  '@type': /cosmos.crypto.ed25519.PubKey
  key: 1+dVHZD7kfqnDU6I+bKbCv4ZE1LPieyMH+mwsOowhqY=
delegator_shares: "1000000.000000000000000000"
description:
  details: ""
  identity: ""
  moniker: cznode
  security_contact: ""
  website: ""
jailed: false
min_self_delegation: "1"
operator_address: akashvaloper1jy7ej9t6r8q5dyjrst88nt9rjgkdltgx97wfvd
status: BOND_STATUS_UNBONDED
tokens: "1000000"
unbonding_height: "0"
unbonding_time: "1970-01-01T00:00:00Z"
```

### Active Set Confirmation

Your validator is active if the following command returns anything

> _**NOTE**_ - this command will only display output of your validator is in the active set

```
akash query tendermint-validator-set | grep "$(akash tendermint show-validator)"
```
