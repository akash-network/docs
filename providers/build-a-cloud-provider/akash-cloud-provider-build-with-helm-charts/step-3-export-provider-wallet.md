# STEP 3 - Export Provider Wallet

In this section we will export the pre-existing, funded wallet to store the private key in a local file.  To conduct the commands in this section the Akash CLI must be installed which is detailed in this [guide ](../../../guides/cli/detailed-steps/)(STEP 1 only).

The wallet used will be used for the following purposes:

* Pay for provider transaction gas fees
* Pay for bid collateral which is discussed further in this section

> Make sure to create a new Akash account for the provider and do not reuse an account used for deployment purposes.  Bids will not be generated from your provider if the deployment orders are created with the same key as the provider.

## List Available Keys

* Print the key names available in the local OS keychain for use in the subsequent step

```
provider-services keys list
```

### Example/Expected Output

```
provider-services keys list
- name: ""
  type: local
  address: akash1<redacted>
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"<redacted>"}'
  mnemonic: ""
- name: mykey
  type: local
  address: akash1<redacted>
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"<redacted>"}'
  mnemonic: ""
```

## **Export Private Key to Local File**

* The key-name can be any name of your choice
* Note the passphrase used to protect the private key as it will be used in future steps

> _**NOTE**_ - The passhprase MUST be at least 8 characters long. Otherwise provider will encounter `failed to decrypt private key: ciphertext decryption failed error` when `keys import` is executed.

### STEP 1 - Export Provider Key

```
cd ~

provider-services keys export mykey1
```

#### Expected/Example Output

```
provider-services keys export mykey1

Enter passphrase to encrypt the exported key:                          
Enter keyring passphrase:                                              
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: REDACTED
type: secp256k1

REDACTED
-----END TENDERMINT PRIVATE KEY-----
```

### &#x20;STEP 2 - Create key.pem and Copy Output Into File

* Copy the contents of the prior step into the `key.pem` file

> _**NOTE -**_ file should contain only what's between `-----BEGIN TENDERMINT PRIVATE KEY-----` and  `-----END TENDERMINT PRIVATE KEY-----` (including the `BEGIN` and `END` lines):

#### Example/Expected File Contents

```
cat key.pem
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: REDACTED
type: secp256k1

REDACTED
-----END TENDERMINT PRIVATE KEY-----
```
