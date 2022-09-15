# Obtain Private Key

In the [TMKMS Setup](broken-reference) section of this guide we will import the Validators private key.

If you have a pre-existing Akash Validator the private key from this instance may be used.

If this is a new Akash Validator - create an Akash validator instance for the purpose of private key generation, capture the private key, and then shut down the validator.

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
