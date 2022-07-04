# Part 9. Create a Lease

Create a lease for the bid from the chosen provider above by running this command:

```bash
akash tx market lease create --chain-id $AKASH_CHAIN_ID --node $AKASH_NODE --owner $AKASH_ACCOUNT_ADDRESS --dseq $AKASH_DSEQ --gseq $AKASH_GSEQ --oseq $AKASH_OSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```

### Confirm the Lease

You can check the status of your lease by running:

```bash
akash query market lease list --owner $AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ
```

Note the bids will close automatically after 5 minutes, and you may get the response:

```
bid not open
```

If this happens, close your deployment and open a new deployment again.  To close your deployment run this command:

```
akash tx deployment close --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --dseq $AKASH_DSEQ  --owner $AKASH_ACCOUNT_ADDRESS --from $AKASH_KEY_NAME --keyring-backend $AKASH_KEYRING_BACKEND -y --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15
```

If your lease was successful you should see a response that ends with:

```
    state: active
```

{% hint style="info" %}
Please note that once the lease is created, the provider will begin debiting your deployment's escrow account, even if you have not completed the deployment process by uploading the manifest in the following step.
{% endhint %}
