# Install Akash CLI

Select a tab below to view instructions for MacOS, Linux, or compiling from source.

{% tabs %}
{% tab title="MacOS" %}
### MacOS

#### Download Akash Binary

_**NOTE**_ - in the commands below we download the Akash binary for version `0.3.1-rc0` and the `darwin_all`.  If an alternate binary is needed, visit this [GitHub Release](https://github.com/akash-network/provider/releases/tag/v0.3.1-rc0) page and find/replace the link used appropriately

```
cd ~/Downloads

wget https://github.com/akash-network/provider/releases/download/v0.3.1-rc0/provider-services_0.3.1-rc0_darwin_all.zip

unzip provider-services_0.3.1-rc0_darwin_all.zip
```

#### Move the Akash Binary

Move the binary file into a directory included in your path

```
sudo mv provider-services /usr/local/bin
```

#### Verify Akash Installation

Verify the installation by using a simple command to check the Akash version

```
provider-services version
```

#### Expect/Example Output

```
v0.3.1-rc0
```
{% endtab %}

{% tab title="Linux" %}
#### Download Akash Binary

> _**NOTE**_ - in the commands below we download the Akash binary for version `0.3.1-rc0` and a `AMD-64` architecture.  If an alternate binary is needed, visit this [GitHub Release](https://github.com/akash-network/provider/releases/tag/v0.3.1-rc0) page and find/replace the link used appropriately.

```
cd ~

apt install jq -y

apt install unzip -y

wget https://github.com/akash-network/provider/releases/download/v0.3.1-rc0/provider-services_0.3.1-rc0_linux_amd64.zip

unzip provider-services_0.3.1-rc0_linux_amd64.zip

mkdir bin; mv provider-services /root/bin/
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

#### Expected/Example Result

```
v0.3.1-rc0
```
{% endtab %}
{% endtabs %}
