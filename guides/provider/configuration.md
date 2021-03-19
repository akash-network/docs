# Running a provider

To run a provider on the Akash network, you need the following

1. A wallet with some initial amount of AKT in it 
1. Compute resources which can host a Kubernetes cluster
1. A machine that can run the akash provider service
1. Access to an Akash blockchain RPC node

Your wallet needs an initial amount of AKT in it, because placing a bid on an
order on the blockchain requires a deposit. This deposit is fully refundable.

The compute resources hosting the Kubernetes cluster should be x86-64 software
capable of running a full K8S cluster. The recommended method for provisioning this 
is using the kubespray project. The cluster must have access to the internet and be
accessible from the internet. Hostnames need to be setup for the cluster.

The Akash provider is a service that listens for events on the Akash blockchain
and then responds to those events by offering available compute resources in the Kubernetes
cluster. The provider also must be accessible from the internet and have a hostname
associated with it. This is because when a lease is created, the owner of the lease
directly communicates with the provider to provide the final instructions for 
provisioning resources. 

An RPC node is necessary because the Akash provider does not directly participate 
in the blockchain network. Instead it uses an external node to manage all interaction
with the blockchain. Any accessible RPC can be used.
Anyone running an Akash provider is strongly reccommended to run a 
node on the Akash network co-located with the provider. It is _not_ necessary for this
node to act as a validator. More than one provider can access the same RPC node. 

# Kubernetes cluster setup

The setup of a Kubernetes cluster is the responsibility of whoever sets up a provider
on the Akash network. This section of this document provides best practices and 
recommendations for setting up a Kubernetes cluster.  This document is not a 
comprehensive guide to operating a Kubernetes cluster. 

The recommended method for setting up a Kubernetes cluster is to use the 
[kubespray](https://github.com/kubernetes-sigs/kubespray) project. This project
is a collection of ansible resources for setting up a Kubernetes cluster. 

The recommended minimum number of machines is three. One machine hosts the 
Kubernetes master node & provider, with the other machines hosting the compute
nodes. It is possible however to provision a single-machine cluster if you
choose to, but Akash does not recommend this configuration.

## Getting kubespray & setup

You should get the latest official release of Kubespray from here 

https://github.com/kubernetes-sigs/kubespray/releases

You need a working ansible installation as well, with the additional Python
dependencies specified in the `requirements.txt` document. We recommend you
install this using a Python virtual environment created with the
`virtualenv` tool.

## Accessing nodes

Ansible works by remotely configuring machines using SSH. Each node in your cluster
must be accessible using SSH with a SSH key. The user that you connect remotely as
must either be `root` or be capable of escalating privileges to `root` using 
the `sudo` command. 

If you need to copy your SSH private key to the nodes you can do so using
the `ssh-copy-id` command on most Linux machines.

## Configuring inventory

The ansible inventory determines what machines Ansible configures for the Kubernetes 
cluster. Configuration files for Ansible can be created in multiple formats, but this guide
only shows how to define an inventory as a YAML file.

Example single node configuration (not recommended)

```
all:
  vars:
    cluster_id: "1.0.0.1"
    ansible_user: root
  hosts:
    mynode:
      ansible_host: 24.1.2.3
  children:
    kube-master:
      hosts:
        mynode:
    etcd:
      hosts:
        mynode:
    kube-node:
      hosts:
        mynode:
    calico-rr:
      hosts:
        mynode:

    k8s-cluster:
      children:
        kube-master:
        kube-node:
        calico-rr:

```

This ansible inventory file defines a single node file with a host named "mynode". The name
mynode is the name internally assigned by ansible to the node. The value specified at the key
`ansible_host` under that file defines how the host is reached by Ansible. In this example the nodes
IP address is used, but a hostname may also be used.

The host is placed into the groups `kube-master`, `etcd`, `kube-node`, and `calico-rr`.
All hosts in those groups are then placed into the `k8s-cluster` group. This is similar
to a standard configuration for a Kubernetes cluster, but utilizes Calico for networking.
Calico is the only networking solution for the Kubernetes cluster that Akash officially
supports at this time.

One important details is the value `cluster_id` which is assigned to all nodes
by using the `all` group under `vars` in the YAML file. This value is used by
Calico to uniquely identify a set of resources. For a more in depth explanation
[see this document](https://hub.docker.com/r/calico/routereflector/).

Example multinode configuration, with a single master

```
all:
  vars:
    cluster_id: "1.0.0.1"
    ansible_user: root
  hosts:
    mymaster:
      ansible_host: 24.0.0.1
    mynode0:
      ansible_host: 24.0.0.2
    mynode1:
      ansible_host: 24.0.0.3
  children:
    kube-master:
      hosts:
        mymaster:
    etcd:
      hosts:
        mynode0:
        mynode1:
    kube-node:
      hosts:
        mynode0:
        mynode1:
    calico-rr:
      hosts:
        mymaster:
        mynode0:
        mynode1:

    k8s-cluster:
      children:
        kube-master:
        kube-node:
        calico-rr:

```

This examples defines 3 separate hosts `mymaster`, `mynode0`, and `mynode1`. 

The `inventory` directory in the kubespray project contains an existing
directory called `sample`. The `sample` directory should be copied to a name of your choosing.
In this guide we assume the `sample` directory has been copied to a directory called `defi`. 
The YAML file you create should be placed in the `defi` directory.

## Running kubespray 

Assuming you have created an inventory file placed at `inventory/defi/myinventory.yaml`
you can run kubespray with the following command

```
ansible-playbook -i inventory/defi/myinventory.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

The `--private-key` option lets Ansible know what SSH private key to authenticate with. If you're
using a different private key be sure and update this parameter to point at the location
of the private key used to access all hosts in the cluster.

The playbook `cluster.yml` contains all the necessary steps to build the Kubernetes cluster.
When the cluster is complete, on the master node there should be a file stored at 
`/root/.kube/config` which is used to connect to and authenticate with the Kubernetes. Treat
this file as a secret password which you do not share. A copy of this file must be used
to configure the Akash provider. 

### Known issues

When the above example is followed Kubespray uses Calico for the networking of Kubernetes.
It is an extremely common error to have Kubespray fail on a step where a script named
`calioctl.sh` is being run. This appears to be a bug in Kubespray. The only solution known
at this time is to wait around 3 minutes then rerun Kubespray. On the second run, Kubespray
complete successfully. 

### Dense Provider considerations

Kubernetes uses a networking model that assigns a single IP address to each deployed pod. Each node
in a Kubernetes cluster has a range of IP addresses available to it. This means that there is a limit
to the number of pods that can be hosted on a single node.

For providers with small nodes, this pods per node limit is not a concern. For providers running
nodes with dense compute configurations (for example, multisocket CPU servers) this can become
a limiting factor to utilization of the node.

To increase the pods per node limit, 3 steps need to be taken

1. Increase `kube_network_node_prefix` to assign additional IP addresses to a single node.
2. Increase `kube_pods_subnet` to allow more pods in the kubernetes cluster
3. Increase `kube_service_addresses` since more services are expected to be running.

These values are configured in the [example configuration here](akash-main/inventory/akash-provider-sample/group_vars/k8s-cluster/k8s-cluster.yml)

# Provider setup & configuration

The akash provider is started by running `akash provider run`. The command is configurable
entirely through the command line switches. For each command line switch, an environmental
variable may also be used instead. This may be preferred for production operations.

For example, the akash provider supports the command line switch `--chain-id`. To convert a command
line switch to its environmental variable equivalent, the leading dashes are removed, any other
dashes become underscores, all characters are converted to uppercase, and the prefix `AKASH_` is added.
So instead of using the command line switch `--chain-id` you would use `AKASH_CHAIN_ID` instead.

## Configuration considerations

The necessary steps to running an Akash provider are

1. Select a host to run the Akash provider
1. Install the Akash software
1. Create a YAML file with the details of your provider
1. Submit a blockchain transaction to define the provider on chain
1. Submit a blockchain transaction to create a TLS certificate for the provider on chain
1. Configure the akash provider, including the Kubernetes cluster configuration file 

This section documents configuration you may want to consider customizing when setting up a provider.
You may choose to run the Akash provider process via any means you choose. However, Akash has already
built Ansible playbooks to help the end user with the steps necessary to run the Akash provider.

## Using Ansible 

The Ansible project used to configure Akash providers is part of the `ovrclk/operations` project and is stored
under the `infra` directory 

https://github.com/ovrclk/operations/tree/master/infra

The first step is to define an inventory file with the host that the Akash provider runs on. The inventory 
below defines the minimum set of values needed to configure an Akash provider.

```
---
all:
  vars:
    akash_chain_id: mainnet-2
    akash_local_home: /home/myusre/akash_mainnet_wallet
    ansible_user: root

  hosts:
    myprovider: 
      akash_node: "tcp://24.1.0.1:26657"
      ansible_host: myprovider.awesome.defi
      akash_provider_name: "myprovider"
      akash_local_provider_kube_config_path: "/home/myuser/myprovider_kube_config"
      akash_ingress_domain: kubepub.myprovider.awesome.defi
      akash_cluster_public_hostname: kube.myprovider.awesome.defi      

  children:

    providers:
      hosts:
        myprovider:
```

Variables shared amongst all providers

* `akash_chain_id` - the blockchain ID, `mainnet-2` for Akash main net
* `akash_local_home` - the directory containing a keyring for the Akash wallet to use for creating the provider

Host variables for a provider

* `akash_node` - the RPC node the Akash provider uses
* `ansible_host` - The hostname of the Akash provider
* `akash_provider_name` - The name of the key from the wallet to use for creating the Akash provider
* `akash_local_provider_kube_config_path` - The path to the kubernetes configuration file on the local machine
* `akash_ingress_domain` - The wildcard domain that resolves to the kubernetes cluster
* `akash_cluster_public_hostname` - The public domain of the kubernetes cluster

The key named `akash_provider_name` should already exist in your wallet and should have AKT transferred to it.

If you run your Akash provider on the same host as the Kubernetes master then the values `akash_cluster_public_hostname`
and `ansible_host` should be identical. 

You need to set the following environmental variables before running Ansible.

* `BINARY_DIR` - the local directory containing the Akash executable.

In some steps, Akash is run locally since there is no need to use the remote host to get information from the blockchain
and submit transactions.

Assuming you have placed your inventory file in the `inventory` directory of the operations project you can run 
ansible like this to provision the provider.

```
ansible-playbook -i inventory/mydefprovider.yaml -b -v --private-key=~/.ssh/id_rsa akash-providers.yaml
```

Note that during provisioning the keys from your wallet and the Kubernetes configuration are copied to the remote host.

-- TODO -- graphic showing where each hostname points

### Checking that the provider has started 

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