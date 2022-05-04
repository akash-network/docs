# Upgrade to Akash 3.0

This document provides guidelines for node operators upgrading from Akash Mainnet from v2 to v3.

## Upgrade Details

### Akash Network v0.16.1

* [Release Notes](https://github.com/ovrclk/akash/releases/tag/v0.16.1)

### Akash Mainnet

* Upgrade Height: `[TBD]`

## Upgrade Guidelines

### Update Go

The latest version of Go (`1.17`) is required. For more information, see [Go](https://golang.org).

### Option 1: Using Cosmovisor

The following instructions assume the `akash` and `cosmovisor` binaries are already installed and `cosmovisor` is set up as a systemd service. The section that follows will detail the install/configuration of Cosmovisor. If additional details are necessary, visit [Start a node with Cosmovisor](../cosmovisor.md) for instructions on how to install and set up the binaries.

**Cosmovisor 1.0 is required.**

#### Configure Cosmovisor

_Note: The following steps are not required if Cosmovisor v1.0 is already installed and configured to your preferred settings._

To install `cosmovisor`, run the following command:

```bash
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0
```

Check to ensure the installation was successful:

```bash
DAEMON_NAME=akash DAEMON_HOME=~/.akash cosmovisor version
```

Update `cosmovisor` systemd service file and make sure the environment variables are set to the appropriate values (the following example includes the recommended settings):

```bash
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

Cosmovisor can be configured to automatically download upgrade binaries. It is recommended that validators do not use the auto-download option and that the upgrade binary is compiled and placed manually. If you would like to enable the auto-download option, update the following environment variable in the systemd configuration file:

```bash
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=true"
```

Cosmovisor will automatically create a backup of the data directory at the time of the upgrade and before the migration. If you would like to disable the auto-backup, update the following environment variable in the systemd configuration file:

```bash
Environment="UNSAFE_SKIP_BACKUP=true"
```

Move the file to the systemd directory:

```bash
sudo mv cosmovisor.service /lib/systemd/system/cosmovisor.service
```

Restart `cosmovisor` to ensure the environment variables have been updated:

```bash
sudo systemctl stop cosmovisor
sudo systemctl daemon-reload
sudo systemctl start cosmovisor
```

Check the status of the `cosmovisor` service:

```bash
sudo systemctl status cosmovisor
```

Enable cosmovisor to start automatically when the machine reboots:

```bash
sudo systemctl enable cosmovisor.service
```

#### Prepare Upgrade Binary

_Note: The following steps are not required if the auto-download option was enabled._

Either download the upgrade binary (`v0.16.1`) or build it from source:

```bash
git clone https://github.com/ovrclk/akash
cd akash
git fetch --all
git checkout v0.16.1
make akash
```

Create the folder for the upgrade binary (`v0.16.1`) and copy the `akash` binary into the folder. This next step assumes that the `akash` binary was built from source and stored in the `current` (i.e., akash) directory:

```bash
mkdir -p $HOME/.akash/cosmovisor/upgrades/akash_v0.15.0_cosmos_v0.44.x/bin
cp ./.cache/bin $HOME/.akash/cosmovisor/upgrades/akash_v0.15.0_cosmos_v0.44.x/bin
```

At the proposed block height, `cosmovisor` will automatically stop the current binary (`v0.14.0`), set the upgrade binary as the new current binary (`v0.16.1`), and then restart the node.

### Option 2: Without Cosmovisor

Using Cosmovisor to perform the upgrade is not mandatory. Node operators also have the option to manually update the `akash` binary at the time of the upgrade. Doing it before the upgrade height will stop the node.

When the chain halts at the proposed upgrade height, stop the current process running `akash`.

Either download the upgrade binary (`v0.16.1`) or build it from source:

```bash
cd akash
git fetch --all
git checkout v0.16.1
make install
```

Ensure the `akash` binary has been updated:

```bash
akash version
```

Restart the process running `akash`.
