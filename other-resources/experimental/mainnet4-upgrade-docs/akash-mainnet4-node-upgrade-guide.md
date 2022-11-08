---
description: >-
  This document provides guidelines for node operators upgrading to version
  0.18.0
---

# Akash Mainnet4 Node Upgrade Guide

## Upgrade Details

### Akash Network v0.18.0

* [Release Notes](https://github.com/ovrclk/akash/releases/tag/v0.18.0)

### Akash Mainnet

* Upgrade Height: `8526250`

## Upgrade Guidelines

### Update Go

The latest version of Go (1.19) is required. For more information, see [Go](https://golang.org/).

## Option 1: Upgrade Using Cosmovisor

The following instructions assume the `akash` and `cosmovisor` binaries are already installed and cosmovisor is set up as a systemd service.&#x20;

The section that follows will detail the install/configuration of Cosmovisor. If additional details are necessary, visit [Start a node with Cosmovisor ](https://github.com/ovrclk/docs/blob/anil/v3-instructions/guides/node/cosmovisor.md)for instructions on how to install and set up the binaries.

> _**NOTE**_ - Cosmovisor 1.0 is required

### Configure Cosmovisor

> _**Note**_: The following steps are not required if Cosmovisor v1.0 is already installed and configured to your preferred settings.

To install `cosmovisor` by running the following command:

```
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0
```

Check to ensure the installation was successful:

```
DAEMON_NAME=akash DAEMON_HOME=~/.akash cosmovisor version
```

Update `cosmovisor` systemd service file and make sure the environment variables are set to the appropriate values (the following example includes the recommended settings):

```
echo "[Unit]
Description=Cosmovisor daemon
After=network-online.target
[Service]
Environment="DAEMON_NAME=akash"
Environment="DAEMON_HOME=${HOME}/.akash"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="UNSAFE_SKIP_BACKUP=false"
User=${USER}
ExecStart=${GOBIN}/cosmovisor start
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
" >cosmovisor.service
```

Cosmovisor can be configured to automatically download upgrade binaries. It is recommended that validators do not use the auto-download option and that the upgrade binary is compiled and placed manually.&#x20;

If you would like to enable the auto-download option, update the following environment variable in the systemd configuration file:

```
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=true"
```

Cosmovisor will automatically create a backup of the data directory at the time of the upgrade and before the migration.&#x20;

If you would like to disable the auto-backup, update the following environment variable in the systemd configuration file:

```
Environment="UNSAFE_SKIP_BACKUP=true"
```

Move the file to the systemd directory:

```
sudo mv cosmovisor.service /lib/systemd/system/cosmovisor.service
```

Restart `cosmovisor` to ensure the environment variables have been updated:

```
sudo systemctl stop cosmovisor
sudo systemctl daemon-reload
sudo systemctl start cosmovisor
```

Check the status of the `cosmovisor` service:

```
sudo systemctl status cosmovisor
```

Enable `cosmovisor` to start automatically when the machine reboots:

```
sudo systemctl enable cosmovisor.service
```

### Prepare Upgrade Binary

> _**Note**_: The following steps are not required if the auto-download option was enabled.

Either download the Akash binary (v0.18.0) or build it from source:

```
git clone https://github.com/ovrclk/akash
cd akash
git fetch --all
git checkout v0.18.0
make akash
```

Create the folder for the upgrade binary (v0.18.0) and copy the akash binary into the folder.&#x20;

This next step assumes that the akash binary was built from source and stored in the current (i.e., akash) directory:

```
mkdir -p $HOME/.akash/cosmovisor/upgrades/akash_v0.18.0_cosmos_v0.44.x/bin

cp ./.cache/bin $HOME/.akash/cosmovisor/upgrades/akash_v0.18.0_cosmos_v0.44.x/bin
```

At the proposed block height, `cosmovisor` will automatically stop the current binary (v0.16.X), set the upgrade binary as the new current binary (v0.18.0), and then restart the node.\


## Option 2: Upgrade Without Cosmovisor

Using Cosmovisor to perform the upgrade is not mandatory.&#x20;

Node operators also have the option to manually update the `akash` binary at the time of the upgrade. Doing it before the upgrade height will stop the node.

When the chain halts at the proposed upgrade height, stop the current process running `akash`.

Either download the upgrade binary (v0.18.0) or build it from source:

```
cd akash
git fetch --all
git checkout v0.18.0
make install
```

Ensure the `akash` binary has been updated:

```
akash version
```

Restart the process running `akash`.
