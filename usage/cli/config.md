# Manage Config

Create or query an application CLI configuration file

**Usage**

```shell
$  akash config <key> [value] [flags]
```

**Example**

```shell

$ akash config chain-id my-chain

configuration saved to /home/ubuntu/.akash/config/config.toml

```

```text
Flags:
      --get    print configuration value or its default if unset
  -h, --help   help for config


Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

```