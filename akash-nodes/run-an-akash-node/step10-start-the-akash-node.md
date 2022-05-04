# STEP10 - Start the Akash Node



## Start the Node

In this section we will create a script and a related service to start the node.  The service will additionally ensure that the node is restarted following reboots.

### Create Script to Start Node

* Create a script to start the Akash Node

```
cat <<EOF | tee /usr/local/bin/start-node.sh
#!/usr/bin/env bash

/root/bin/akash start
EOF
```

* Make the script an executable

```
chmod 744 /usr/local/bin/start-node.sh
```

### Create Related Service

```
cat > /etc/systemd/system/akash-node.service << 'EOF'
[Unit]
Description=Akash Node
After=network.target

[Service]
User=root
Group=root
ExecStart=/usr/local/bin/start-node.sh
KillSignal=SIGINT
Restart=on-failure
RestartSec=15
StartLimitInterval=200
StartLimitBurst=10
#LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

### Start the Service

```
systemctl daemon-reload
systemctl start akash-node
systemctl enable akash-node
```

## Check the Status of the Node

* At first the node will show it is catching up.&#x20;
* Eventually the node will show the height of the latest block.&#x20;
*   The latest block number can be found on the [Mintscan](https://www.mintscan.io/akash) website for comparison.

    ```
    akash status
    ```
