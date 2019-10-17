# Manage Providers

**Usage**

```text
akash provider [command]
```

**Example**

```text
$ akash provider help

manage provider

Usage:
  akash provider [command]

Available Commands:
  closef      close an open fulfillment
  closel      close an active lease
  create      create a provider
  run         respond to chain events
  status      print status of (given) providers

Flags:
  -h, --help          help for provider
  -n, --node string   node host (default "http://api.akashtest.net:80")

Global Flags:
  -d, --data string   data directory (default "~/.akash")

Use "akash provider [command] --help" for more information about a command.
```

Use `akash provider` to manage provider\(s\)

**Available Commands**

| Command | Description |
| :--- | :--- |
| closef | Close an open fulfillment. Used by providers; not documented here. |
| closel | Close an active lease. Used by providers; not documented here. |
| create | Create a provider. Used by providers; not documented here. |
| run | Respond to chain events. Used by providers; not documented here. |
| status | Print provider details. |

`akash provider` is used to manage providers. This command is intended for providers, so this section will only address commands that are useful for a client creating and managing deployments.

## `status`

Retrieve the attributes and status of one or more providers.

**Usage**

```text
$ akash provider status [<provider-id> ...] [flags]
```

**Example**

```text
$ akash provider status d714ecb330d5a3873bdc88e9fce10dab1a65287fac4fe55c80ac48776fa83276
[
 {
  "Provider": {
   "address": "d714ecb330d5a3873bdc88e9fce10dab1a65287fac4fe55c80ac48776fa83276",
   "owner": "59e018689248c527ed8a755a9c67ec647ce77d28",
   "hostURI": "http://provider.sjc.arrakis.akashtest.net",
   "attributes": [
    {
     "name": "region",
     "value": "sjc"
    }
   ]
  },
  "Status": {
   "code": 200,
   "version": {
    "version": "0.3.3",
    "commit": "4786994cf709e2829aadf64d05b07212e4a8ce28",
    "date": "2018-07-31T20:43:05Z"
   },
   "message": "OK"
  }
 }
```

**Arguments**

None

**Flags**

None
