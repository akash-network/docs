# STEP6 - Copy the Genesis File

Akash nodes need the Genesis file for the blockchain.  In this step we will gather the genesis.json file and make sure it is valid.

### Copy the Genesis File

```
curl -s "$AKASH_NET/genesis.json" > $HOME/.akash/config/genesis.json
```
