# Manage keys

**Usage**

```shell
$  akash key [command]
```

**Example**

```shell
Manage keys

Usage:
  akash key [command]

Available Commands:
  create      create a new key locally
  import      import a private key
  list        list all the keys stored locally
  recover     recover a key using recovery codes
  remove      remove key locally
  show        display a key

Flags:
  -h, --help   help for key

Global Flags:
  -d, --data string   data directory (default "/Users/gosuri/.akash")
  -m, --mode string   output mode (interactive|shell|json) (default "interactive")

Use "akash key [command] --help" for more information about a command.
```

Use `akash key` to create and manage your keys.

**Available Commands**

| Command | Description |
| :--- | :--- |
| create  | create a new key locally
| import  | import a private key
| list    | list all the keys stored locally
| recover | recover a key using recovery codes
| remove  | remove key locally
| show    | display a key

## create

**Usage**

```text
$ akash key create <name> [flags]
```

**Example**

Create a key with the name 'greg':

```shell
$ akash key create greg

Successfully created key for 'greg'
===================================

Public Key:    	f4e03226c054b1adafaa2739bad720c095500a49
Recovery Codes:	figure share industry canal...
```

Create a new key to use in the Akash Network. A key links to an Akash account and is used to authenticate to the network.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | A meaningful-to-you name for your key. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -t | --type | \(ed25519\|secp256k1\|ledger\) | N | Type of key \(default "ed25519"\). |

## import

**Usage**

```text
$ akash key import <name> [flags]
```

**Example**

Import a private key with the name 'alice':

```shell
$ akash key import alice ./private.key
(info)  [key] key imported

Import Key
==========

Name: 	alice
Path: 	./private.key
```

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | A meaningful-to-you name for your key. |
| path | string | Y | Path to the private key |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -t | --type | \(ed25519\|secp256k1\|ledger\) | N | Type of key \(default "ed25519"\). |

## list

**Usage**

```shell
$ akash key list [flags]
```

**Example**

```shell
$ akash key list

Key List
========

Name  	Public Key (Address)
----  	--------------------

alice 	c7597a64f203a881f6b3944dae849846a2c6b2bf
master	981cf6d142550449c315b2e6fbd5424fb1230c56
```

List all your local keys.

**Arguments**

None

**Flags**

None

## remove

**Usage**

```text
$ akash key remove <name> [flags]
```

**Example**

```shell
$ akash key remove alice
(info)  [key] key removed

Remove Key
==========

Name: 	alice
```

Remove the key value belonging to a key name.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | Name of the key to remove. |

**Flags**

None

## recover

**Usage**

```shell
$ akash key recover <name> <recovery-codes> [flags]
```

**Example**

Recover a key with the name _alice_:
```shell
$ akash key recover alice soldier stuff bullet february bargain cage elegant intact across man obvious coral salmon scan use demise device purse fire length museum slow opera essence

(info)  Successfully recovered key, stored locally as 'alice'

Recover Key
===========

Name:                 	alice
Public Key (Address): 	c7597a64f203a881f6b3944dae849846a2c6b2bf
```

Recover a key using the recovery code generated during key creation and store it locally. For help with creating a key, see 'akash help key create'

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | Name of the key to remove. |
| recovery-codes | list | Y | list of recovery code. |

**Flags**

None

## show

**Usage**

```shell
$ akash key show <name> [flags]
```

**Example**

```shell
$ akash key show alice
Display Key
===========

Name:                 	alice
Public Key (Address): 	c7597a64f203a881f6b3944dae849846a2c6b2bf
```

Show the key value belonging to a key name.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| name | string | Y | Name of the key to display. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| | --public| bool | N | Display public key
| | --private| bool | N | Display private key
