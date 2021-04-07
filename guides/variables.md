# Environment variables and flags

Generally, every parameter set be cli flag used by akash can be also set via environment variable.
Use following rule of binding flag to the corresponding environment variable
1. every dash `-` must be replaced with underscore `_`. `--` prefix must not be accounted!
2. make all characters capital case
3. add prefix `AKASH_` to the result

for example flag `--keyring-backend` binds to `AKASH_KEYRING_BACKEND` environment variable

The precedence is defined in the table below. 0 means highest priority

|Priority|Type|
|:---:|---|
|0|Environment variable|
|1|Flag|
|2|Config file|
|3|Default value|

Example below shows value precedence for `--keyring-backend` parameter.
- use default value set to `os`
```shell
akash tx deployment create ... 
#keyring-backend=os is used
```
- use value set by flag `--keyring-backend=file`
```shell
akash tx deployment create --keyring-backend=file ...
#keyring-backend=file is used 
```
- use value set by environment variable `AKASH_KEYRING_BACKEND=test`
```shell
AKASH_KEYRING_BACKEND=test akash tx deployment create --keyring-backend=file ...
#keyring-backend=test is used 
```

|Name|Flag|Description|
|---|---|
|`AKASH_VERSION`|Akash version to install for your network.  See [here](/guides/version.md).|
|`AKASH_NET`|Akash network configuration base URL. See [here](/guides/version.md).|
|`AKASH_ACCOUNT_ADDRESS`|The address of your account.  See [here](/guides/wallet/README.md#account-address).|
|`AKASH_NODE`|Akash network configuration base URL. See [here](/guides/version.md).|
|`AKASH_KEYRING_BACKEND`|Keyring backend to use for local keys.  See [here](/guides/wallet/README.md)|
