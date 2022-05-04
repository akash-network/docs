# Additional Information

## Config Files

Akash Node configurations are found within these files:

### Cosmos Specific Configuration

```
~/.akash/config/app.toml
```

### Tendermint Specific Configuration

```
~/.akash/config/config.toml
```

## Akash Networks

Within this guide the Akash mainnet is used and as specified in the AKASH\_NET value.  To launch a node on the testnet or edgenet and for additional network information, use this [guide](https://github.com/ovrclk/net).

## State Pruning

There are several strategies for pruning state, please be aware that this is only for state and not for block storage:

1. **default:** the last 100 states are kept in addition to every 500th state; pruning at 10 block intervals
2. **nothing:** all historic states will be saved, nothing will be deleted (i.e. archiving node)
3. **everything:** all saved states will be deleted, storing only the current state; pruning at 10 block intervals
4. **custom:** allow pruning options to be manually specified through pruning-keep-recent, pruning-keep-every, and pruning-interval

You can configure the node's pruning strategy at start time with the --pruning or by configuring the app.toml file.

_**Validator Node Pruning Note**_** -** please do not use --pruning everything on validator nodes as it is known to cause issues. Instead use --pruning default.
