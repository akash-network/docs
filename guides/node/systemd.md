# Running `akash` under Systemd

First ensure that you have [created and configured your full node for the proper testnet](./guides/node/validator.md) and you haven't run `akash start` yet.

Start by creating the following file and open it in your choice of editor:

```bash
sudo nano /etc/systemd/system/akash.service
```

Fill that file with the following valid `toml`:

> NOTE: the `User`, `ExecStart` and `WorkingDirectory` will depend on your system and how you installed `akash`.

```toml
# /etc/systemd/system/akash.service
[Unit]
Description=Cosmos akash Node
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=/home/ubuntu/go/bin/akash start
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

Once that is done you will need to reload the systemd daemon and start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl start akash

# then you can view the logs using journalctl
journalctl -u akash -f
```
