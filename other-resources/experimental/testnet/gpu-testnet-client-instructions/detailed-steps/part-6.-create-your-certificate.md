# Create your Certificate

In this step we will create a local certificate and then store the certification on the block chain

* Ensure that prior steps in this guide have been completed and that you have a funded wallet before attempting certificate creation.
* **Your certificate needs to be created only once per account** and can be used across all deployments.

#### Generate Cert

* Note: If it errors with `Error: certificate error: cannot overwrite certificate`, then add `--overwrite` should you want to overwrite the cert. Normally you can ignore that error and proceed with publishing the cert (next step).

```
provider-services tx cert generate client --from $AKASH_KEY_NAME
```

#### Publish Cert to the Blockchain

```
provider-services tx cert publish client --from $AKASH_KEY_NAME
```
