# Example Command Use

* The input used in this script execution was covered and created in prior steps
* The output value - which in our example is `88` - represents the price/cost of running a provider with the specified hardware spec input&#x20;
* With this analysis complete we can decide if the pricing meets our expectations.  If not, we adjust the pricing of resources with the script to reach desired pricing.
* We then use this script, if edits from default pricing standards is necessary,. within the Provider build process.

```
./charts/akash-provider/scripts/price_script_generic.sh <<< '[{"memory":536870912,"cpu":1000,"storage":[{"class":"beta2","size":1073741824},{"class":"ephemeral","size":2147483648}],"count":1,"endpoint_quantity":1,"ip_lease_quantity":1}]'

88
```
