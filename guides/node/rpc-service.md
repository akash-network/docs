# RPC Service

The RPC Service allows for both sending transactions to the network and for querying state from the network. It is used by the `akash` command-line tool when using an `akash tx` command or `akash query` command.

The RPC Service is configured in the `[rpc]` section of `~/.akash/config/config.toml`.

By default, the service listens on port `26657`, but this can also be changed in the `[rpc]` section of `config.toml`.

