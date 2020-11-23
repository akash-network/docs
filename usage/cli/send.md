# Transfer Tokens

> **Usage**

```text
akash send <amount> <to-account> [flags]
```

> **Example**

```text
$ akash send 1.1 3d79b93370b8283d9b7399607efc29f589bba6f7 -k alpha

Send Token(s)
=============

From:   	259d3831b178ef71545e992da9ea7b580032c9dd
To:     	3d79b93370b8283d9b7399607efc29f589bba6f7
Amount: 	1,100,000
Block:  	1,498,809
Hash:   	f01084f53fef96f1a8aebc5464ae49faa4c8a614a6e15542914bc1c55c0b4ed0

```

> In the example above, the amount is given in AKSH. You may also specify the amount in microAKSH \(AKSH \* 10^-6\) using the `u` unit suffix \(e.g. `100u` for 100 microAKSH\).

Use `akash send` to send tokens from one account to another.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| amount | float | Y | The amount of tokens to send. |
| to-account | string | Y | The key value for the recipient account. |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -k | --key | string | Y | Name of one of your keys, for authentication. Tokens will be sent from this account. |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
|  | --nonce | uint | N | Nonce. |

**Global Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -d | --data | string | N | data directory (default "~/.akash") |
| -m | --mode | string | N | output mode (interactive|shell|json) (default "interactive") |
