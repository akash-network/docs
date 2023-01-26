# Provider Earnings

Use the verifications included in this section for the following purposes:

* [Provider Earnings History](provider-earnings.md#provider-earnings-history)
* [AKT Total Earned by Provider](provider-earnings.md#akt-total-earned-by-provider)
* [AKT Total Earning Potential Per Active Deployment](provider-earnings.md#akt-total-earning-potential-per-active-deployment)
* [Current Leases: Withdrawn vs Consumed](provider-earnings.md#current-leases-withdrawn-vs-consumed)

## Provider Earnings History

Use the commands detailed in this section to gather the daily earnings history of your provider

### Command Template

* Only the following variables need update in the template for your use:
  * AKASH\_NODE - populate value with the address of your RPC node
  * PROVIDER - populate value with your provider address

```
export AKASH_NODE=<your-RPC-node-address>

PROVIDER=<your-provider-address>; STEP=23.59; BLOCK_TIME=6; HEIGHT=$(provider-services query block | jq -r '.block.header.height'); for i in $(seq 0 23); do BLOCK=$(echo "scale=0; ($HEIGHT-((60/$BLOCK_TIME)*60*($i*$STEP)))/1" | bc); HT=$(provider-services query block $BLOCK | jq -r '.block.header.time'); AL=$(provider-services query market lease list --height $BLOCK --provider $PROVIDER --gseq 0 --oseq 0 --page 1 --limit 200 --state active -o json | jq -r '.leases | length'); DCOST=$(provider-services query market lease list --height $BLOCK --provider $PROVIDER --gseq 0 --oseq 0 --page 1 --limit 200 -o json --state active | jq --argjson bt $BLOCK_TIME -c -r '(([.leases[].lease.price.amount // 0|tonumber] | add)*(60/$bt)*60*24)/pow(10;6)'); BALANCE=$(provider-services query bank balances --height $BLOCK $PROVIDER -o json | jq -r '.balances[].amount // 0|tonumber/pow(10;6)'); IN_ESCROW=$(echo "($AL * 5)" | bc); TOTAL=$( echo "($BALANCE+$IN_ESCROW)" | bc); printf "%8d\t%.32s\t%4d\t%12.4f\t%12.6f\t%4d\t%12.4f\n" $BLOCK $HT $AL $DCOST $BALANCE $IN_ESCROW $TOTAL; done
```

### **Example Command Use**

```
PROVIDER=akash18ga02jzaq8cw52anyhzkwta5wygufgu6zsz6xc; STEP=23.59; BLOCK_TIME=6; HEIGHT=$(provider-services query block | jq -r '.block.header.height'); for i in $(seq 0 23); do BLOCK=$(echo "scale=0; ($HEIGHT-((60/$BLOCK_TIME)*60*($i*$STEP)))/1" | bc); HT=$(provider-services query block $BLOCK | jq -r '.block.header.time'); AL=$(provider-services query market lease list --height $BLOCK --provider $PROVIDER --gseq 0 --oseq 0 --page 1 --limit 200 --state active -o json | jq -r '.leases | length'); DCOST=$(provider-services query market lease list --height $BLOCK --provider $PROVIDER --gseq 0 --oseq 0 --page 1 --limit 200 -o json --state active | jq --argjson bt $BLOCK_TIME -c -r '(([.leases[].lease.price.amount // 0|tonumber] | add)*(60/$bt)*60*24)/pow(10;6)'); BALANCE=$(provider-services query bank balances --height $BLOCK $PROVIDER -o json | jq -r '.balances[].amount // 0|tonumber/pow(10;6)'); IN_ESCROW=$(echo "($AL * 5)" | bc); TOTAL=$( echo "($BALANCE+$IN_ESCROW)" | bc); printf "%8d\t%.32s\t%4d\t%12.4f\t%12.6f\t%4d\t%12.4f\n" $BLOCK $HT $AL $DCOST $BALANCE $IN_ESCROW $TOTAL; done
```

### Example Output

* Column Headers

```
block height, timestamp, active leases, daily earning, balance, AKT in escrow, total balance (AKT in escrow + balance)
```

* Output generated from `Example Command Use`

```
 6514611	2022-06-28T15:32:53.445887205Z	  52	    142.8624	 1523.253897	 260	   1783.2539
 6500457	2022-06-27T15:56:52.370736803Z	  61	    190.8000	 1146.975982	 305	   1451.9760
 6486303	2022-06-26T15:25:08.727479091Z	  38	    116.9280	 1247.128473	 190	   1437.1285
 6472149	2022-06-25T15:18:50.058601546Z	  39	    119.3184	 1211.060233	 195	   1406.0602
 6457995	2022-06-24T15:17:19.284205728Z	  56	    186.8688	 1035.764462	 280	   1315.7645
 6443841	2022-06-23T14:51:42.110369321Z	  50	    182.6352	 1005.680589	 250	   1255.6806
 6429687	2022-06-22T14:58:52.656092131Z	  36	    120.3984	  962.763599	 180	   1142.7636
 6415533	2022-06-21T15:04:57.22739534Z	  29	    226.7568	  837.161130	 145	    982.1611
 6401379	2022-06-20T15:08:17.114891411Z	   8	     57.5136	  760.912627	  40	    800.9126
 6387225	2022-06-19T15:12:16.883456449Z	   6	     53.9856	  697.260245	  30	    727.2602
 6373071	2022-06-18T15:16:16.007190056Z	   6	    257.1696	  635.254956	  30	    665.2550
 6358917	2022-06-17T15:20:52.671364197Z	   5	     33.2208	  560.532818	  25	    585.5328
```

## AKT Total Earned by Provider

Use the commands detailed in this section to gather the total earnings of your provider&#x20;

### Command Template

Issue the commands in this section from any machine that has the [Akash CLI ](../../guides/cli/detailed-steps/)installed.

* **Note** - ensure queries are not limited only to leases created by your account by issuing `unset AKASH_FROM` prior to the `akash query market` command execution

```
provider-services query market lease list --provider <PROVIDER-ADDRESS> --page 1 --limit 1000 -o json | jq -r '([.leases[].escrow_payment.withdrawn.amount|tonumber] | add) / pow(10;6)'
```

### **Example Command Use**

```
provider-services query market lease list --provider akash1yvu4hhnvs84v4sv53mzu5ntf7fxf4cfup9s22j --page 1 --limit 1000 -o json | jq -r '([.leases[].escrow_payment.withdrawn.amount|tonumber] | add) / pow(10;6)'
```

### Example Output

```
8.003348
```

## AKT Total Earning Potential Per Active Deployment

### Legend for Command Syntax

In the equations used in the calculation of earning potential, several figures are used that are indeed not static.&#x20;

For accurate earning potential based on today's actual financial/other realities, consider if the following numbers should be updated prior to command execution.

#### Figures in Current Command Syntax

* 1.79 price of 1 AKT in USD
* 6.088 block time (current available via: [https://mintscan.io/akash](https://mintscan.io/akash))
* 30.436875 used as the average number of days in a month\


### Command Syntax

Issue the commands in this section from any machine that has the [Akash CLI](broken-reference) installed.

**Note** - ensure queries are not limited only to leases created by your account by issuing `unset AKASH_FROM` prior to the `akash query market` command execution

```
provider-services query market lease list --provider <PROVIDER-ADDRESS> --gseq 0 --oseq 0 --page 1 --limit 100 --state active -o json | jq -r '["owner","dseq","gseq","oseq","rate","monthly","USD"], (.leases[] | [(.lease.lease_id | .owner, .dseq, .gseq, .oseq), (.escrow_payment | .rate.amount, (.rate.amount|tonumber), (.rate.amount|tonumber))]) | @csv' | awk -F ',' '{if (NR==1) {$1=$1; printf $0"\n"} else {$6=(($6*((60/6.088)*60*24*30.436875))/10^6); $7=(($7*((60/6.088)*60*24*30.436875))/10^6)*1.79; print $0}}' | column -t
```

### Example Command Use

```
provider-services query market lease list --provider akash1yvu4hhnvs84v4sv53mzu5ntf7fxf4cfup9s22j --gseq 0 --oseq 0 --page 1 --limit 100 --state active -o json | jq -r '["owner","dseq","gseq","oseq","rate","monthly","USD"], (.leases[] | [(.lease.lease_id | .owner, .dseq, .gseq, .oseq), (.escrow_payment | .rate.amount, (.rate.amount|tonumber), (.rate.amount|tonumber))]) | @csv' | awk -F ',' '{if (NR==1) {$1=$1; printf $0"\n"} else {$6=(($6*((60/6.088)*60*24*30.436875))/10^6); $7=(($7*((60/6.088)*60*24*30.436875))/10^6)*1.79; print $0}}' | column -t
```

### Example Output

```
"owner"                                         "dseq"     "gseq"  "oseq"  "rate"                  "monthly"  "USD"

"akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn"  "5850047"  1       1       "4.901120000000000000"  1.92197    3.44032
"akash1n44zc8l6gfm0hpydldndpg8n05xjjwmuahc6nn"  "5850470"  1       1       "2.901120000000000000"  1.13767    2.03643
```

## Current Leases: Withdrawn vs Consumed

Use the commands detailed in this section to compare the amount of AKT consumed versus the amount of AKT withdrawn per deployment.  This review will ensure that withdraw of consumed funds is occurring as expected.

### Command Syntax

Only the following variables need update in the template for your use:

* AKASH\_NODE - populate value with the address of your RPC node
* PROVIDER - populate value with your provider address

```
export AKASH_NODE=<your-RPC-node-address>

PROVIDER=<your-provider-address>; HEIGHT=$(akash query block | jq -r '.block.header.height'); provider-services query market lease list --height $HEIGHT --provider $PROVIDER --gseq 0 --oseq 0 --page 1 --limit 10000 --state active -o json | jq --argjson h $HEIGHT -r '["owner","dseq/gseq/oseq","rate","monthly","withdrawn","consumed","days"], (.leases[] | [(.lease.lease_id | .owner, (.dseq|tostring) + "/" + (.gseq|tostring) + "/" + (.oseq|tostring)), (.escrow_payment | (.rate.amount|tonumber), (.rate.amount|tonumber), (.withdrawn.amount|tonumber)), (($h-(.lease.created_at|tonumber))*(.escrow_payment.rate.amount|tonumber)/pow(10;6)), (($h-(.lease.created_at|tonumber))/((60/6)*60*24))]) | @csv' | awk -F ',' '{if (NR==1) {$1=$1; printf $0"\n"} else {block_time=6; rate_akt=(($4*((60/block_time)*60*24*30.436875))/10^6); $4=rate_akt; withdrawn_akt=($5/10^6); $5=withdrawn_akt; $6; $7; print $0}}' | column -t 
```

### Example Command Use

```
PROVIDER=akash18ga02jzaq8cw52anyhzkwta5wygufgu6zsz6xc; HEIGHT=$(akash query block | jq -r '.block.header.height'); provider-services query market lease list --height $HEIGHT --provider $PROVIDER --gseq 0 --oseq 0 --page 1 --limit 10000 --state active -o json | jq --argjson h $HEIGHT -r '["owner","dseq/gseq/oseq","rate","monthly","withdrawn","consumed","days"], (.leases[] | [(.lease.lease_id | .owner, (.dseq|tostring) + "/" + (.gseq|tostring) + "/" + (.oseq|tostring)), (.escrow_payment | (.rate.amount|tonumber), (.rate.amount|tonumber), (.withdrawn.amount|tonumber)), (($h-(.lease.created_at|tonumber))*(.escrow_payment.rate.amount|tonumber)/pow(10;6)), (($h-(.lease.created_at|tonumber))/((60/6)*60*24))]) | @csv' | awk -F ',' '{if (NR==1) {$1=$1; printf $0"\n"} else {block_time=6; rate_akt=(($4*((60/block_time)*60*24*30.436875))/10^6); $4=rate_akt; withdrawn_akt=($5/10^6); $5=withdrawn_akt; $6; $7; print $0}}' | column -t 
```

### Example Output

```
"owner"                                         "dseq/gseq/oseq"  "rate"  "monthly"  "withdrawn"  "consumed"  "days"
"akash1zrce7fke2pxmnrwlwdjxcgyfcz43vljw5tekr2"  "6412884/1/1"     23      10.0807    2.33866      2.358627    7.121458333333333
"akash1ynq8anzujggr7w38dltlx3u77le3z3ru3x9vez"  "6443412/1/1"     354     155.155    25.1846      25.49154    5.000694444444444
"akash1y48wwg95plz4ht5sakdqg5st8pmeuuljw6y9tc"  "6503695/1/1"     45      19.7231    0.488925     0.527895    0.8146527777777778
"akash1ga6xuntfwsqrutv9dwz4rjcy5h8efn7yw6dywu"  "6431684/1/1"     66      28.9272    5.47028      5.527302    5.815763888888889
"akash1f9mn3dhajkcrqxzk5c63kzka7t9tur3xehrn2r"  "6426723/1/1"     69      30.2421    6.06048      6.120024    6.1594444444444445
"akash12r63l4ldjvjqmagmq9fe82r78cqent5hucyg48"  "6496087/1/1"     114     49.9652    2.10661      2.204874    1.343125
"akash12r63l4ldjvjqmagmq9fe82r78cqent5hucyg48"  "6496338/1/1"     98      42.9525    1.78683      1.871212    1.3259722222222223
"akash1tfj0hh6h0zqak0fx7jhhjyc603p7d7y4xmnlp3"  "6511999/1/1"     66      28.9272    0.169422     0.226182    0.23798611111111112
```
