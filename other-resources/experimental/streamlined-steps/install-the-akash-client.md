# Install the Akash CLI



The below set of steps downloads the environment for easier setup. For advanced usage, check the [Akash CLI Detailed Steps](../../../guides/cli/detailed-steps/) guide.

## Download Source Code

* Download the Akash Client source code into your home directory and within a subdirectory named `demo`

```
cd ~

git clone https://github.com/ovrclk/demo-env.git demo

cd demo
```

## Install Akash CLI Client

```
apt install make

apt-get install unzip

make install

mv ./bin/provider-services ./
```

### Add Akash Install Location to User’s Path

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

Add the following directory, which is the Akash install location, to PATH. In this example the active user is root. If logged in as another username, replace /root with your current/home directory.

```
/root/demo
```

View within the text editor following the update:

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/demo"
```

#### Make the Path Active in the Current Session

```
. /etc/environment
```

### Verify Installation

* Issue the following command to verify successful install of the Akash CLI client
* Output that displays the installed Akash client version equals a successful install and verification

```
provider-services version
```

#### Expected/Example Result

```
provider-services version

v0.1.0
```
