# Software Upgrade: Akashnet-2-upgrade-1

## TL;DR

Software upgrades allows any cosmos based network to soft-upgrade the network to a new version. In general, for any state breaking changes, there will be a migration script to migrate the chain data and we generally hard fork the blockchain network. For soft-upgrades, `x/upgrade` module has a special function called upgrade-handler which handles all the migrations required. Here is the upgrade handler for `akashnet-2-upgrade-1`: [https://github.com/ovrclk/akash/blob/147aaceb41eaf11ec49f3c151301a11bb361ae5f/app/app.go\#L266-L271](https://github.com/ovrclk/akash/blob/147aaceb41eaf11ec49f3c151301a11bb361ae5f/app/app.go#L266-L271).

It handles 2 migrations:

* Fix vesting account delegation issues
* Set staking historical events to `10000`, which is required for IBC.

For more details on soft-upgrades [click here](https://docs.cosmos.network/master/modules/upgrade/)

## What validators need to do before the upgrade time?

* Nothing, just sit back and relax. The `software-upgrade` proposal will force the binary \(current version, `akash-v0.10.x`\) to halt at specified height, i.e., 455200

## What validators need to do at the time of upgrade \(i.e., at block height `455200`\)

### 1. Cross check your consensus height:

```bash
akash status 2>&1 | jq -r '.SyncInfo.latest_block_height'
```

It should be 455199

### 2. Stop your akash service

```bash
sudo service akash stop
```

### 3. Get/Install new version

**Option-1: Using pre-build binaries**

Download pre-built binaries from: [https://github.com/ovrclk/akash/releases/tag/v0.12.1](https://github.com/ovrclk/akash/releases/tag/v0.12.1)

**Option-2: Build from source**

* Requires go1.16+

  ```bash
  git clone https://github.com/ovrclk/akash
  cd akash
  git fetch
  git checkout v0.12.1
  MAINNET=true make install
  ```

### 4. Check your new akash version

```bash
$ akash version --long
name: akash
server_name: akash
version: v0.12.1
commit: 53182423582000bf63fa674245a5008c5b466bf1
build_tags: osusergo,netgo,ledger,mainnet,static_build
go: go version go1.16.1 linux/amd64
...
```

### 5. Start your akash service

```bash
sudo service akash start
```

That's it. You should be able to check new blocks coming up.

## What if the upgrade fails?

Since we are not hard-forking the network, it should be simple to revert back.

* Stop akash service
* Re-install akash `v0.10.2`

  ```bash
   cd akash
   git checkout v0.10.2
   MAINNET=true make install
  ```

* Edit akash service file and change `akash start` to `akash start --unsafe-skip-upgrades 455200`
* Start akash service

