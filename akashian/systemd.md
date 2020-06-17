# Running Akashd in systemd

First ensure that you have [created and configured your full node for the proper testnet](./join-the-testnet.md) and you haven't run `akashd start` yet.

Start by creating the following file and open it in your choice of editor:

```bash
sudo nano /etc/systemd/system/akashd.service
```
Fill that file with the following valid `toml`:

> NOTE: the `User`, `ExecStart` and `WorkingDirectory` will depend on your system and how you installed `akashd`.

```toml
# /etc/systemd/system/akashd.service
[Unit]
Description=Cosmos akash Node
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=/home/ubuntu/go/bin/akashd start --pruning="everything"
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

Once that is done you will need to reload the systemd daemon and start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl start akashd

# then you can view the logs using journalctl
journalctl -u akashd -f
```
