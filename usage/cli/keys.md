# Manage Keys

Keys allows you to manage your local keystore for Akash. These keys may be in any format supported by go-crypto and can be used by light-clients, full nodes, or any other application that needs to sign with a private key.

Keys allows you to manage your local keystore for tendermint.

    These keys may be in any format supported by go-crypto and can be
    used by light-clients, full nodes, or any other application that
    needs to sign with a private key.

**Usage**

```shell
$  akash keys [command]
```

**Example**

```shell
$ akash help keys

Usage:
  akash keys [command]

Available Commands:

  add         Add an encrypted private key (either newly generated or recovered), encrypt it, and save to disk
  delete      Delete the given keys
  export      Export private keys
  import      Import private keys into the local keybase
  list        List all keys
  migrate     Migrate keys from the legacy (db-based) Keybase
  mnemonic    Compute the bip39 mnemonic for some input entropy
  parse       Parse address from hex to bech32 and vice versa
  show        Show key info for the given name

Flags:
  -h, --help                     help for keys
      --keyring-backend string   Select keyring's backend (os|file|test) (default "os")

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

Use "akash keys [command] --help" for more information about a command.
```

Use `akash keys` to create and manage your keys.

**Available Commands**

| Command | Description |
| :--- | :--- |
| add  | Add an encrypted private key (either newly generated or recovered), encrypt it, and save to disk
| delete | Delete the given keys
| export | Export private keys
| import | Import private keys into the local keybase
| list | List all keys
| migrate | Migrate keys from the legacy (db-based) Keybase
| mnemonic | Compute the bip39 mnemonic for some input entropy
| parse | Parse address from hex to bech32 and vice versa
| show | Show key info for the given name

## add

Derive a new private key and encrypt to disk.
Optionally specify a BIP39 mnemonic, a BIP39 passphrase to further secure the mnemonic,
and a bip32 HD path to derive a specific account. The key will be stored under the given name
and encrypted with the given password. The only input that is required is the encryption password.

If run with -i, it will prompt the user for BIP44 path, BIP39 mnemonic, and passphrase.
The flag --recover allows one to recover a key from a seed passphrase.
If run with --dry-run, a key would be generated (or recovered) but not stored to the
local keystore.
Use the --pubkey flag to add arbitrary public keys to the keystore for constructing
multisig transactions.

You can add a multisig key by passing the list of key names you want the public
key to be composed of to the --multisig flag and the minimum number of signatures
required through --multisig-threshold. The keys are sorted by address, unless
the flag --nosort is set.

**Usage**

```text
$ akash keys add <name> [flags]
```

**Example**

```shell
  $ akash keys add john -o json

  {
    "name":"john",
    "type":"local",
    "address":"akash1ctftncga85hllpzvctgs3asz2g6dj4q29n5fun","pubkey":"akashpub1addwnpepq2vwqn94su8wz6hmqgyvh7avhmnmmhhs6hdwm0v7qvdpfr0e473hg2q797n","mnemonic":"dismiss punch begin moment slender merge utility help couch tank orbit brand pigeon ridge young quit palm enrich sample small walnut eagle entire risk"
    }
```

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | A meaningful-to-you name for your key. |

**Flags**

| Short | Verbose | Type  | Description |
| :--- | :--- | :--- | :--- | :--- |
|     | --account     |uint32|            Account number for HD derivation
|      |--algo        |string |              Key signing algorithm to generate keys for (default "secp256k1")
|      |--dry-run      |       |      Perform action, but don't add key to local keystore
|      |--hd-path     |string   |         Manual HD Path derivation (overrides BIP44 config)
|  -h, |--help          |        |    help for add
|      |--indent       |          |   Add indent to JSON response
|      |--index       |uint32      |        Address index number for HD derivation
|  -i, |--interactive|              | Interactively prompt user for BIP39 passphrase and mnemonic
|      |--ledger    |                |Store a local reference to a private key on a Ledger device
|      |--multisig |   strings        |  Construct and store a multisig public key (implies --pubkey)
|      |--multisig-threshold |uint   |K out of N required signatures. For use in conjunction with --multisig (default 1)
|      |--no-backup |                |Don't print out seed phrase (if others are watching the terminal)
|      |--nosort   |                 |Keys passed to --multisig are taken in the order they're supplied
|      |--pubkey  |     string        |     Parse a public key in bech32 format and save it to disk
|      |--recover|                   |Provide seed phrase to recover existing key instead of creating

## delete

Delete keys from the Keybase backend.

Note that removing offline or ledger keys will remove
only the public key references stored locally, i.e.
private keys stored in a ledger device cannot be deleted with the CLI.

**Usage**

```text
$ akash keys delete <name> [flags]
```

**Example**

```shell
  $ akash keys delete john 

  Key deleted forever (uh oh!)
```

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | Your key. |

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
| -f, |--force |  Remove the key unconditionally without asking for the passphrase. Deprecated.|
| -h, |--help  |  help for delete |
| -y, |--yes   |  Skip confirmation prompt when deleting offline or ledger key references |

## export

Export a private key from the local keybase in ASCII-armored encrypted format.

**Usage**

```text
$ akash keys export <name> [flags]
```

**Example**

```shell
  $ akash keys export john

  Enter passphrase to decrypt your key:
  Enter passphrase to encrypt the exported key:
  -----BEGIN TENDERMINT PRIVATE KEY-----
  type: secp256k1
  kdf: bcrypt
  salt: 6DC461CE7F38BDE0185D812633C3267B

  D86X4TeWU3YhNKFjf/GevysbxfEoRVGOASR2GiETvSi/cBHBl94MXHORqJWkxYX4
  iz+IEUvcSnQB2RYB0CX2+MVkX8C++s4QVg97diA=
  =Rhmd
  -----END TENDERMINT PRIVATE KEY-----
```

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | Your key. |

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
| -h, |--help |  help for export.|



## import

Import a ASCII armored private key into the local keybase.

**Usage**

```text
$ akash keys import <name> <keyfile> [flags]
```

**Example**

```shell
  TODO
```

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | Your key. |

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
| -h, |--help |  help for import.|


## list

Return a list of all public keys stored by this key manager
along with their associated name and address.

**Usage**

```text
$ akash keys list [flags]
```

**Example**

```shell
  $ akash keys list -o json

  [{
    "name":"john",
    "type":"local",
    "address":"akash1y8608rk8phlze8qtcchxue3cqf2wt8t6tqn8u2","pubkey":"akashpub1addwnpepqfjrg9q8cm3t00fyzfcagv8v600x9c36qvypxq467s9vjf7k0vs7k5xepng"
    },{
      "name":"my-account",
      "type":"local",
      "address":"akash1zwksclwdjkjaa9whc8rdxtxlkca9zwgckksd84","pubkey":"akashpub1addwnpepq02ew0t8fs7qlfu6awxk6xemwvhyg0jt0jw9l9k5my52xr7n0286kqqnhgc"
      },{
        "name":"my-key",
        "type":"local",
        "address":"akash1yk53rkedzrhvjhu2r4rkl4gst6kgmfg08xq4qy","pubkey":"akashpub1addwnpepqdssp4e6k6vy96rjcljwd2f0wheymavw0l2f7qq245x6jps5crrmxzqv2uk"
  }]
```

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
| -h, |--help |  help for list.|
|     | --indent | Add indent to JSON response |
| -n  | --list-names | List names only |


## migrate

Migrate key information from the legacy (db-based) Keybase to the new keyring-based Keybase.
For each key material entry, the command will prompt if the key should be skipped or not. If the key
is not to be skipped, the passphrase must be entered. The key will only be migrated if the passphrase
is correct. Otherwise, the command will exit and migration must be repeated.

It is recommended to run in 'dry-run' mode first to verify all key migration material.

**Usage**

```text
$ akash keys migrate [flags]
```

**Example**

```shell
  TODO
```

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
| -h, |--help |  help for migrate.|
|     | --dry-run | Run migration without actually persisting any changes to the new Keybase |


## mnemonic

Create a bip39 mnemonic, sometimes called a seed phrase, by reading from the system entropy. To pass your own entropy, use --unsafe-entropy

**Usage**

```text
$ akash keys mnemonic [flags]
```
$ akash keys add alice

**Example**

```shell
  $ akash keys mnemonic

  pepper mosquito slab coral tornado taxi raw sheriff service tube brain search neither hire skin put vintage glance purity assume piano invite immune blame
```

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
| -h, |--help |  help for migrate.|
|     | --unsafe-entropy | Prompt the user to supply their own entropy, instead of relying on the system |


## parse

Convert and print to stdout key addresses and fingerprints from
hexadecimal into bech32 cosmos prefixed format and vice versa.

**Usage**

```text
$ akash keys parse <hex-or-bech32-address> [flags]
```

**Example**

```shell
  $ akash keys parse akash1y8608rk8phlze8qtcchxue3cqf2wt8t6tqn8u2

  human: akash
  bytes: 21F4F38EC70DFE2C9C0BC62E6E66380254E59D7A
```

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
| -h, |--help |  help for parse.|
|     | --indent | Indent JSON output |


## show

Return public details of a single local key. If multiple names are
provided, then an ephemeral multisig key will be created under the name "multi"
consisting of all the keys provided by name and multisig threshold.

**Usage**

```text
$ akash keys show [name [name...]] [flags]
```

**Example**

```shell
  $ akash keys show john -o json

  {
    "name":"john",
    "type":"local",
    "address":"akash1y8608rk8phlze8qtcchxue3cqf2wt8t6tqn8u2","pubkey":"akashpub1addwnpepqfjrg9q8cm3t00fyzfcagv8v600x9c36qvypxq467s9vjf7k0vs7k5xepng"
  }
```

**Flags**

| Short | Verbose   | Description |
| :--- | :--- | :--- |
|  -a, |--address                 |  Output the address only (overrides --output)
|      |--bech string             |  The Bech32 prefix encoding for a key (acc|val|cons) (default "acc")
|  -d, |--device                  |  Output the address in a ledger device
|  -h, |--help                    |  help for show
|      |--indent                  |  Add indent to JSON response
|      |--multisig-threshold uint |  K out of N required signatures (default 1)
|  -p, |--pubkey                  |  Output the public key only (overrides --output)
