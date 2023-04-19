# Close Leases Based on Image

## Overview

Below is the suboptimal way of terminating the leases with the selected (unwanted) images (until Akash natively supports that).

Suboptimal because once the deployment gets closed the provider will have to be restarted to recover from the `account sequence mismatch` error. Providers already do it automatically through the K8s's `liveness` probe set to the akash-provider deployment.

The other core problem is that the `image` is **unknown** until the client transfers the SDL to the provider (`tx send-manifest`) which can only happen after provider bids, client accepts the bid.

Follow the steps associated with your Akash Provider install method:

* [Akash Provider Built with Helm Charts](close-leases-based-on-image.md#akash-provider-built-with-helm-charts)
* [Praetor Based Akash Provider Installs](close-leases-based-on-image.md#praetor-based-akash-provider-installs)

## Akash Provider Built with Helm Charts

### Create Script

* Create script file -  `/usr/local/bin/akash-kill-lease.sh` - and populate with the following content:

```
#!/bin/bash
# Files:
# - /etc/cron.d/akash-kill-lease
# - /usr/local/bin/akash-kill-lease.sh

# Uncomment IMAGES to activate this script.
# IMAGES="packetstream/psclient"

# You can provide multiple images, separated by the "|" character as in this example:
# IMAGES="packetstream/psclient|traffmonetizer/cli"

# Quit if no images were specified
test -z $IMAGES && exit 0

kubectl -n lease get manifests -o json | jq --arg md_lid "akash.network/lease.id" -r '.items[] | [(.metadata.labels | .[$md_lid+".owner"], .[$md_lid+".dseq"], .[$md_lid+".gseq"], .[$md_lid+".oseq"]), (.spec.group | .services[].image)] | @tsv' | grep -Ei "$IMAGES" | while read owner dseq gseq oseq image; do kubectl -n akash-services exec -i $(kubectl -n akash-services get pods -l app=akash-provider -o name) -- env AKASH_OWNER=$owner AKASH_DSEQ=$dseq AKASH_GSEQ=$gseq AKASH_OSEQ=$oseq provider-services tx market bid close; done

```

### Make the Script Executable

```
chmod +x /usr/local/bin/akash-kill-lease.sh
```

### Create Cron Job

* Create the Cron Job file - `/etc/cron.d/akash-kill-lease` - with the following content:

```
# Files:
# - /etc/cron.d/akash-kill-lease
# - /usr/local/bin/akash-kill-lease.sh

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
SHELL=/bin/bash

*/5 * * * * root /usr/local/bin/akash-kill-lease.sh
```

## Praetor Based Akash Provider Installs

### Cron Job

* Create cron file - `/etc/cron.d/akash-kill-lease` - and populate with the following content:

```
# Files:
# - /etc/cron.d/akash-kill-lease
# - /usr/local/bin/akash-kill-lease.sh

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
SHELL=/bin/bash

# TODO: change "deathless" with your username that runs akash-provider.service
# $ grep ^User /etc/systemd/system/akash-provider.service
# User=deathless

*/5 * * * * deathless /usr/local/bin/akash-kill-lease.sh
```

### Kill Lease Script

Create script file - `/usr/local/bin/akash-kill-lease.sh` - and populate with the following content:

```
#!/bin/bash
# Files:
# - /etc/cron.d/akash-kill-lease
# - /usr/local/bin/akash-kill-lease.sh

# Optimized for Praetor based provider

# Uncomment IMAGES to activate this script.
IMAGES="packetstream/psclient"

# You can provide multiple images, separated by the "|" character as in this example:
IMAGES="packetstream/psclient|traffmonetizer/cli"

# Quit if no images were specified
test -z $IMAGES && exit 0

export AKASH_KEYRING_BACKEND=test
## TODO: point to your key: check "AKASH_KEYRING_BACKEND=test provider-services keys list" -- you can export your key from the "file" or "os" keyring backend or recover using your mnemonic seed: "AKASH_KEYRING_BACKEND=test provider-services keys add default --recover";  the key password is in ~/.praetor/key-pass.txt file
export AKASH_FROM=default
export AKASH_YES=1

export AKASH_GAS=auto
export AKASH_GAS_PRICES=0.025uakt
export AKASH_GAS_ADJUSTMENT=1.5

export AKASH_BROADCAST_MODE=sync

## TODO: point AKASH_NODE to your RPC node
export AKASH_NODE=http://node.d3akash.cloud:26657
export AKASH_CHAIN_ID=akashnet-2
#export AKASH_CHAIN_ID=$(curl -s -k $AKASH_NODE/status | jq -r '.result.node_info.network')

kubectl -n lease get manifests -o json | jq --arg md_lid "akash.network/lease.id" -r '.items[] | [(.metadata.labels | .[$md_lid+".owner"], .[$md_lid+".dseq"], .[$md_l
id+".gseq"], .[$md_lid+".oseq"]), (.spec.group | .services[].image)] | @tsv' | grep -Ei "$IMAGES" | while read owner dseq gseq oseq image; do
  env AKASH_OWNER=$owner AKASH_DSEQ=$dseq AKASH_GSEQ=$gseq AKASH_OSEQ=$oseq ~/bin/provider-services tx market bid close

  # to address: "Unknown desc = account sequence mismatch, expected 5605, got 5604: incorrect account sequence" error, provider service has to restart
  sudo systemctl restart akash-provider
done
```
