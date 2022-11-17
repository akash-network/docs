# Part 1. Install Akash CLI

Select a tab below to view instructions for MacOS, Linux, or compiling from source.

{% tabs %}
{% tab title="MacOS" %}
### MacOS

The simplest way to install Akash is using Homebrew using:

```
brew install ovrclk/tap/akash
```

If you do not have homebrew, follow the below steps for installing the Akash Binary.

#### Download Akash Binary

These commands will retrieve the latest, stable version of the Akash software, store the version in a local variable, and install that version.

```
cd ~/Downloads

AKASH_VERSION="$(curl -s "https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt")"

curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```

#### Move the Akash Binary

Move the binary file into a directory included in your path

```
sudo mv ./bin/akash /usr/local/bin
```

#### Verify Akash Installation

Verify the installation by using a simple command to check the Akash version

```
akash version
```

Expect/Example Output

```
v0.16.3
```
{% endtab %}

{% tab title="Linux" %}
### Linux

The simplest way to install Akash is using Homebrew using:

```
brew install ovrclk/tap/akash
```

If you do not have homebrew, follow the below steps for installing the Akash Binary.

#### Download Akash Binary

These commands will retrieve the latest, stable version of the Akash software\_**,**\_ store the version in a local variable, and install that version.

```
cd ~

AKASH_VERSION="$(curl -s "https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt")"

curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```

#### Add Akash Install Location to User’s Path

Add the software’s install location to the user’s path for easy use of Akash commands.

**NOTE:** Below we provide the steps to add the Akash install directory to a user’s path on a Linux Ubuntu server. Please take a look at a guide for your operating system and how to add a directory to a user’s path.

Open the user’s path file in an editor:

```
vi /etc/environment
```

View within text editor prior to the update:

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
```

Add the following directory, which is the Akash install location, to `PATH`. In this example the active user is root. If logged in as another username, replace /root with your current/home directory.

```
/root/bin
```

View within the text editor following the update:

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/bin"
```

### Make the Path Active in the Current Session

```
source /etc/environment
```

### Verify Akash Install

Display the version of Akash software installed. This confirms the software installed and that the new user path addition worked.

```
akash version
```

Expected/Example Result

```
v0.16.3
```
{% endtab %}

{% tab title="Source" %}
### From Source

Installing Akash suite from source:

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
