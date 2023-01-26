# Obtain Private Key

In the [TMKMS Setup](broken-reference) section of this guide we will import your Validators private key.

If you have a pre-existing Akash Validator the private key from this instance may be used.

If this is a new Akash Validator - create an Akash validator instance for the purpose of private key generation, capture the private key, and then shut down the validator.  Use the instructions in [Akash Node Deployment Via Omnibus](../../akash-nodes/akash-node-deployment-via-omnibus.md) to easily build an Akash Node for this purpose and to obtain the validator private key as detailed below.  It is NOT necessary to complete the additional steps to turn the Node into a Validator.  Completing only the Node build will allow the capture of the needed Validator private key.

### Example Validator Private Key Retrieval

* Display contents of key file on the validator

```
cat ~/.akash/config/priv_validator_key.json
```

* Example Output

```
{
  "address": "134FCAC9<redacted>",
  "pub_key": {
    "type": "tendermint/PubKeyEd25519",
    "value": "BrL0wA8DWiVvm<redacted>"
  },
  "priv_key": {
    "type": "tendermint/PrivKeyEd25519",
    "value": "3RphlkX7PucBKSdhFKviFV5TI<redacted>"
  }
}
```
