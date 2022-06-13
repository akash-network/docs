# Provider Bid Customization

* If there is a desire to manipulate the provider bid engine, include the \`--set bidpricescript\` switch.  The pricing script used in this switch was detailed in the \`Akash Provider Pricing & Bid Calculation\` step of this guide.
* Edit the **\`**price\_script\_generic.sh\` file with preferred resource pricing level
* **Note -** When the provider deployment is created the bid script should return the price in under 5 seconds . If the script does not execute in this time period the following error message will be seen in the provider pod logs.  Such a report would suggest that there is an error/issue with script customizations that should be reviewed.  Following review and adjustment, attempt to uninstall the provider deployment (via helm uninstall) and reinstall.

### **Example Bid/Price Script syntax:**

```
--set bidpricescript="$(cat ./helm-charts/charts/akash-provider/scripts/price_script_generic.sh | openssl base64 -A)"
```
