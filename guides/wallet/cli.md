In this guide, we'll generate a wallet address on your workstation 

## Before We Begin

Make sure to have Akash client installed on your workstation, check [install guide](/guides/install.md) for instructions.

## Derive a New Key

Derive a new private key and encrypt to disk using the command `keys add`, to generate a key with the named `alice`, run the below (please make sure to replace alice with a name of your choice):

```sh
akashctl keys add alice
```

You'll see a response similar to below:

```
- name: alice
  type: local
  address: akash1cz87pqkad72gggrv3t7y2x9z56h9gqghlnx3j3
  pubkey: akashpub1addwnpepqtnydvj056gy64uuquldq5yx7mr8ncmn3ut59wwl9p83d8h2v4rtg5xa3vn
  mnemonic: ""
  threshold: 0
  pubkeys: []


**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

town wolf margin parrot strong disease dance eyebrow inflict meadow crunch version tube elite interest movie uphold column shift fox excuse humble nest call
```

In the above example, your new Akash address is `akash1cz87pqkad72gggrv3t7y2x9z56h9gqghlnx3j3` and generated mnemonic phrase is `town wolf margin .... humble nest call`

**IMPORTANT:** It's imperative your keep the mnemonic phrase is a safe place and it is the only way to recover your private key incase you change your device.