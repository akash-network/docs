# API Service

The API Service of a full node enables a read-only query API that is useful for many tools such as dashboards, wallets, and scripting in general.

The API Service is configured in `~/.akash/config/app.toml` and can be enabled in the `[api]` section:

```text
[api]
enable = "true"
```

By default, the service listens on port `1317`, but this can also be changed in the `[api]` section of `app.toml`.

### API Documentation

There is a built-in Swagger API documentation which can be activated in the `app.toml`:

```text
swagger = true
```

The documentation will be accessible by navigating to the endpoint in your browser and then accessing the page using the path `/swagger/#/`.
