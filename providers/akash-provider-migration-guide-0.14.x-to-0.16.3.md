---
description: v0.14.x to v0.16.3
---

# Akash Provider Migration Guide - 0.14.X to 0.16.3

Akash version 0.16.3 will introduce changes in CRDs that need to be applied in order to continue operations.

All steps below MUST be executed in the same order as declared and applied to your environment. If any step fails STOP and reach out to the Akash team.

## Precursor to Upgrade - Orphan Manifest Purge

### Create Script File

```
cd ~

vi manifest-purge.sh
```

### Populate Script File

```
#!/usr/bin/env bash

kubectl get mani -n lease -o 'custom-columns=name:{.metadata.name}' --no-headers | \
 while read ns; do

   # if ns exists, it's a fresh manifest.
   if kubectl get ns "$ns" >/dev/null 2>&1; then
     echo "FOUND: $ns"
     continue
   fi

   # make sure it's a NotFound error before deleting.
   nserr=$(kubectl get ns "$ns" 2>&1)
   if [[ "$nserr" == *NotFound* ]]; then
     echo "GONE: $ns"
     kubectl delete mani "$ns" -n lease
     continue
   fi
 done
```

### Make Script Executable

```
chmod +x ~/manifest-purge.sh
```

### Execute Script

```
./manifest-purge.sh
```

## Provider Service Running on Bare Metal/VM

### STEP 1 - Upgrade RPC node to 0.16.3

If you are using 3rd-party RPC node ensure upgrade has been applied.

If you are using your own RPC node - as recommended for Providers - ensure the node has been upgraded.

### STEP 2 - Stop provider service

The Akash Provider service is most likely controlled by systemd and if so can be stopped as shown below

```
systemctl stop akash-provider
```

### STEP 3 - Upgrade Akash Version

Download and extract the v0.16.3 from under the Assets drop-down menu here https://github.com/ovrclk/akash/releases/tag/v0.16.3 for your OS & Architecture.&#x20;

Replace the old akash binary with the new one.

### STEP 4 - Ensure Akash Client Upgrade

#### Verify Version and Expected Output

```
root@ip-10-0-10-125:/home/ubuntu# akash version

v0.16.3
```

### **STEP 5 - Download v0.16.3 Provider CRDs**

```
wget https://raw.githubusercontent.com/ovrclk/akash/mainnet/main/pkg/apis/akash.network/crd.yaml
```

### **STEP 6 - Install v0.16.3 CRDs**

```
akash provider migrate v0.14tov0.16 --crd ./crd.yaml
```

#### **Expected Output from Upgrade**

```
root@ip-10-0-10-125:~# akash provider migrate v0.14tov0.16 --crd ./crd.yaml

using kube config file /root/.kube/config
checking manifests to backup
checking providers hosts to backup
total to backup
	manifests:      1
	provider hosts: 1
backup manifests
backup manifests DONE
backup provider hosts
backup provider hosts DONE
applying CRDs
customresourcedefinition.apiextensions.k8s.io "manifests.akash.network" deleted
customresourcedefinition.apiextensions.k8s.io "providerhosts.akash.network" deleted
customresourcedefinition.apiextensions.k8s.io/manifests.akash.network created
customresourcedefinition.apiextensions.k8s.io/providerhosts.akash.network created
applying CRDs       DONE
applying manifests
manifest "mbamrdgl7ser2f253ubem42r074vsi6aj6c6a4bldfgq4" has been migrated successfully
applying manifests  DONE
applying hosts
provider host "c5o7gdvuodea90sgpm7v3rt0d0.ingress.akashtesting.xyz" has been migrated successfully
applying hosts      DONE
```

### STEP 7 - Start provider service

#### Using SystemD

```
systemctl start akash-provider
```

### STEP 8 - Create the Hostname Operator Service

```
cat /etc/systemd/system/akash-hostname-operator.service
[Unit]
Description=Akash Hostname Operator
After=network.target

[Service]
User=akash
Group=akash
ExecStart=akash provider hostname-operator
KillSignal=SIGINT
Restart=on-failure
RestartSec=15
StartLimitInterval=200
StartLimitBurst=10
#LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
```

### STEP 9 - Start the Hostname Operator Service



```
systemctl start akash-hostname-operator
systemctl enable akash-hostname-operator
```

### STEP 10 - Check Status of Provider

* Make a test deployment and ensure the DSEQ hits provider logs and that you can create deployment/lease and send manifest

```
journalctl -u akash-provider --since '5 min ago' -f
```

## **Provider Service Running in Kubernetes via Helm Charts**

If you are using Helm Charts for installing the Akash Provider and wishing to upgrade to 0.16.3, then run the same commands you have previously used with adding --set image.tag="0.16.3" on the command line like in the example below.

### STEP 1 - Upgrade RPC node to 0.16.3

If you are using a 3rd-party RPC node ensure upgrade has been applied.

If you are using your own RPC node - as recommended for Providers - ensure the node has been upgraded.

### **STEP2 - Upgrade Provider**

**Update Current CRDs**

```
https://docs.akash.network/other-resources/akash-provider-migration-guide-0.14.x-to-0.16.3#provider-service-running-in-kubernetes-via-helm-charts
```

#### Add/Update the Helm Repo



```
helm repo add akash https://ovrclk.github.io/helm-charts
helm repo update
```

#### Perform the Upgrade

```
helm upgrade akash-node akash/akash-node -n akash-services ... --set image.tag="0.16.3"

helm upgrade akash-provider akash/provider -n akash-services ... --set image.tag="0.16.3"

helm upgrade hostname-operator akash/hostname-operator -n akash-services ... --set image.tag="0.16.3"
```

## Additional Notes

Migrate command creates a directory to backup kubernetes objects. By default it is the current directory. It can be changed with --k8s-crd-migrate-path flag Directory content is preserved after success. Delete it IF and ONLY IF migration has been successful.
