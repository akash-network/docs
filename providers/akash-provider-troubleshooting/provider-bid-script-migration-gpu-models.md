# Provider Bid Script Migration - GPU Models

## Overview

A new bid script for Akash Providers has been released that now includes the ability to specify pricing of multiple GPU models.

This document details the recommended procedure for Akash providers needing migration to the new bid script from prior versions.

## New Features of Bid Script Release

* Support for parameterized price targets (configurable through the Akash/Provider Helm chart values), eliminating the need to manually update your bid price script
* Pricing based on GPU model, allowing you to specify different prices for various GPU models

## How to Migrate from Prior Bid Script Releases

### STEP 1 -  Backup your current bid price script

> This command will produce an `old-bid-price-script.sh` file which is your currently active bid price script with your custom modifications

```
helm -n akash-services get values akash-provider -o json | jq -r '.bidpricescript | @base64d' > old-bid-price-script.sh
```

### STEP 2 - Verify Previous Custom Target Price Values

```
cat old-bid-price-script.sh | grep ^TARGET
```

#### Example/Expected Output

```
# cat old-bid-price-script.sh | grep ^TARGET
TARGET_CPU="1.60"          # USD/thread-month
TARGET_MEMORY="0.80"       # USD/GB-month
TARGET_HD_EPHEMERAL="0.02" # USD/GB-month
TARGET_HD_PERS_HDD="0.01"  # USD/GB-month (beta1)
TARGET_HD_PERS_SSD="0.03"  # USD/GB-month (beta2)
TARGET_HD_PERS_NVME="0.04" # USD/GB-month (beta3)
TARGET_ENDPOINT="0.05"     # USD for port/month
TARGET_IP="5"              # USD for IP/month
TARGET_GPU_UNIT="100"      # USD/GPU unit a month
```

### STEP 3 - Backup Akash/Provider Config

> This command will backup your akash/provider config in `akash-provider-values.yml` file (excluding the old bid price script)

```
helm -n akash-services get values akash-provider | grep -v '^USER-SUPPLIED VALUES' | grep -v ^bidpricescript > akash-provider-values.yml
```

### STEP 4 - Update akash-provider-values.yml File Accordingly

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

### STEP 5 - Download New Bid Price Script

```
mv -vi price_script_generic.sh price_script_generic.sh.old

wget https://raw.githubusercontent.com/akash-network/helm-charts/main/charts/akash-provider/scripts/price_script_generic.sh
```

### STEP 6 - Upgrade Akash/Provider Chart to Version 6.0.5

```
helm repo update akash

helm search repo akash/provider
```

#### Expected/Example Output

```
# helm repo update akash
# helm search repo akash/provider
NAME          	CHART VERSION	APP VERSION	DESCRIPTION                          
akash/provider	6.0.5        	0.4.6      	Installs an Akash provider (required)
```

### STEP 7 - Upgrade akash-provider Deployment with New Bid Script

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
