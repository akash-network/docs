# Transfer Tokens

> **Usage**

```text
akash send <amount> <to-account> [flags]
```

> **Example**

```text
$ akash send 1.1 35c055f1fa38cb1864e484a1d733a58bbffb1156 -k alpha
Sent 1.1 tokens to 35c055f1fa38cb1864e484a1d733a58bbffb1156 in block 61049
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
