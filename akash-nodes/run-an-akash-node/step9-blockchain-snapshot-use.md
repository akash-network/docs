# STEP9 - Blockchain Snapshot Use

We could let our node catch up to the current block but this would take a very long time. Instead we will download a snapshot of the blockchain before starting our node.

**NOTE** - at the time of this writing the snapshot is 200GB and could take some time to pull down.

### Remove Existing Data

```
rm -rf ~/.akash/data; \
mkdir -p ~/.akash/data; \
cd ~/.akash/data
```

### Download Snapshot&#x20;

> _**NOTE**_ - if any issues are encountered with the steps below and during snapshot download attempt - visit `https://cosmos-snapshots.s3.filebase.com` directly to isolate a pruned Akash snapshot for use and download.  After the isolation of a desired, recent snapshot - perform the `wget` step for the URL associated with that snapshot and then proceed to the `tar` command to unpack.

```
SNAP_URL="$(curl -s -o - https://cosmos-snapshots.s3.filebase.com/akash/pruned/snapshot.json | jq -r '.latest')"

wget -c "$SNAP_URL"

SNAP="${SNAP_URL##*/}"

tar xzvf "$SNAP" --force-local
```
