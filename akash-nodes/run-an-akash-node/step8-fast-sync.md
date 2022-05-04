# STEP8 - Fast Sync

Fast Sync means nodes can catch up quickly by downloading blocks in bulk.

*   Fast Sync settings can be found in the following file



```
cat $HOME/.akash/config/config.toml
```

### Verify Fast Sync Settings

* Most likely no changes will be necessary to config.toml and the default settings will be fine. But we will make sure.&#x20;
*   Verify the fast\_sync field is set to true

    ```
    # If this node is many blocks behind the tip of the chain, FastSync
    # allows them to catchup quickly by downloading blocks in parallel
    # and verifying their commits
    fast_sync = true
    ```
* Verify the Fast Sync version is set to v0.&#x20;
*   While version 0 is said to be the “legacy” version, in our experience this version works better.

    ```
    #######################################################
    ###       Fast Sync Configuration Connections       ###
    #######################################################
    [fastsync]

    # Fast Sync version to use:
    #   1) "v0" (default) - the legacy fast sync implementation
    #   2) "v1" - refactor of v0 version for better testability
    #   2) "v2" - complete redesign of v0, optimized for testability & readability
    version = "v0"
    ```
