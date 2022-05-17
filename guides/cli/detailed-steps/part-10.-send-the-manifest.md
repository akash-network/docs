# Part 10. Send the Manifest

Upload the manifest using the values from above step:

```bash
akash provider send-manifest deploy.yml --node $AKASH_NODE --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --home ~/.akash --from $AKASH_KEY_NAME
```

### Confirm the URL

Now that the manifest is uploaded, your image is deployed. You can retrieve the access details by running the below:

```bash
akash provider lease-status --node $AKASH_NODE --home ~/.akash --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER
```

You should see a response similar to:

```javascript
{
  "services": {
    "web": {
      "name": "web",
      "available": 1,
      "total": 1,
      "uris": [
        "rga3h05jetf9h3p6dbk62m19ck.ingress.ewr1p0.mainnet.akashian.io"
      ],
      "observed_generation": 1,
      "replicas": 1,
      "updated_replicas": 1,
      "ready_replicas": 1,
      "available_replicas": 1
    }
  },
  "forwarded_ports": {}
}
```

You can access the application by visiting the hostnames mapped to your deployment. Look for a URL/URI and copy it to your web browser.

### View your logs

You can view your application logs to debug issues or watch progress like so:

```bash
akash \
  --home "$AKASH_HOME" \
  --node "$AKASH_NODE" \
  provider lease-logs \
  --dseq "$AKASH_DSEQ" \
  --gseq "$AKASH_GSEQ" \
  --oseq "$AKASH_OSEQ" \
  --provider "$AKASH_PROVIDER" \
  --from "$AKASH_KEY_NAME"
```
