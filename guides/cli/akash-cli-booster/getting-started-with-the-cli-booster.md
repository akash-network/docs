# Getting Started with the CLI Booster

Our use of the Akash CLI Booster begins by downloading the application.

Ensure the following steps have been completed prior:

* Install Akash CLI which is covered[ here](../).
* Create a new wallet or import a pre-existing wallet.  New wallet creation steps are covered [here](../../../tokens-and-wallets/keplr.md).

## Clone Repo

```
git clone https://github.com/arno01/akash-tools.git
```

## Initialize

Start the tool with these quick steps.

```
cd akash-tools/cli-booster

. akash.source
```

* Select account that should be used for deployments and/or other activities from list
* Example prompt shown below.  In this case only one account is available in the keyring and we could press accept the default list number of “0” by pressing enter with no change.

```
Available keys:
	"name"           "address"
0>	"deploymentone"  "akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7"
Choose your key from the list [0]:
```

#### Example/expected prompt following successful CLI Booster initialization

```
root@ip-10-0-10-163:~/akash-tools/cli-booster[https://rpc.akash.smartnodes.one:443][deploymentone][]$
```

### **Create Certificate**

If this is your first time using the selected key, create a client certificate.

```
akash_mkcert
```
