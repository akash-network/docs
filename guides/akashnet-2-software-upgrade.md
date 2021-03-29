# Akashnet-2 Software upgrade procedure

## What validators need to do before the upgrade time?

- Nothing, just sit back and relax. The `software-upgrade` proposal will force the binary (current version, `akash-v0.10.x`) to halt at specified height, i.e., 455200

## What validators need to do at the time of upgrade (i.e., at block height `455200`)
### 1. Cross check your consensus height:
```sh
akash status 2>&1 | jq -r '.SyncInfo.latest_block_height'
```
It should be 455199

### 2. Stop your akash service
```sh
sudo service akash stop
```

### 3. Get/Install new version

#### Option-1:
   Download pre-built binaries from: https://github.com/ovrclk/akash/releases/tag/v0.12.0
#### Option-2:
   Build from source
   - Requires go1.16+
   ```sh
   git clone https://github.com/ovrclk/akash
   cd akash
   git fetch
   git checkout v0.12.0
   make install
   ```

### 4. Check your new akash version

```sh
$ akash version --long

[TBD]
```

### 5. Start your akash service
```sh
sudo service akash start
```

That's it. You should be able to check new blocks coming up.
