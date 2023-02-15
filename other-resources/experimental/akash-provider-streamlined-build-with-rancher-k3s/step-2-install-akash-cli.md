# STEP 2 - Install Akash CLI

## Install the Akash CLI for Provider Use

```
cd ~

apt install jq -y

apt install unzip -y

curl -sfL https://raw.githubusercontent.com/akash-network/provider/main/install.sh | bash

echo 'alias provider-services="/root/bin/provider-services"' >> ~/.bashrc

. ~/.bashrc
```

## Verify Akash CLI Install

```
provider-services version
```

#### Expected/Example Output

```
provider-services version

v0.2.1
```
