# Initialize Deployment Variables



* In this step we execute a script that will set environment variables related to the deployment created in the previous step
* Amongst other variables, the deployment ID (DSEQ) is captured and set as an env variable

```
apt install jq

source demo.sh
```

## Verify Deployment Status

```
provider-services query deployment get
```
