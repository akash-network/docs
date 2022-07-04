# List All Active Deployments

```
akash_deployments
```

#### Expected/Sample Output

* Select the associated number of a deployment to reveal greater details.  At this time those details include listing the deployment’s current provider.
* Select an instance to perform actions such as closing a deployment or accessing a deployment’s shell.  The specific deployment must be selected prior to such actions and the selected deployment will be indicated in the CLI’s prompt.

```
root@ip-10-0-10-163:~/akash-tools/cli-booster[http://akash-sentry01.skynetvalidators.com:26657][deploymentone][4815131-1-1]$ akash_deployments

Deployments you have accepted the bids for (i.e. have ran lease create).
Found the following active deployments:
	"dseq"     "gseq"  "oseq"
0>	"4815090"  1       1
1>	"4815131"  1       1
Choose your deployment from the list [1]:
Selected 1: 4815131-1-1
AKASH_DSEQ=4815131
Looking for a matching provider for this order...
AKASH_PROVIDER=akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0
```
