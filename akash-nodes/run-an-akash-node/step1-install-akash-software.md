# STEP1 - Install Akash Software



In this step we will cover Installing the Akash software on a Linux server.  We will use an Ubuntu server for our examples.  The commands may need to be changed slightly depending on your Linux distribution.

## Download and Install Akash

### Install the Linux unzip utility if needed

```
sudo apt install zip
```

### Install Latest Stable Akash Version

```
cd ~

AKASH_VERSION="$(curl -s "https://raw.githubusercontent.com/ovrclk/net/master/mainnet/version.txt")"

curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- "v$AKASH_VERSION"
```
