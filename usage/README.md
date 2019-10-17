---
title: Akash Documentation

toc_footers:
  - <a href='http://akash.network/testnet'>Sign Up for Akash TestNet</a>
  - <a href='http://akash.network'><div class="badge-white-128-80 white"></div></a>

includes:
  - usage
  - testnet

search: true
---

# Introduction

The Akash Network is a decentralized protocol for provisioning, scaling, and securing cloud workloads. Using Akash, companies (Providers) make their spare server capacity available for containerized deployments by any developer (Tenants). Tenants benefit from access to a a low-cost, decentralized, geographically distributed cloud infrastructure platform whose conventions are very similar to any other cloud provider. Providers benefit by monetizing the idle compute capacity in their on-prem and colocated datacenters.

The Network contains two major functional elements:

* **Marketplace**: A blockchain-based system that allocates capacity on provider servers to tenants wishing to deploy to them, and transfers payments from tenant to provider in the native Akash (AKSH) token.
* **Deployment**: A Kubernetes-based system that provisions pods on provider servers and deploys/orchestrates Tenant containers within them.

The permission-less marketplace provides a censorship-resistant procurement mechanism for highly scalable and secure container based deployments for base resources which are compute, memory, bandwidth, and storage.

### See a mistake? Open a pull request

[https://github.com/ovrclk/docs](https://github.com/ovrclk/docs)

# Installation

The Akash Suite is composed of a full node `akashd` and the client `akash`.  The full node (`akashd`) is the (tendermint-based) blockchain node that implements the decentralized exchange. `akash` is the client used to access the exchange and network in general.

## MacOS

> Install Homebrew

```shell
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

> Install `akash` client and `akashd` daemon using homebrew

```shell
$ brew install ovrclk/tap/akash
```

The simplest way to install is by using [homebrew](https://brew.sh). Install `akash` client by running `brew install ovrclk/tap/akash`. Once installed, verify the installation by running `akash version`.

Alternatively, you can manually download the [binaries](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_darwin_amd64.tar.gz) from the [releases page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version. The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on MacOS.

## Linux

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_linux_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the terraform binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

## Windows

Download the [windows archive](https://github.com/ovrclk/akash/releases/download/v0.3.6/akash_0.3.6_windows_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.3.6` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows) contains instructions for setting the PATH on Windows.

## Others (From Source)

> Installing akash suite from source

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.8+](https://golang.org/).  Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Additional requirements are:

* [glide](https://github.com/Masterminds/glide): Golang library management.

For development environments, requirements include:

* [protocol buffers](https://developers.google.com/protocol-buffers/): Protobuf compiler.

Most golang libraries will be packaged in the local `vendor/` directory via [glide](https://github.com/Masterminds/glide), however the following packages will
 be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [gogoprotobuf](https://github.com/gogo/protobuf): Golang protobuf compiler plugin.
* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akash` and `akashd` using `make install`
