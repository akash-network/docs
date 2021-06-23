# Become a Provider

## Become a provider

### Prerequisits

To run a provider on the Akash network, you need the following

* A wallet funded with at least 50 AKT. 
  * Your wallet must have sufficient funding, as placing a bid on an order on the blockchain requires a 50 AKT deposit.This deposit is fully refunded after the bid is won/lost.
* Compute resources which can host a Kubernetes cluster.
  * The compute resources hosting the Kubernetes cluster should be x86-64 software capable of running a full K8S cluster. The recommended method for provisioning this is using the kubespray project. The cluster must have access to the internet and be accessible from the internet. Hostnames need to be setup for the cluster.
* A machine that can run the Akash provider service.
  * The Akash provider is a service that listens for events on the Akash blockchain and then responds to those events by offering available compute resources in the Kubernetes cluster. The provider also must be accessible from the internet and have a hostname associated with it. This is because when a lease is created, the owner of the lease directly communicates with the provider to provide the final instructions for provisioning resources.
* Access to an Akash blockchain RPC node
  * An RPC node is necessary because the Akash provider does not directly participate in the blockchain network. Instead it uses an external node to manage all interactionwith the blockchain. Any accessible RPC node can be used. Anyone running an Akash provider is strongly reccommended to run a node on the Akash network co-located with the provider. It is _not_ necessary for this node to act as a validator. More than one provider can access the same RPC node. 

### Kubernetes Cluster Setup

The setup of a Kubernetes cluster is the responsibility of whoever sets up a provider on the Akash network. This section of this document provides best practices and ecommendations for setting up a Kubernetes cluster. This document is not a comprehensive guide to operating a Kubernetes cluster.

The general set of actions which must be carried out to setup a Kubernetes cluster for a provider is

1. Clone the Kubespray project
2. Setup your Ansible inventory for the nodes that makeup the cluster
3. Run the provisioning using ansible
4. Retrieve the Kubernetes configuration file so that the cluster can be accessed
5. Add Akash's Custom Resource Definitions to Kubernetes
6. Add the NGINX Ingress controller

At ths point you would be left with a Kubernetes cluster that is ready to be a provider but not yet on the network.

The recommended method for setting up a Kubernetes cluster is to use the [Kubespray](https://github.com/kubernetes-sigs/kubespray) project. This project is a collection of ansible resources for setting up a Kubernetes cluster.

The recommended minimum number of machines is three. One machine hosts the Kubernetes master node & provider, with the other machines hosting the compute nodes. It is possible however to provision a single-machine cluster if you choose to, but this configuration is not recommended.

### Getting kubespray & setup

Get the [latest](https://github.com/kubernetes-sigs/kubespray/releases) official release of Kubespray.

You need a working Ansible installation as well, with the additional Python dependencies specified in the `requirements.txt` document. It is recommended you install this using a Python virtual environment created with the `virtualenv` tool.

```text
virtualenv --python=python3 venv
```

```text
. venv/bin/activate
```

```text
pip3 install -r requirements.txt
```

### Accessing nodes

Ansible works by remotely configuring machines using SSH. Each node in your cluster must be accessible using SSH with an SSH key. The user that you connect remotely as must either be `root` or be capable of escalating privileges to `root` using the `sudo` command.

If you need to copy your SSH private key to the nodes you can do so using the `ssh-copy-id` command on most Linux machines.

### Configuring inventory

The Ansible inventory determines what machines Ansible configures for the Kubernetes cluster. Configuration files for Ansible can be created in multiple formats, but this guide only shows how to define an inventory as a YAML file.

Example single node configuration \(not recommended\)

```text
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

This Ansible inventory file defines a single node file with a host named "mynode". The name "mynode" is the name internally assigned by Ansible to the node. The value specified at the key `ansible_host` under that file defines how the host is reached by Ansible. In this example the node's IP address is used, but a hostname may also be used.

The host is placed into the groups `kube-master`, `etcd`, `kube-node`, and `calico-rr`. All hosts in those groups are then placed into the `k8s-cluster` group. This is similar to a standard configuration for a Kubernetes cluster, but utilizes Calico for networking. Calico is the only networking solution for the Kubernetes cluster that Akash officially supports at this time.

One important detail is the value `cluster_id` which is assigned to all nodes by using the `all` group under `vars` in the YAML file. This value is used by Calico to uniquely identify a set of resources. For a more in depth explanation [see this document](https://hub.docker.com/r/calico/routereflector/).

Example multinode configuration, with a single master

```text
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

The `inventory` directory in the Kubespray project contains an existing directory called `sample`. The `sample` directory should be copied to a name of your choosing. In this guide we assume the `sample` directory has been copied to a directory called `defi`. The YAML file you create should be placed in the `defi` directory.

### Running Kubespray

Assuming you have created an inventory file placed at `inventory/defi/myinventory.yaml`, `cd` back up into `/kubespray/` run Kubespray with the following command:

```text
ansible-playbook -i inventory/defi/myinventory.yaml -b -v --private-key=~/.ssh/id_rsa cluster.yml
```

Note that this will run for some time before it is complete. When complete, thje Kubernetes cluster is up and running.

The `--private-key` option lets Ansible know what SSH private key to authenticate with. If you're using a different private key be sure and update this parameter to point at the location of the private key used to access all hosts in the cluster.

The playbook `cluster.yml` contains all the necessary steps to build the Kubernetes cluster. When the cluster is complete, on the master node there should be a file stored at `/root/.kube/config` which is used to connect to and authenticate with the Kubernetes. Treat this file as a secret password which you do not share. A copy of this file must be used to configure the Akash provider.

#### Known issues

When the above example is followed, Kubespray uses Calico for the networking of Kubernetes.It is an extremely common error to have Kubespray fail on a step where a script named `calioctl.sh` is being run. This appears to be a bug in Kubespray. The only solution known at this time is to wait around 3 minutes then rerun Kubespray. On the second run, Kubespray complete successfully.

#### Dense Provider considerations

Kubernetes uses a networking model that assigns a single IP address to each deployed pod. Each node in a Kubernetes cluster has a range of IP addresses available to it. This means that there is a limit to the number of pods that can be hosted on a single node.

For providers with small nodes, this pods per node limit is not a concern. For providers running nodes with dense compute configurations \(for example, multisocket CPU servers\) this can become a limiting factor to utilization of the node.

To increase the pods per node limit, 3 steps need to be taken:

1. Increase `kube_network_node_prefix` to assign additional IP addresses to a single node.
2. Increase `kube_pods_subnet` to allow more pods in the kubernetes cluster
3. Increase `kube_service_addresses` since more services are expected to be running.

In this example, these values can be configured in `kubespray/inventory/defi/group_vars/k8s_cluster/k8s-cluster.yml`

#### Add the Akash Custom Resource Definition

On the remote machine, navigate to `/root/.kube` and open `config` using your preferred editor. Ensure that the `server` field is populated with the actual server IP \(including port number\), as Kubespray often incorrectly fills it with `127.0.0.1`.

Save this `config` file and copy it to your local machine.

On your local machine,set the `KUBECONFIG` environmental variable to the path of wherever you saved the `config` file from the remote machine.

Akash uses a custom resource definition to store each deployment in Kubernetes. You must load this CRD by downloading the following file:

Files: 1. \[[https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml](https://raw.githubusercontent.com/ovrclk/akash/master/pkg/apis/akash.network/v1/crd.yaml)\]

and applying it by using the `kubectl` command like this

```text
kubectl apply -f ./crd.yaml
```

If you receive an error resembling this

```text
The connection to the server 127.0.0.1:34473 was refused - did you specify the right host or port?
```

then the `KUBECONFIG` variable is likely set incorrectly.

#### Add Networking Configuration

Akash supplies networking configuration which must be applied to the Kubernetes cluster. You must load this file by downloading it and applying it

Files: 1. \[[https://raw.githubusercontent.com/ovrclk/akash/master/\_docs/kustomize/networking/network-policy-default-ns-deny.yaml](https://raw.githubusercontent.com/ovrclk/akash/master/_docs/kustomize/networking/network-policy-default-ns-deny.yaml)\]

You can apply it using the `kubectl` command like this

```text
kubectl apply -f ./network-policy-default-ns-deny.yaml
```

#### Create Kubernetes Ingress Controller

Akash requires that a Kubernetes ingress controller be created. You must load this file by downloading it and applying it

Files: 1. \[[https://raw.githubusercontent.com/ovrclk/akash/master/\_run/ingress-nginx.yaml](https://raw.githubusercontent.com/ovrclk/akash/master/_run/ingress-nginx.yaml)\]

You can apply it using the `kubectl` command like this

```text
kubectl apply -f ./ingress-nginx.yaml
```

Additionally, exactly one node needs to be labeled with a label specific to this ingress declaration:

```text
kubectl label nodes name_of_the_node_goes_here akashRole=ingress
```

This will cause the NGINX ingress to live only on that node. When the wildcard domain is created, it needs to point at this node's IP address.

#### Configure gVisor

Files: 1. \[[https://raw.githubusercontent.com/ovrclk/operations/master/infra/roles/kubernetes-gvisor-class/files/gvisor\_runtime\_class?token=ALSBDWBUBQCMW2TIPDDXZALAV4E3A](https://raw.githubusercontent.com/ovrclk/operations/master/infra/roles/kubernetes-gvisor-class/files/gvisor_runtime_class?token=ALSBDWBUBQCMW2TIPDDXZALAV4E3A)\]

```text
kubectl apply -f ./gvisor-runtime.yaml
```

TODO - convert above to file and move to public Akash repo

## Provider Setup & Configuration

The akash provider is started by running `akash provider run`. The command is configurable entirely through the command line switches. For each command line switch, an environmental variable may also be used instead. This may be preferred for production operations.

For example, the akash provider supports the command line switch `--chain-id`. To convert a command line switch to its environmental variable equivalent, the leading dashes are removed, any other dashes become underscores, all characters are converted to uppercase, and the prefix `AKASH_` is added. So instead of using the command line switch `--chain-id` you would use `AKASH_CHAIN_ID` instead.

### Configuration Considerations

The necessary steps to running an Akash provider are

1. Select a host to run the Akash provider
2. Install the Akash software
3. Create a YAML file with the details of your provider
4. Submit a blockchain transaction to define the provider on chain
5. Submit a blockchain transaction to create a TLS certificate for the provider on chain
6. Configure the Akash provider, including the Kubernetes cluster configuration file 

This section documents configuration you may want to consider customizing when setting up a provider. You may choose to run the Akash provider process via any means you choose. However, Akash has already built Ansible playbooks to help the end user with the steps necessary to run the Akash provider.

### Public Hostname Configuration

There are 3 important public hostnames that a provider must configure.

The **provider host** is the publicly accessible hostname of the provider. This is specified in the configuration file using the `host` key when `akash tx provider create` or `akash tx provider update` is ran. This value is stored on the blockchain. It is used whenever a lease owner needs to communicate directly with the provider for things such as sending a manifest or getting a lease status.

The **cluster ingress host** is the publicly accessible hostname of the Kubernetes cluster. The Kubernetes cluster hosts an Ingress Controller, which is one way that leases in the cluster may be exposed to the outside world. It is currently recommended to [assign](provider.md#Create-Kubernetes-Ingress-Controller) exactly one node in your cluster to the Ingress Controller role.

At this time only HTTP is supported for the Ingress Controller. The hostname should resolve to an IP which directs traffic to the Kubernetes ingress controller IP on your network. This value is specified using the `--deployment-ingress-domain` switch. It is not stored on the blockchain.

The **cluster public hostname** is the publicly accessible hostname of the Kubernetes cluster. Is is not required, nor is it desirable to expose an entire cluster to the internet. The Kubernetes cluster supports a feature called a "NodePort" service. This allows UDP and TCP traffic to be forwarded from the cluster directly to a container on any node in the cluster. By default Kubernetes uses the port range `30000-32767` for this. It is recommended that traffic from the internet only be able to access this port range. This hostname should be configured to resolve to an IP that directs traffic to any of the nodes in the Kubernetes cluster. Kubernetes automatically routes the IP traffic to the correct container. This value is set using the `--cluster-public-hostname` command line switch. It _may_ be different that the **cluster ingress host** but that is not required. This value is not stored on the blockchain.

#### Blocking hostnames

A Kubernetes ingress controller is used to expose HTTP traffic from a lease to the outside world. By default, a lease may request any hostname it wants. This hostname is published in the DNS entries maintained by Kubernetes. It may be desirable to block some domains from being used by a lease.

The command line switch `--deployment-blocked-hostnames` command line switch allows blocking a domain. To block a single domain, specify it exactly. For example `--deployment-blocked-hostnames=akash.network` blocks a lease from requesting a hostname of `akash.network`. To block a domain and all subdomains, precede the hostname with the dot character. For example, `--deployment-blocked-hostnames=.bobsdeficloud.com` would block `bobsdeficloud.com`, `www.bobsdeficloud.com` as well as any other subdomains.

This command line switch may be given any number of times to install mutliple blocks.

### Creating the Provider on the Blockchain

On your remote machine, download the Akash software and import/create your Akash provider key & ensure the assosciated account is adequately funded - details on how to perform said tasks will not be covered in this guide.

#### Configure Akash Provider

```bash
cat <<EOF > provider.yaml
host: https://$PROVIDER_DOMAIN:8443
attributes:
  - key: region
    value: us-west-demo-$(whoami)
EOF
```

Note that `PROVIDER_DOMAIN` is the IP address of the provider remote machine.

You may optionally declare a list of attributes associated with your provider by adding the following information to `provider.yaml`

```text
attributes:
  - key: region
    value: us-west
  - key: host
    value: nameOfYourOrganization
```

#### Create Akash Provider

Register your provider on the Akash Network:

_Replace `--from` flag value with your own_

```bash
akash tx provider create provider.yaml --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --keyring-backend=$AKASH_KEYRING_BACKEND --node=$AKASH_NODE --chain-id=$AKASH_CHAIN_ID --fees 5000uakt
```

#### Create the provider certificate

You must issue a transaction to the blockchain to create a certificate associated with your provider.

`akash tx cert create server $PROVIDER_DOMAIN --chain-id $AKASH_CHAIN_ID --keyring-backend $AKASH_KEYRING_BACKEND --from $AKASH_PROVIDER_KEY --home=$AKASH_HOME --node=$AKASH_NODE --fees 5000uakt`

#### Starting the Provider

**Mandatory provider configuration**

You must configure the following parameters on the command line when starting the provider

* `--home`
* `--chain-id`
* `--keyring-backend` - always set to `test`
* `--fees`

You must set the following parameters, either by using the command line options or the equivalent environmental variable.

* `--kubeconfig`
* `--cluster-k8s` - always set to true
* `--deployment-ingress-domain`
* `--deployment-ingress-static-hosts` - always set to true
* `--cluster-public-hostname`
* `--node`
* `--from`

The provider must have a wallet accessible under the directory specified by `--home` and the key under it specified by the name given to the `--from` parameter must be funded.

Example command to start a provider:

`akash provider run --home $AKASH_HOME --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --keyring-backend=test --from $AKASH_PROVIDER_KEY --fees 5000uakt --kubeconfig $KUBECONFIG --cluster-k8s true --deployment-ingress-domain $PROVIDER_DOMAIN --deployment-ingress-static-hosts true --cluster-public-hostname _optional_ --bid-price-strategy scale --bid-price-cpu-scale 500`

#### Cluster resources overcommit

By default the akash provider asks Kubernetes to reserve _all_ resources on a 1 for 1 basis. Since not all leases are expected to see 100% resource utilization, it makes sense to allow resource overcommit. The following flags may be set

* `--overcommit-pct-cpu` - CPU overcommit percentage
* `--overcommit-pct-mem` - Memory overcommit percentage
* `--overcommit-pct-storage` - Storage overcommit percentage

Any flag not specified is equivalent to having a value of zero.

Each flag is a positive integer number. The number given is the percentage of overcommit to consider when making bids. Specifying `--overcommit-pct-cpu=50` tells the Akash provider to commit 50% more CPU than is actuall available.

#### Bid pricing

When the akash provider considers bidding on a lease, it must compute a bid price. The bid pricing strategy is set with the switch `--bid-price-strategy`. By default the `scale` strategy is used. This strategy computes bid prices using a set of linear scales based off the requested CPU, memory, and storage.

When the `scale` strategy is used, at least one of the following command line switches must be set:

* `--bid-price-memory-scale` - uakt per megabyte
* `--bid-price-cpu-scale` - uakt per millicpu 
* `--bid-price-storage` -  uakt per megabyte 
* `--bid-price-endpoint-scale` - uakt per endpoint

The actual bid price is computed by multiplying the configured scale with the resources requested in the lease.

The `scale` strategy is not likely to be sufficient for all providers. Since some providers may want to use complex pricing strategies \(or not bid at all\) the `script` strategy can be used. The `script` strategy invokes an external script to compute a bid price and uses that as a result. The following command line switches are used to control the script invocation:

* `--bid-price-script-path` - Path to executable script, must be set
* `--bid-price-script-process-limit` - Maximum number of concurrent executions of the script
* `--bid-price-script-process-timeout` - Timeout on bid pricing script configuration

The pricing configuration script must be a file on the same filesystem as the provider and be marked as executable. The script must do the following:

1. Read all available data from standard in
2. Parse this data as JSON
3. Uses the data to compute the bid price
4. Write the bid price to standard out as a single JSON number

The data written to standard out has the following structure

```text
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

This data is a list of JSON objects, with each JSON object in the list describing a resource that is fulfilled as part of the lease.

The following units are used:

* `"memory"` - bytes
* `"cpu"` - millicpu
* `"storage"` - bytes

The key `"endpoint-quantity"` defines the number of exposed ports the lease is requesting. The `"count"` key is used when more than 1 instance of an identical set of resources is being bid on.

The pricing script may make any computations it needs to compute a price. The price is written to standard out as a JSON number. This should be a whole number, representing the bid quantity in `uakt`. If the decision is made that no bid should be placed, the number 0 should be used for the bid quantity.

**Example script**

The following script shows an example implementation of a bid pricing script using the Python 3 language.

```text
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

