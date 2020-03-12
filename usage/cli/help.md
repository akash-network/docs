# Manage Help

Help provides help for any command in the application.
Simply type akash help [path to command] for full details.

**Usage**

```shell
$  akash help [command] [flags]
```

**Example**

```shell

$ akash help config

Create or query an application CLI configuration file

Usage:
  akash config <key> [value] [flags]

Flags:
      --get    print configuration value or its default if unset
  -h, --help   help for config

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/vitwit/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

```

```text
Flags:
  -h, --help   help for help


Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/vitwit/.akash")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

```