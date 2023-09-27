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

> NOTE - in the `Example Steps` provided below a specific snapshot version is used (`12992214`).  In your use the current/latest snapshot version should be used.  The latest Akash snapshot version - made available via Polkachu - can be found [here](https://polkachu.com/tendermint\_snapshots/akash).  Replace all references to example snapshot version `12992214` with the current/latest version found on this site.

#### Example Steps

```
wget -O akash_12992214.tar.lz4 https://snapshots.polkachu.com/snapshots/akash/akash_12992214.tar.lz4 --inet4-only

apt-get install lz4

lz4 -d akash_12992214.tar.lz4

tar -xvf akash_12992214.tar
```
