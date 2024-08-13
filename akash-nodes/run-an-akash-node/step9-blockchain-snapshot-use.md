# STEP9 - Blockchain Snapshot Use

We could let our node catch up to the current block but this would take a very long time. Instead we will download a snapshot of the blockchain before starting our node.

**NOTE** - at the time of this writing the snapshot is 200GB and could take some time to pull down.

### Remove Existing Data

```
rm -rf ~/.akash/data; \
mkdir -p ~/.akash/data; \
cd ~/.akash
```

### Download Snapshot&#x20;

The latest Akash snapshot version - made available via The Offical Akash Network Snapshot - can be found [here](https://snapshots.akash.network/akashnet-2/akashnet-2_latest.tar.lz4).  This snapshot is updated every hour.

#### Example Steps

```
wget -O akashnet-2_latest.tar.lz4 https://snapshots.akash.network/akashnet-2/akashnet-2_latest.tar.lz4 --inet4-only

apt-get install lz4

lz4 -d akashnet-2_latest.tar.lz4

tar -xvf akashnet-2_latest.tar
```
