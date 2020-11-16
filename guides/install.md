# Akash Client Installation

The Akash Suite was originally composed of a full node `akashd` and the client `akashctl`. The full node `akashd` was the tendermint-based blockchain node that implemented the decentralized exchange. `akashctl` was the client used to access the exchange and network in general.

The two binaries listed above have since been consoladated a single binary called `akash`.


### MacOS

The simplest way to install is by using [homebrew](https://brew.sh). If you do not have homebrew, you can install homebrew using:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install `akash` using homebrew:

```shell
brew install ovrclk/tap/akash
```

Once installed, verify the installation by running `akash version`.


Alternatively, you can manually download the [binaries](https://github.com/ovrclk/akash/releases/download/v0.8.2/akash_0.8.2_darwin_amd64.zip) from the [releases page](https://github.com/ovrclk/akash/releases). The latest release is `0.8.2` as of writing of this document, please make sure to check the releases page for the latest version. The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the `PATH` on MacOS.


### Linux

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.8.2/akash_0.8.2_linux_amd64.zip) from the [release page](https://github.com/ovrclk/akash/releases).

Alternatively, install the latest version via [`godownloader`](https://github.com/goreleaser/godownloader) with:

```sh
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh
```

The final step is to add `GOPATH`, `GOBIN` and both to `PATH`:

```bash
echo "" >> ~/.profile
echo 'export GOPATH=$HOME/go' >> ~/.profile
echo 'export GOBIN=$GOPATH/bin' >> ~/.profile
echo 'export PATH=$PATH:/usr/local/go/bin:$GOBIN' >> ~/.profile
source ~/.profile
```

### Others \(From Source\)

Installing Akash suite from source:

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
```
Replace <version.txt> below with the `akash` version used in the [latest testnet](https://github.com/ovrclk/net/tree/master/latest)
```
$ MAINNET=false git checkout <version.txt>
$ make deps-install
$ make install
```

Once installed, verify the installation by running `akash version`.

Akash is developed and tested with [golang 1.15+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Most golang libraries will be installed via `go mod`, however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akash` using `make install`
