# Upload Manifest

### Upload Manifest to Provider

* Upload the deployment’s SDL to chosen provide

```
provider-services send-manifest sdl/big-dipper.yaml --provider $AKASH_PROVIDER
```

### **Confirm Lease Status**

* Retrieve the deployment’s URL and mapped ports

```
akash provider lease-status --provider $AKASH_PROVIDER
```
