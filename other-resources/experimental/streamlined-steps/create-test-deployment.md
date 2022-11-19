# Create Test Deployment

* If a deployment has been in the current session previously, use the following command to clear the DSEQ number to prepare for new deployment creation

```
unset AKASH_DSEQ
```

### **Create Deployment**

```
provider-services tx deployment create sdl/big-dipper.yaml
```
