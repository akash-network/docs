# Install Akash

The `akash` command is used to run all components of the Akash Network, including:

* Network node and API servers
* Provider services
* Client interface

There are a number of ways to install it, depending on your operating system.

## Variables Required

| Name | Description |
| :--- | :--- |
| `AKASH_VERSION` | Akash version to install for your network.  See [here](version.md). |

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

Once installed, verify the installation by running `akash version`. Compare that with the version for the network you plan on connecting to:

```bash
curl -s "$AKASH_NET/version.txt"
```
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

