# Install Akash Suite

The Akash Suite is composed of a full node `akashd` and the client `akashctl`. The full node `akashd` is the tendermint-based blockchain node that implements the decentralized exchange. `akashctl` is the client used to access the exchange and network in general.

{% tabs %}
{% tab title="MacOS" %}
## MacOS

The simplest way to install is by using [homebrew](https://brew.sh). If you do not have homebrew, you can install homebrew using:

```text
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install `akashctl` client and `akashd` daemon using homebrew:

```text
brew install ovrclk/tap/akash
```

Once installed, verify the installation by running `akashctl version`.

Alternatively, you can manually download the binaries from the [releases page](https://github.com/ovrclk/akash/releases). The latest stable release is `0.8.2` as of writing of this document, please make sure to check the releases page for the latest version. The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on MacOS.
{% endtab %}

{% tab title="Linux" %}
## Linux

Download the linux archive from the [release page](https://github.com/ovrclk/akash/releases).

Alternatively, install the latest version via [`godownloader`](https://github.com/goreleaser/godownloader) with:

```bash
curl -sSfL https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- v0.8.2
```

The final step is to make sure that the akash binaries are available in your shell `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.
{% endtab %}
{% endtabs %}

## Others \(From Source\)

Installing Akash suite from source

```text
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ MAINNET=true git checkout v0.8.2
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.15+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Most golang libraries will be installed via `go mod`, however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akashctl` and `akashd` using `make install`

