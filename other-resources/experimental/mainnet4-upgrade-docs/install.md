---
description: >-
  This guide walks through installing and using all components of Akash
  software.
---

# Install Akash

The software to run **Akash** and the command-line client used to interact with them are all distributed in the `akash`application. The `` `provider-services` `` commands are used to interact with the Akash Network.

Visit this [guide](detailed-steps/) for a through walk through of the Akash CLI, environment variable declarations, and an example deployment onto the Akash network.

Select a tab below to view instructions for MacOS, Linux, or compiling from source.

{% tabs %}
{% tab title="MacOS" %}
## MacOS

### 1. Download and Install Akash

* These commands will retrieve the latest, stable version of the Akash software, store the version in a local variable, and install that version.

```
cd ~/Downloads

AKASH_VERSION="$(curl -s https://api.github.com/repos/ovrclk/provider-services/releases/latest | jq -r '.tag_name')"

curl -sfL https://raw.githubusercontent.com/ovrclk/provider-services/main/godownloader.sh | bash -s -- "$AKASH_VERSION"
```

### 2. Move the Akash Binary

* Move the binary file into a directory included in your path

```
sudo mv ./bin/provider-services /usr/local/bin
```

### 3. Verify Akash Installation

* Verify the installation by using a simple command to check the Akash version

```
provider-services version
```

* Expect/Example Output

```
provider-services version

v0.1.0
```
{% endtab %}

{% tab title="Linux" %}
### Linux

Download the archive for your system from the [release page](https://github.com/ovrclk/akash/releases), extract it, and install the `akash` binary into your path.

**GoDownloader**

Alternatively, install the latest version via [`godownloader`](https://github.com/goreleaser/godownloader) First, configure the version of the Akash Network `AKASH_VERSION`as a shell variable in your terminal:

```bash
# install necessary utilities
apt install jq -y
apt install unzip -y

# configure akash version
AKASH_VERSION="$(curl -s https://api.github.com/repos/ovrclk/provider-services/releases/latest | jq -r '.tag_name')"

# install akash 
curl -sfL https://raw.githubusercontent.com/ovrclk/provider-services/main/godownloader.sh | bash -s -- "$AKASH_VERSION"
```

The final step is to make sure that the akash binaries are available in your shell `PATH`. [This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.
{% endtab %}

{% tab title="Source" %}
### Source

Installing Akash suite from source

```
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
