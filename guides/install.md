# Akash Client Installation

The Akash Suite is composed of a full node `akashd` and the client `akashctl`. The full node `akashd` is the tendermint-based blockchain node that implements the decentralized exchange. `akashctl` is the client used to access the exchange and network in general.

{% tabs %} {% tab title="MacOS" %}

### MacOS

The simplest way to install is by using [homebrew](https://brew.sh). If you do not have homebrew, you can install homebrew using:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install `akashctl` client and `akashd` daemon using homebrew:

```shell
brew install ovrclk/tap/akash
```

Once installed, verify the installation by running `akashctl version`.


Alternatively, you can manually download the [binaries](https://github.com/ovrclk/akash/releases/download/v0.6.1/akash_0.7.4_darwin_amd64.zip) from the [releases page](https://github.com/ovrclk/akash/releases). The latest release is `0.7.4` as of writing of this document, please make sure to check the releases page for the latest version. The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on MacOS.

{% endtab %} {% tab title="Linux" %}

### Linux

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.6.1/akash_0.7.4_linux_amd64.zip) from the [release page](https://github.com/ovrclk/akash/releases).

Alternatively, install the latest version via [`godownloader`](https://github.com/goreleaser/godownloader) with:

```sh
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh
```

The final step is to make sure that the akash binaries are available in your shell `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

{% endtab %} {% endtabs %}

### Others \(From Source\)

Installing Akash suite from source

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ git checkout v0.7.4
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.14+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Most golang libraries will be installed via `go mod`, however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akashctl` and `akashd` using `make install`
