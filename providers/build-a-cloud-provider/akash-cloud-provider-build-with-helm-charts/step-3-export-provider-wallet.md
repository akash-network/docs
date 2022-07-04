# STEP 3 - Export Provider Wallet

In this section we will export the pre-existing, funded wallet to store the private key in a local file.  To conduct the commands in this section the Akash CLI must be installed which is detailed in this [guide](https://docs.akash.network/guides/cli/detailed-steps/part-1.-install-akash) (STEP 1 only).

The wallet used will be used for the following purposes:

* Pay for provider transaction gas fees
* Pay for bid collateral which is discussed further in this section

## List Available Keys

* Print the key names available in the local OS keychain for use in the subsequent step

```
akash keys list
```

### Example/Expected Output

```
akash keys list
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

```
cd ~

akash keys export <key-name> > key.pem
```
