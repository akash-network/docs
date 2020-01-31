# Getting Started 

## Dependencies

- [Keybase](https://keybase.io/download) - Keybase is used as the git hosting platform for `terraform` state and other sensitive data.
- [Packet](https://www.packet.com/developers/api/) - Packet is the hosting provider that is being used. DISCO can also be used with any of the cloud providers [listed here](https://www.terraform.io/docs/providers/index.html). You will need both a `PACKET_API_TOKEN` and a `PACKET_PROJECT_ID`.
- [Cloudflare](https://cloudflare.com) - Cloudflare is the DNS provider used for the demo deployment. DISCO can also be used with any of the cloud providers [listed here](https://www.terraform.io/docs/providers/index.html). You will need a `CLOUDFLARE_API_TOKEN` with `Zone.Zone` and `Zone.DNS` permissions.
- [Terraform](https://www.terraform.io) - `terraform` is used to provision resources on Packet. 
- [`k3sup`](https://github.com/alexellis/k3sup#download-k3sup-tldr) - A great utility for `kubectl config` management! Also makes installing and spinning up a kubernets cluster easy!
- [Helm](https://helm.sh/docs/using_helm/#installing-helm) - The package manager for Kubernetes.  Helm is the best way to find, share, and use software built for Kubernetes.c


## Clone the project

```
$ git clone https://github.com/ovrclk/disco
```

## Setting up keybase git repository

DISCO is built using Keybase Teams. When creating systems like this, there is senstitive local data that is needed to create the clusters and the applications on top of them. Keybase teams offers an easy programatic way to securely version, store and share this data.

For example, lets say we're building a `dentacoin-dev` stack at team `akashnet`. We would first need to create the keybase git repository for it:

```shell
$ keybase git create dentacoin-dev --team akashnet

Repo created! You can clone it with:
  git clone keybase://team/akashnet/devnet
Or add it as a remote to an existing repo with:
  git remote add origin keybase://team/akashnet/devnet
```

Also, make sure to set these variables in the `env.mk` file at the root of the repository. For the above example it should look like:

```shell
cat > env.mk <<EOF
TEAM=akashnet
STACK=dentacoin-dev
EOF
```

The `tfstate` and other sensitive information is stored in a database that holds data specific to this `STACK`. To setup the database then run the following:

### Setup the directory structure:

```shell
make db-setup
```

The db setup task will create the below folder stucture:

```text
data
└── db
    ├── config
    │   ├── nodes
    │   └── providers
    ├── index
    └── keys
```

Define the machine and stack dns zones:

```shell
echo mydomain.net > data/db/index/STACK_ZONE
echo mydomain1.net > data/db/index/MACHINE_ZONE
```

> NOTE: Both of the above domains can be the same one.

Next its time to [create some infrastructure using `layer0`](layer0/README.md)!
