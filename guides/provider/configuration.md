# Provider configuration

The akash provider is started by running `akash provider run`. The command is configurable
entirely through the command line switches. For each command line switch, an environmental
variable may also be used instead. This may be preferred for production operations.

For example, the akash provider supports the command line switch `--chain-id`. To convert a command
line switch to its environmental variable equivalent, the leading dashes are removed, any other
dashes become underscores, all characters are converted to uppercase, and the prefix `AKASH_` is added.
So instead of using the command line switch `--chain-id` you would use `AKASH_CHAIN_ID` instead.

## Configuration considerations

This section documents configuration you may want to consider customizing when setting up a provider.

### Cluster resources overcommit

By default the akash provider asks Kubernetes to reserve _all_ resources on a 1 for 1 basis.
Since not all leases are expected to see 100% resource utilization, it makes sense to allow
resource overcommit. The following flags may be set

* `--overcommit-pct-cpu` - CPU overcommit percentage
* `--overcommit-pct-mem` - Memory overcommit percentage
* `--overcommit-pct-storage` - Storage overcommit percentage

Any flag not specified is equivalent to having a value of zero.

Each flag is a positive integer number. The number given is the percentage of overcommit to consider
when making bids. Specifying `--overcommit-pct-cpu=50` tells the akash provider to commit 50% more CPU 
than is actuall available.

### Bid pricing

When the akash provider considers bidding on a lease, it must compute a bid price. The bid pricing
strategy is set with the switch `--bid-price-strategy`. By default the `scale` strategy is used. This 
strategy computes bid prices using a set of linear scales based off the requested CPU, memory, and storage.

When the `scale` strategy is used, at least one of the following command line switches must be set

* `--bid-price-memory-scale` - uakt per megabyte
* `--bid-price-cpu-scale` - uakt per millicpu 
* `--bid-price-storage` -  uakt per megabyte 
* `--bid-price-endpoint-scale` - uakt per endpoint

The actual bid price is computed by multiplying the configured scale with the resources requested in the lease.

The `scale` strategy is not likely to be sufficient for all providers. Since some providers may want to 
use complex pricing strategies (or not bid at all) the `script` strategy can be used. The `script`
strategy invokes an external script to compute a bid price and uses that as a result. The following
command line switches are used to control the script invocation

* `--bid-price-script-path` - Path to executable script, must be set
* `--bid-price-script-process-limit` - Maximum number of concurrent executions of the script
* `--bid-price-script-process-timeout` - Timeout on bid pricing script configuration

The pricing configuration script must be a file on the same filesystem as the provider and be marked
as executable. The script must do the following

1. Read all available data from standard in
2. Parse this data as JSON
3. Uses the data to compute the bid price
4. Write the bid price to standard out as a single JSON number

The data written to standard out has the following structure

```

[
    {
    "memory": 2048
    "cpu": 333
    "storage": 100
    "count": 1
    "endpoint-quantity": 1
    }
]
```

This data is a list of JSON objects, with each JSON object in the list describing a resource that is
fulfilled as part of the lease.

The following units are used

* `"memory"` - bytes
* `"cpu"` - millicpu
* `"storage"` - bytes

The key `"endpoint-quantity"` defines the number of exposed ports the lease is requesting. The `"count"`
key is used when more than 1 instance of an identical set of resources is being bid on.

The pricing script may make any computations it needs to compute a price. The price is written to standard
out as a JSON number. This should be a whole number, representing the bid quantity in `uakt`. If the 
decision is made that no bid should be placed, the number 0 should be used for the bid quantity.

#### Example script

The following script shows an example implementation of a bid pricing script using the Python 3 language.

```
#!/usr/bin/env python3

import math
import sys
import json

# Read JSON from standard input
order_data = json.load(sys.stdin)

bid = True # Flag determining whether or not to bid
bid_price = 0 # Total bid price
memory_cutoff = 10000 # Limit for the amount of memory any one container can request

uakt_per_memory_megabyte = 5
uakt_per_storage_megabyte = 3
uakt_per_millicpu = 15

MEGA = 1024 ** 2

for group in order_data:
  # Compute total cost for this container
  group_count = group['count']
  price = group['cpu'] * uakt_per_millicpu + group['memory']/MEGA * uakt_per_memory_megabyte + group['storage']/MEGA * uakt_per_storage_megabyte
  bid_price += group['count'] * price
  
  # Disable bidding if there is a large container
  if group['memory'] > memory_cutoff:
    bid = False
  
bid_price = math.ceil(bid_price) # Convert bid to an integer  
  
# A result must always be written to standard out
if bid:
    json.dump(bid_price, sys.stdout)
else:
    # Indicate not to bid
    json.dump(0, sys.stdout)
  

```

### Public hostname configuration

There are 3 important public hostnames that a provider must configure.

The **provider host** is the publicly accessible hostname of the provider. This is specified in the configuration
file using the `host` key when `akash tx provider create` or `akash tx provider update` is ran. This value
is stored on the blockchain. It is used whenever a lease owner needs to communicate directly when the provider
for things such as sending a manifest or getting a lease status.

The **cluster ingress host** is the publicly accessible hostname of the Kubernetes cluster. The Kubernetes cluster
hosts an Ingress Controller, which is one way that leases in the cluster may be exposed to the outside world.
At this time only HTTP is supported for the Ingress Controller. The hostname should resolve to an IP 
which directs traffic to the Kubernetes ingress controller IP on your network. This value is specified using the 
`--deployment-ingress-domain` switch. It is not stored on the blockchain.

The **cluster public hostname** is the publicly accessible hostname of the Kubernetes cluster. Is is not
required, nor is it desirable to expose an entire cluster to the internet. The Kubernetes cluster
supports a feature called a "NodePort" service. This allows UDP and TCP traffic to be forwarded from the
cluster directly to a container on any node in the cluster. By default Kubernetes uses the port range
`30000-32767` for this. It is recommended that traffic from the internet only be able to access this port range.
This hostname should be configured to resolve to an IP that directs traffic to any of the nodes in the Kubernetes cluster. 
Kubernetes automatically routes the IP traffic to the correct container. This value is set using the 
`--cluster-public-hostname` command line  switch. It _may_ be different that the **cluster ingress host** but 
that is not required. This value is not stored on the blockchain.

### Blocking hostnames

A Kubernetes ingress controller is used to expose HTTP traffic from a lease to the outside world. By default,
a lease may request any hostname it wants. This hostname is published in the DNS entries maintained by
Kubernetes. It may be desirable to block some domains from being used by a lease. 

The command line switch `--deployment-blocked-hostnames` command line switch allows blocking a domain. To
block a single domain, specify it exactly. For example `--deployment-blocked-hostnames=akash.network` blocks
a lease from requesting a hostname of `akash.network`. To block a domain and all subdomains, precede the hostname
with the dot character. For example, `--deployment-blocked-hostnames=.bobsdeficloud.com` would block
`bobsdeficloud.com`, `www.bobsdeficloud.com` as well as any other subdomains.

This command line switch may be given any number of times to install mutliple blocks.