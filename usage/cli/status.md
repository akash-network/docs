# Get remote node status

> **Usage**

```text
akash status [flags]
```

> **Example**

```text
$ akash status

Status
======

Node Version:        	0.32.6
Latest Block Height: 	1499248
Latest Block Hash:   	451944008e7ce8a1e23fb64107eab377f60adb3f321ecf6ff9c9114e4e5a693b
Last Block Created:  	3 seconds ago

```

> In the example above, the details are about node version and latest block on the network

Use `akash status` to check status of a node (default "http://api.akashtest.net:80").

**Arguments**

No arguments.

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |

**Global Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -d | --data | string | N | data directory (default "~/.akash") |
| -m | --mode | string | N | output mode (interactive|shell|json) (default "interactive") |
