# STEP5 - Set Minimum Gas Price

Your node keeps unconfirmed transactions in its mempool. In order to protect the node from spam, it is best to set a minimum gas price that the transaction must meet in order to be accepted into the mempool.

_**This setting can be found in the following file and we will change the default value which is blank.**_

```
vi ~/.akash/config/app.toml
```

_**The initial recommended min-gas-prices is 0.025uakt but you might want to change it later.**_

```
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

##### main base config options #####

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 10uatom).

minimum-gas-prices = "0.025uakt"
```
