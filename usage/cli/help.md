# Manage Help

Help provides help for any command in the application.
Simply type akashctl help [path to command] for full details.

**Usage**

```shell
$  akashctl help [command] [flags]
```

**Example**

```shell

$ akashctl help config

Create or query an application CLI configuration file

Usage:
  akashctl config <key> [value] [flags]

Flags:
      --get    print configuration value or its default if unset
  -h, --help   help for config

Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akashctl")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

```

```text
Flags:
  -h, --help   help for help


Global Flags:
  -e, --encoding string   Binary encoding (hex|b64|btc) (default "hex")
      --home string       directory for config and data (default "/home/ubuntu/.akashctl")
  -o, --output string     Output format (text|json) (default "text")
      --trace             print out full stack trace on errors

```