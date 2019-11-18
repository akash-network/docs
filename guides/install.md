# Akash Client Installation

The Akash Suite is composed of a full node `akashd` and the client `akash`. The full node `akashd` is the tendermint-based blockchain node that implements the decentralized exchange. `akash` is the client used to access the exchange and network in general.

{% tabs %} {% tab title="MacOS" %}

### MacOS

The simplest way to install is by using [homebrew](https://brew.sh). If you do not have homebrew, you can install homebrew using:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install `akash` client and `akashd` daemon using homebrew:

```shell
brew install ovrclk/tap/akash
```

Once installed, verify the installation by running `akash version`.


Alternatively, you can manually download the [binaries](https://github.com/ovrclk/akash/releases/download/v0.5.2/akash_0.5.2_darwin_amd64.zip) from the [releases page](https://github.com/ovrclk/akash/releases). The latest release is `0.5.2` as of writing of this document, please make sure to check the releases page for the latest version. The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on MacOS.

{% endtab %} {% tab title="Linux" %}

### Linux

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.5.2/akash_0.5.2_linux_amd64.zip) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.5.2` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the terraform binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

{% endtab %} {% tab title="Windows" %}

### Windows

Download the [windows archive](https://github.com/ovrclk/akash/releases/download/v0.5.2/akash_0.5.2_windows_amd64.tar.gz) from the [release page](https://github.com/ovrclk/akash/releases). The latest release is `0.5.2` as of writing of this document, please make sure to check the releases page for the latest version.

The final step is to make sure that the akash binary is available on the `PATH`.[This page](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows) contains instructions for setting the PATH on Windows.

{% endtab %} {% endtabs %}

### Others \(From Source\)

Installing Akash suite from source

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.13.1+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

For development environments, requirements include:

* [protocol buffers](https://developers.google.com/protocol-buffers/): Protobuf compiler.

Most golang libraries will be packaged in the local `vendor/` directory via [glide](https://github.com/Masterminds/glide), however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [gogoprotobuf](https://github.com/gogo/protobuf): Golang protobuf compiler plugin.
* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akash` and `akashd` using `make install`
