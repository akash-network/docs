# API Service

The API Service of a full node enables a read-only query API that is useful for many tools such as dashboards, wallets, and scripting in general.

The API Service is configured in `~/.akash/config/app.toml` and can be enabled in the `[api]` section:

```text
[api]
enable = "true"
```

By default, the service listens on port `1317`, but this can also be changed in the `[api]` section of `app.toml`.

