# Install Akash CLI

Select a tab below to view instructions for MacOS, Linux, or compiling from source.

{% tabs %}
{% tab title="MacOS" %}
### MacOS

The simplest way to install Akash is using Homebrew using:

```
brew untap ovrclk/tap
brew tap akash-network/tap
brew install akash-provider-services
```

If you do not have homebrew, follow the below steps for installing the Akash Binary.

#### Download Akash Binary

These commands will retrieve the latest, stable version of the Akash software, store the version in a local variable, and install that version.

```
cd ~/Downloads

#NOTE that this download may take several minutes to complete
curl -sfL https://raw.githubusercontent.com/akash-network/provider/main/install.sh | bash
```

#### Move the Akash Binary

Move the binary file into a directory included in your path

```
sudo mv ./bin/provider-services /usr/local/bin
```

#### Verify Akash Installation

Verify the installation by using a simple command to check the Akash version

```
provider-services version
```

Expect/Example Output

```
v0.2.0
```
{% endtab %}

{% tab title="Linux" %}
The simplest way to install Akash is using Homebrew using:

```
brew untap ovrclk/tap
brew tap akash-network/tap
brew install akash-provider-services
```

If you do not have homebrew, follow the below steps for installing the Akash Binary.

#### Download Akash Binary

These commands will retrieve the latest, stable version of the Akash software\_**,**\_ store the version in a local variable, and install that version.

```
cd ~

apt install jq -y

apt install unzip -y

curl -sfL https://raw.githubusercontent.com/akash-network/provider/main/install.sh | bash
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
. /etc/environment
```

### Verify Akash Install

Display the version of Akash software installed. This confirms the software installed and that the new user path addition worked.

```
provider-services version
```

Expected/Example Result

```
v0.2.0
```
{% endtab %}

{% tab title="Source" %}
### From Source

Installing Akash suite from source:

```
$ go get -d github.com/akash-network/provider
$ cd $GOPATH/src/github.com/akash-network/provider
$ AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
$ AKASH_VERSION="$(curl -s https://api.github.com/repos/akash-network/provider/releases/latest | jq -r '.tag_name')"
$ git checkout "v$AKASH_VERSION"
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.16+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Once you have the dependencies properly setup, download and build `akash` using `make install`
{% endtab %}
{% endtabs %}
