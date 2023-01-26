# Create Your Account

### Before We Begin

In this guide, we'll generate a wallet address on your workstation. Make sure to have Akash client installed on your workstation.

### What are Shell Variables?

Shell variables will be used throughout these guides to make the instructions so that the commands can be used verbatim. The beginning of each guide will give a list of variables used and how to populate them.

Closing or changing terminals will mean that you have to re-define the variable. Because of this, it is important to type the commands into a terminal where the variables have been defined.

| Name                    | Description                                                                   |
| ----------------------- | ----------------------------------------------------------------------------- |
| `AKASH_KEY_NAME`        | Key name of your choosing. This documentation uses a value of "alice".        |
| `AKASH_KEYRING_BACKEND` | Keyring backend to use for local keys. One of `os` (default), `file`, `test`. |

### 1. Define your Shell Variables

First configure the name of your key. The command below will set thee name of your key to `alice`, run the below command and replace `alice` with a name of your choice:

```bash
AKASH_KEY_NAME=alice
```

Next, set the Key Ring Backend that you will use to store your key locally. The default is `os` and will store the key in your operating system, protected by your login password. You can change this to `file` or `test`.

```bash
AKASH_KEYRING_BACKEND=os
```

### 2. Derive a New Key Locally

Derive a new private key and encrypt to disk using the command `keys add`

```bash
provider-services \
  --keyring-backend "$AKASH_KEYRING_BACKEND" \
  keys add "$AKASH_KEY_NAME"
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


**Important** write this mnemonic phrase in a safe place. It is the only way to recover your account if you ever forget your password.

town wolf margin parrot strong disease dance eyebrow inflict meadow crunch version tube elite interest movie uphold column shift fox excuse humble nest call
```

In the above example, your new Akash address is `akash1cz87pqkad72gggrv3t7y2x9z56h9gqghlnx3j3` and generated mnemonic phrase is `town wolf margin .... humble nest call`

**IMPORTANT:** It's imperative you keep the mnemonic phrase in a safe place. It is the ONLY way to recover your private key incase you change or lose your device.

### 3. Derive a New Key using Ledger

To derive a key and store it on the ledger, add the `--ledger` flag `keys add` command. For example:

```bash
provider-services \
  --keyring-backend "$AKASH_KEYRING_BACKEND" \
  keys add "$AKASH_KEY_NAME" \
  --ledger
```

Will produce a similar output to:

```yaml
- name: alice
  type: ledger
  address: akash1dt6wukc53dangle8qz7xjc792u0yrdc3esjlsp
  pubkey: akashpub1addwnpepqvcsl4dxvsrdjyvd839uth7g96qhjq7jcxrnlf5qt0rgchutwcp8wgp4yk9
  mnemonic: ""
  threshold: 0
  pubkeys: []
```

### 4. Recovering Your Keys Using Pass Phrase

The command to recover your key is:

```bash
provider-services \
  --keyring-backend "$AKASH_KEYRING_BACKEND" \
  keys add "$AKASH_KEY_NAME" \
  --recover
```

This will prompt the user to input a bip39 mnemonic and looks similar to:

```
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

### 5. Exporting Your Private Keys

The command to export your private key is `keys export`. For example:

```bash
provider-services \
  --keyring-backend "$AKASH_KEYRING_BACKEND" \
  keys export "$AKASH_KEY_NAME"
```

will output a response similar to:

```
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

## 6. Get your Account Address

You can now find your account address with this command:

```bash
provider-services \
  --keyring-backend "$AKASH_KEYRING_BACKEND" \
  keys show "$AKASH_KEY_NAME" -a
```

You can now set the Shell Variable `AKASH_ACCOUNT_ADDRESS` for your account address:

```bash
export AKASH_ACCOUNT_ADDRESS="$(provider-services keys show $AKASH_KEY_NAME -a)"

echo $AKASH_ACCOUNT_ADDRESS
```
