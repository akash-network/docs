# Part 11. Update the Deployment

### Update the Manifest

Update the deploy.yml manifest file with the desired change.

_**NOTE**_** -** not all attributes of the manifest file are eligible for deployment update.  If the hardware specs of the manifest are updated (I.e. CPU count), a re-deployment of the workload is necessary.  Other attributes, such as deployment image and funding, are eligible for updates.

### Issue Transaction for On Chain Update

```
akash tx deployment update deploy.yml --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```

### Send Updated Manifest to Provider

```
akash provider send-manifest deploy.yml --node $AKASH_NODE --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --home ~/.akash --from $AKASH_KEY_NAME
```
