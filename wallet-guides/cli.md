# Using CLI

In this guide, we'll generate a wallet address on your workstation

## Before We Begin

Make sure to have Akash client installed on your workstation, check [install guide](../usage/install.md) for instructions.

## Derive a New Key Locally

Derive a new private key and encrypt to disk using the command `keys add`, to generate a key with the named `alice`, run the below \(please make sure to replace alice with a name of your choice\):

```bash
akashctl keys add alice
```

You'll see a response similar to below:

```text
- name: alice
  type: local
  address: akash1cz87pqkad72gggrv3t7y2x9z56h9gqghlnx3j3
  pubkey: akashpub1addwnpepqtnydvj056gy64uuquldq5yx7mr8ncmn3ut59wwl9p83d8h2v4rtg5xa3vn
  mnemonic: ""
  threshold: 0
  pubkeys: []


**Important** write this mnemonic phrase in a safe place. It is the only way to recover your account if you ever forget your password.

town wolf margin parrot strong disease dance eyebrow inflict meadow crunch version tube elite interest movie uphold column shift fox excuse humble nest call
```

In the above example, your new Akash address is `akash1cz87pqkad72gggrv3t7y2x9z56h9gqghlnx3j3` and generated mnemonic phrase is `town wolf margin .... humble nest call`

**IMPORTANT:** It's imperative your keep the mnemonic phrase is a safe place and it is the ONLY way to recover your private key incase you change or lose your device.

## Derive a New Key using Ledger

To derive a key and store it on the ledger, add the `--ledger` flag `keys add` command. For example:

```bash
akashctl keys add alice --ledger
```

Will produce a similar output to:

```text
- name: alice
  type: ledger
  address: akash1dt6wukc53dangle8qz7xjc792u0yrdc3esjlsp
  pubkey: akashpub1addwnpepqvcsl4dxvsrdjyvd839uth7g96qhjq7jcxrnlf5qt0rgchutwcp8wgp4yk9
  mnemonic: ""
  threshold: 0
  pubkeys: []
```

## Recovering Your Keys Using Pass Phrase

The command to recover your key is:

```text
akashctl keys add <name> --recover
```

For example, `akashctl keys add alice --recover` will prompt the user to input a bip39 mnemonic and looks similar to:

```text
> Enter your bip39 mnemonic
diagram pony police cigar curious miracle multiply tiger salmon trade like month oven custom seven assume rail valid abuse forest mountain submit text print

- name: alice
  type: local
  address: akash1skzh3hywj8x5ws7ed30qnz8zf2fq2va6nwdw6t
  pubkey: akashpub1addwnpepqwyfrxddp5zs72qcyujlhky3rxlp80m7z7klyklpdq84mgw04aghvnr5rtz
  mnemonic: ""
  threshold: 0
  pubkeys: []
```

## Exporting Your Private Keys

The command to export your private key is `keys export`. For example:

```bash
akashctl keys export alice
```

will output a response similar to:

```text
Enter passphrase to decrypt your key:
Enter passphrase to encrypt the exported key:
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: DC5BA634306180096D7F9D19E94A7A9D
type: secp256k1

Hdv20eQY/mXdYD4a/zd6QPdBDkMHyyl2qY6Tun/UgQviUUyyTvzuVQgrrZ6tilRI
1FXXkwmeRPCOJ4v6oA2q536aM4Jmc5zYekgZ8OI=
=IGRD
-----END TENDERMINT PRIVATE KEY-----
```

