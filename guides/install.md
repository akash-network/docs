---
description: >-
  This guides walks through installing and using all components of Akash
  software.
---

# Install Akash

The software to run  **Akash** and the command-line client used to interact with them are all currently distributed in the `akash`application.

The `akash` command is used to run all components of the Akash Network, including:

* Network node and API servers
* Provider services
* Client interface

## Shell Variables

Shell variables will be used throughout these guides to make the instructions so that the commands can be used verbatim. The beginning of each guide will give a list of variables used and how to populate them.

Because of this, it is important to type the commands into a terminal where the variables have been defined. Closing or changing terminals will mean that you have to re-define the variable.

| Name | Description |
| :--- | :--- |
| `AKASH_NET` | Akash network configuration base URL.  |
| `AKASH_VERSION` | Akash version to install for your network.   |
| `AKASH_CHAINID` | Chain ID of the network for [Inter-blockchain Connections](../reference/akashnet-relayer.md). |

#### Network

First configure the base URL \(`$AKASH_NET`\) for the Akash Network; copy and paste the command below:

```bash
AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
```

#### Version

Next configure the version of the Akash Network `AKASH_VERSION`; copy and paste the command below:

```bash
AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
```

#### Chain ID

The akash CLI will recogonize `AKASH_CHAIN_ID` environment variable when exported to the shell. 

```bash
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
```

## Installing Akash

Select a tab below to view instructions for MacOS, Linux, or compiling from source.

{% tabs %}
{% tab title="MacOS" %}
## MacOS

The simplest way to install is by using [homebrew](https://brew.sh). If you do not have homebrew, you can install homebrew using:

```text
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install `akash` daemon using homebrew:

```text
brew tap ovrclk/tap
brew install akash
brew link akash --force
```

Once installed, verify the installation by running `akash version`. 
{% endtab %}

{% tab title="Linux" %}
## Linux

Download the archive for your system from the [release page](https://github.com/ovrclk/akash/releases), extract it, and install the `akash` binary into your path.

Alternatively, install the latest version via [`godownloader`](https://github.com/goreleaser/godownloader) with:

```bash
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```

The final step is to make sure that the akash binaries are available in your shell `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.
{% endtab %}

{% tab title="Source" %}
## Source

Installing Akash suite from source

```text
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ git checkout "v$AKASH_VERSION"
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.16+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Once you have the dependencies properly setup, download and build `akash` using `make install`
{% endtab %}
{% endtabs %}

