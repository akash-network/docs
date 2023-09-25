# Google Cloud OR Cloudflare Configuration

> _**NOTE**_ - both the use of Google Cloud and Cloudflare DNS configurations are presented in this section.  Only complete one of these paths based on DNS prefered platform.

## Create the Google DNS Cloud Service Account for DNS-01 Challenge

> _**NOTE**_ - the actions in this section should be performed in your Google Cloud console instance

### STEP 1 - Create Role

> _**NOTE**_ - additional information on the configuration of the settings covered in this section can be found [here](https://console.cloud.google.com/iam-admin/roles)

```
Role name: DNS Administrator Limited
ID: dns.admin.light
Description:
Created on: 2023-04-26
To use for DNS-01 ACME challenges.
https://cert-manager.io/docs/configuration/acme/dns01/google/

Permissions:
dns.resourceRecordSets.*
dns.changes.*
dns.managedZones.list
```

### STEP 2 - Create Service Account

> _**NOTE**_ - additional information on the configuration of the settings covered in this section can be found [here](https://console.cloud.google.com/iam-admin/serviceaccounts)

```
SA Name: dns01-solver
SA ID: dns01-solver
```

### STEP 3 - Create Service Account (SA) Key for dns01-solver SA

> NOTE - additional information on the configuration of the settings covered in this section can be found [here](https://console.cloud.google.com/projectselector2/iam-admin/serviceaccounts)

#### Download the Service Account Key from Google Cloud

* First download the service account key in JSON
* Then encode the service account key in base64

```
cat your-gcp-service-account-key.json | base64 | tr -d '\n'
```

#### Apply the Secret on your Provider Cluster

> _**NOTE**_ - this step should be performed on one of the Kubernetes control plane nodes of your Akash Provider

#### Create the Service Account Secret Config File

* Replace the service account key field with your own key

```
cat > service-account-secret.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  name: clouddns-gcp-dns01-solver-sa
  namespace: cert-manager
type: Opaque
data:
  key.json: "<your-gcp-service-account-key-json-base64>"
EOF
```

#### Apply the Service Account Secret Config

```
kubectl apply -f service-account-secret.yaml
```

## Create the Cloudflare DNS Cloud Service Account for DNS-01 Challenge

* If using Cloudflare for DNS then request your API token and then create the following secret:

> API Tokens are recommended for higher security, since they have more restrictive permissions and are more easily revocable. Tokens can be created at User Profile > API Tokens > API Tokens. The following settings are recommended:

```
Permissions:
- Zone - DNS - Edit
- Zone - Zone - Read

Zone Resources:
- Include - All Zones
```

> _**NOTE**_ - this step should be performed on one of the Kubernetes control plane nodes of your Akash Provider

#### Create the DNS Challenge Config

```
cat > dns-challenge-config.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-token-secret
  namespace: cert-manager
type: Opaque
stringData:
  api-token: <API token>
EOF
```

#### Apply the DNS Challenge Config

```
kubectl apply -f dns-challenge-config.yaml
```
