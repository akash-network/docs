# Run a Validator

Before setting up your validator node, make sure you've already gone through the [Full Node Setup](./) guide.

> NOTE: it is not required to create a validator on Akash testnets unless specified in a challenge or otherwise. The akash team runs a centralized validator set to enable for easy and consistent testnet operations for developers trying out the platform for the first time.

## What is a Validator?

Validators are responsible for committing new blocks to the blockchain through voting. A validator's stake is slashed if they become unavailable or sign blocks at the same height. Please read about [Sentry Node Architecture](https://forum.cosmos.network/t/sentry-node-architecture-overview/454) to learn how to protect your node from DDOS attacks and to ensure high-availability on mainnet.

## Create Your Validator

Your `akashvalconspub` can be used to create a new validator by staking tokens. You can find your validator pubkey by running:

```bash
akash tendermint show-validator
```

The file that stores this private key lives at `~/.akash/config/priv_validator_key.json`. To create your validator, just use the following command:

```bash
akash tx staking create-validator \
  --amount=1000000uakt \
  --pubkey="$(akash tendermint show-validator)" \
  --moniker="$AKASH_MONIKER" \
  --chain-id="$AKASH_CHAIN_ID" \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas="auto" \
  --gas-prices="0.025uakt" \
  --from="$KEY_NAME"
```

::: tip When specifying commission parameters, the `commission-max-change-rate` is used to measure % _point_ change over the `commission-rate`. E.g. 1% to 2% is a 100% rate increase, but only 1 percentage point. :::

::: tip `min-self-delegation` is a stritly positive integer that represents the minimum amount of self-delegated voting power your validator must always have. A `min-self-delegation` of 1 means your validator will never have a self-delegation lower than `1000000uakt` :::

You can confirm that you are in the validator set by using a third party explorer for the testnet you are joining.

## Edit Validator Description

You can edit your validator's public description. This info is to identify your validator, and will be relied on by delegators to decide which validators to stake to. Make sure to provide input for every flag below. If a flag is not included in the command the field will default to empty \(`--moniker` defaults to the machine name\) if the field has never been set or remain the same if it has been set in the past.

The `$KEY_NAME` specifies the key for the validator which you are editing. If you choose to not include certain flags, remember that the `--from` flag must be included to identify the validator to update.

The `--identity` can be used as to verify identity with systems like Keybase or UPort. When using with Keybase `--identity` should be populated with a 16-digit string that is generated with a [keybase.io](https://keybase.io) account. It's a cryptographically secure method of verifying your identity across multiple online networks. The Keybase API allows explorers to retrieve your Keybase avatar. This is how you can add a logo to your validator profile.

```bash
akash tx staking edit-validator
  --moniker="$AKASH_MONIKER" \
  --website="https://akash.network" \
  --identity=6A0D65E29A4CBC8E \
  --details="The SUPERCLOUD IS HERE!" \
  --chain-id="$AKASH_CHAIN_ID" \
  --gas="auto" \
  --gas-prices="0.025uakt" \
  --from="$KEY_NAME" \
  --commission-rate="0.10"
```

**Note**: The `commission-rate` value must adhere to the following invariants:

* Must be between 0 and the validator's `commission-max-rate`
* Must not exceed the validator's `commission-max-change-rate` which is maximum

  % point change rate **per day**. In other words, a validator can only change

  its commission once per day and within `commission-max-change-rate` bounds.

## View Validator Description

View the validator's information with this command:

```bash
akash query staking validator $VALIDATOR_ADDRESS
```

## Track Validator Signing Information

In order to keep track of a validator's signatures in the past you can do so by using the `signing-info` command:

```bash
akash query slashing signing-info $VALIDATOR_PUBKEY \
  --chain-id="$AKASH_CHAIN_ID"
```

## Unjail Validator

When a validator is "jailed" for downtime, you must submit an `Unjail` transaction from the operator account in order to be able to get block proposer rewards again \(depends on the zone fee distribution\).

```bash
akash tx slashing unjail \
    --from="$KEY_NAME" \
    --chain-id="$AKASH_CHAIN_ID"
```

## Confirm Your Validator is Running

Your validator is active if the following command returns anything:

```bash
akash query tendermint-validator-set | grep "$(akash tendermint show-validator)"
```

You should now see your validator in one of the Akash Testnet explorers. You are looking for the `bech32` encoded `address` in the `~/.akash/config/priv_validator.json` file.

## Halting Your Validator

When attempting to perform routine maintenance or planning for an upcoming coordinated upgrade, it can be useful to have your validator systematically and gracefully halt. You can achieve this by either setting the `halt-height` to the height at which you want your node to shutdown or by passing the `--halt-height` flag to `akash`. The node will shutdown with a zero exit code at that given height after committing the block.

## Common Problems

### Problem \#1: My validator has `voting_power: 0`

Your validator has become jailed. Validators get jailed, i.e. get removed from the active validator set, if they do not vote on `500` of the last `10000` blocks, or if they double sign.

If you got jailed for downtime, you can get your voting power back to your validator. First, if `akash` is not running, start it up again. If you are running `systemd` this will be different:

```bash
akash start
```

Wait for your full node to catch up to the latest block. Then, you can [unjail your validator](validator.md#unjail-validator)

Lastly, check your validator again to see if your voting power is back.

```bash
akash status
```

You may notice that your voting power is less than it used to be. That's because you got slashed for downtime!

### Problem \#2: My `akash` crashes because of `too many open files`

The default number of files Linux can open \(per-process\) is `1024`. `akash` is known to open more than `1024` files. This causes the process to crash. A quick fix is to run `ulimit -n 4096` \(increase the number of open files allowed\) and then restart the process with `akash start`. If you are using `systemd` or another process manager to launch `akash` this may require some configuration at that level. See the [`systemd` configuration doc](https://github.com/ovrclk/docs/tree/1c9232aaec2197efbf4532e8883a247566cf9e28/guides/node/systemd.md) for details on how to configure `systemd` to aleviate this issue.

