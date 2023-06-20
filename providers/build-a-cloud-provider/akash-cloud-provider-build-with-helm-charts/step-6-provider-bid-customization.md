# STEP 7 - Provider Bid Customization

* If there is a desire to manipulate the provider bid engine, include the `--set bidpricescript` switch .  The pricing script used in this switch is detailed in the [Akash Provider Bid Pricing](../akash-provider-bid-pricing/) section of this guide.
* Edit the `price_script_generic.sh` file detailed in [Akash Provider Bid Pricing](../akash-provider-bid-pricing/) with preferred resource pricing level
* **Note -** When the provider deployment is created the bid script should return the price in under 5 seconds . If the script does not execute in this time period the following error message will be seen in the provider pod logs.  Such a report would suggest that there is an error/issue with script customizations that should be reviewed.  Following review and adjustment, uninstall the provider deployment (via helm uninstall) and reinstall.
* **Note** - there is further discussion on the bid script and deployer address whitelisting in this [section](step-11-provider-whitelisting-optional.md).

### **Example Bid/Price Script syntax:**

```
cd provider

wget https://raw.githubusercontent.com/akash-network/helm-charts/main/charts/akash-provider/scripts/price_script_generic.sh

# adjust target prices to your needs in price_script_generic.sh file
helm upgrade --install akash-provider akash/provider -n akash-services -f provider.yaml --set bidpricescript="$(cat price_script_generic.sh | openssl base64 -A)"
```
