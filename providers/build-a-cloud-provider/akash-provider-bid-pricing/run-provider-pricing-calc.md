# Run Provider Pricing Calc

In this step we will detail:

* Command syntax for the provider pricing estimation script
* Example templates based on different provider host/server footprints
* Example script execution

**NOTE** - we recommend initially leaving the pricing standards used in the script as is. Once comfortable with the script the pricing specifications may be updated if you feel necessary. The default pricing standards for CPU/memory/ephemeral storage/persistent storage may be viewed in the script located [here](https://github.com/akash-network/helm-charts/blob/main/charts/akash-provider/scripts/price\_script\_generic.sh).

## Command Syntax

* Details on the input to the scripts are reviewed in the subsequent section

```
./charts/akash-provider/scripts/price_script_generic.sh <<<  <deployment-order-request-specs>
```
