
## Install Cosmovisor

[Cosmovisor](https://github.com/cosmos/cosmos-sdk/tree/master/cosmovisor) is a process manager for running application binaries. Using Cosmovisor is not required but recommended for node operators who would like to automate the upgrade process.

To install `cosmovisor`, run the following command:

```bash
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0
```

Check to ensure the installation was successful:

```bash
cosmovisor version
```

## Set Genesis Binary

Create the folder for the genesis binary and copy the `akash` binary:

```bash
mkdir -p $HOME/.akash/cosmovisor/genesis/bin
cp $GOBIN/akash $HOME/.akash/cosmovisor/genesis/bin
```

## Cosmovisor Service

The next step will be to configure `cosmovisor` as a `systemd` service. For more information about the environment variables used to configure `cosmovisor`, see [Cosmovisor](https://github.com/cosmos/cosmos-sdk/tree/master/cosmovisor).

Create the `cosmovisor.service` file:

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

Move the file to the systemd directory:

```bash
sudo mv cosmovisor.service /lib/systemd/system/cosmovisor.service
```

Make sure to stop your akash services if they are running already:

```bash
sudo systemctl stop akash
sudo systemctl stop cosmovisor
```

Reload systemctl and start `cosmovisor`:

```bash
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