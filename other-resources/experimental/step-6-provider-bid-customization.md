# Copy of STEP 7 - Provider Bid Customization

## Overview

> _**NOTE**_ - if you are updating your provider bid script from a previous version use this [bid script migration guide](../../providers/akash-provider-troubleshooting/provider-bid-script-migration-gpu-models.md).

* If there is a desire to manipulate the provider bid engine, include the `--set bidpricescript` switch .  The pricing script used in this switch is detailed in the [Akash Provider Bid Pricing](../../providers/build-a-cloud-provider/akash-provider-bid-pricing/) section of this guide.
* Edit the `price_script_generic.sh` file detailed in [Akash Provider Bid Pricing](../../providers/build-a-cloud-provider/akash-provider-bid-pricing/) with preferred resource pricing level
* **Note -** When the provider deployment is created the bid script should return the price in under 5 seconds . If the script does not execute in this time period the following error message will be seen in the provider pod logs.  Such a report would suggest that there is an error/issue with script customizations that should be reviewed.  Following review and adjustment, uninstall the provider deployment (via helm uninstall) and reinstall.
* **Note** - there is further discussion on the bid script and deployer address whitelisting in this [section](../../providers/build-a-cloud-provider/akash-cloud-provider-build-with-helm-charts/step-11-provider-whitelisting-optional.md).

> _**USDC Stable Payment Support**_ - note that the current, default bid script enables stable payment support on the Akash Provider.  Akash deployments using stable payments are taxed at a slightly higher rate than deployments using AKT payment.  If you choose not to support stable payments on your provider, remove stable payment support from the default bid script.

## Provider Bid Script Customization Steps

### STEP 1 - Create akash-provider-values.yml File

* If customization of your provider bid pricing is desired, begin by creating a `akash-provider-values.yml` file which will be used to hold customized values

```
cd ~/provider

vim akash-provider-values.yml
```

### **STEP 2 - Customize** the akash-provider-values.yml File

> Update your `akash-provider-values.yml` file with the price targets you want. If you don't specify these keys, the bid price script will default values shown below

`price_target_gpu_mappings` sets the GPU price in the following way and in the example provided:

* `a100` nvidia models will be charged by `120` USD/GPU unit a month
* `t4` nvidia models will be charged by `80` USD/GPU unit a month
* Unspecified nvidia models will be charged `130` USD/GPU unit a month (if `*` is not explicitly set in the mapping it will default to `100` USD/GPU unit a month)
* Extend with more models your provider is offering if necessary with syntax of `<model>=<USD/GPU unit a month>`

```
price_target_cpu: 1.60
price_target_memory: 0.80
price_target_hd_ephemeral: 0.02
price_target_hd_pers_hdd: 0.01
price_target_hd_pers_ssd: 0.03
price_target_hd_pers_nvme: 0.04
price_target_endpoint: 0.05
price_target_ip: 5
price_target_gpu_mappings: "a100=120,t4=80,*=130"
```

### STEP 3 - Download Bid Price Script

```
cd ~/provider

wget https://raw.githubusercontent.com/akash-network/helm-charts/main/charts/akash-provider/scripts/price_script_generic.sh
```

### STEP 4 - Upgrade akash-provider Deployment with Customized Bid Script

```
helm upgrade akash-provider akash/provider -n akash-services -f akash-provider-values.yml  --set bidpricescript="$(cat price_script_generic.sh | openssl base64 -A)"
```

#### Verification of Bid Script Update

```
helm list -n akash-services | grep akash-provider
```

#### Expected/Example Output

```
# helm list -n akash-services | grep akash-provider
akash-provider         	akash-services	28      	2023-09-19 12:25:33.880309778 +0000 UTC	deployed	provider-6.0.5                	0.4.6 
```
