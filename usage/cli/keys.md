# Manage Keys

Keys allows you to manage your local keystore for Akash. These keys may be in any format supported by go-crypto and can be used by light-clients, full nodes, or any other application that needs to sign with a private key.

**Usage**

```shell
$  akash key [command]
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
      --home string       directory for config and data (default "/Users/gosuri/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

Use "akash keys [command] --help" for more information about a command.
```

**Available Commands**

| Command | Description |
| :--- | :--- |
|  add       |  Add an encrypted private key (either newly generated or recovered), encrypt it, and save to disk |
|  delete    |  Delete the given keys |
|  export    |  Export private keys |
|  import    |  Import private keys into the local keybase |
|  list      |  List all keys |
|  migrate   |  Migrate keys from the legacy (db-based) Keybase |
|  mnemonic  |  Compute the bip39 mnemonic for some input entropy |
|  parse     |  Parse address from hex to bech32 and vice versa |
|  show      |  Show key info for the given name |


## `add`

Derive a new private key and encrypt to disk.
Optionally specify a BIP39 mnemonic, a BIP39 passphrase to further secure the mnemonic, and a bip32 HD path to derive a specific account. 
The key will be stored under the given name and encrypted with the given password.
The only input that is required is the encryption password.

If run with `-i`, it will prompt the user for BIP44 path, BIP39 mnemonic, and passphrase.
The flag `--recover` allows one to recover a key from a seed passphrase.
If run with `--dry-run`, a key would be generated (or recovered) but not stored to the
local keystore.

Use the `--pubkey` flag to add arbitrary public keys to the keystore for constructing
multisig transactions.

You can add a multisig key by passing the list of key names you want the public
key to be composed of to the `--multisig` flag and the minimum number of signatures
required through `--multisig-threshold`. The keys are sorted by address, unless
the flag `--nosort` is set.

**Usage**

```shell
akash keys add <name> [flags]
```

**Example**

```
$ akash keys add alice

- name: alice
  type: local
  address: akash1k74uuwnw8hlsk0dchpcamn833d6hfk4u56ymaf
  pubkey: akashpub1addwnpepqtf7r8vqu4x4nyg68hnj83tqfrrw5m3fkt7zzj2jysepnezh8x36wum8qnt
  mnemonic: ""
  threshold: 0
  pubkeys: []


**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

must wish dog episode column dust dizzy fashion acid grid blush foam road inhale security ten unfold loan gather elite hip easy useless kit
```

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | Name of the key |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
|      |  --account            | uint32 | N | Account number for HD derivation |
|      |  --algo               | string | N | Key signing algorithm to generate keys for (default "secp256k1") |
|      |  --dry-run            | bool   | N | Perform action, but don't add key to local keystore |
|      |  --hd-path            | string | N | Manual HD Path derivation (overrides BIP44 config) |
|      |  --indent             | bool   | N | Add indent to JSON response |
|      |  --index              | uint32 | N | Address index number for HD derivation |
|   -i |  --interactive        | bool   | N | Interactively prompt user for BIP39 passphrase and mnemonic |
|      |  --ledger             | bool   | N | Store a local reference to a private key on a Ledger device |
|      |  --multisig           | strings| N | Construct and store a multisig public key (implies --pubkey) |
|      |  --multisig-threshold | uint   | N | K out of N required signatures. For use in conjunction with --multisig (default 1) |
|      |  --no-backup          | bool   | N | Don't print out seed phrase (if others are watching the terminal) |
|      |  --nosort             | bool   | N | Keys passed to --multisig are taken in the order they're supplied |
|      |  --pubkey             | string | N | Parse a public key in bech32 format and save it to disk |
|      |  --recover            | bool   | N | Provide seed phrase to recover existing key instead of creating |
