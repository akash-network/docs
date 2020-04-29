# Manage Config

Create or query an application CLI configuration file

**Usage**

```shell
$  akashctl config <key> [value] [flags]
```

**Example**

```shell

$ akashctl config chain-id my-chain

configuration saved to /home/ubuntu/.akashctl/config/config.toml

```

```text
Flags:
      --get    print configuration value or its default if unset
  -h, --help   help for config


Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akashctl")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

```
