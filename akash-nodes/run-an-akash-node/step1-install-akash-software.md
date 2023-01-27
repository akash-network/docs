# STEP1 - Install Akash Software



In this step we will cover Installing the Akash software on a Linux server.  We will use an Ubuntu server for our examples.  The commands may need to be changed slightly depending on your Linux distribution.

## Download and Install Akash

### Install Latest Stable Akash Version

```
cd ~

apt install jq -y

apt install unzip -y

AKASH_VERSION="$(curl -s https://api.github.com/repos/akash-network/node/releases/latest | jq -r '.tag_name')"

curl -sfL curl -sfL https://raw.githubusercontent.com/akash-network/provider/main/install.sh | bash | bash -s -- "$AKASH_VERSION"
```
