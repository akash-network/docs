# Creating a Deployment with the CLI Booster

In the series of  steps in this section we will create the deployment, request bids from available providers, and select the most attractive bid.

## Create Deployment

```
akash_deploy <path-to-Akash-SDL-file>
```

#### Example/Expected Output

```
root@ip-10-0-10-163:~/akashApps/helloWorld[https://rpc.akash.smartnodes.one:443][deploymentone][]$ akash_deploy /root/akashApps/helloWorld/deploy.yml

INFO: Broadcasting 'akash deployment create -y deploy.yml' transaction...
Enter keyring passphrase:
gas estimate: 110705
INFO: Waiting for the TX EB8CB0EC7A09339D8004DD6FF1CE9054189315656687B5B3D5AF70565896A22F to get processed by the Akash network
INFO: Success
```

## Select and Accept Bid

```
akash_accept
```

#### Expected/Example Output (Pre-Bid Accept)

* Select a provider of your preference by entering the number of the associated row

```
root@ip-10-0-10-163:~/akash-tools/cli-booster[http://akash-sentry01.skynetvalidators.com:26657][deploymentone][4815510-1-1]$ akash_accept

AKASH_PROVIDER was not set so let's try to pick from what's available for your deployment.
	rate	monthly	usd	dseq/oseq/gseq	provider					host
0>	5.00	2.03	$2.44	4815510/1/1	akash10fl5f6ukr8kc03mtmf8vckm6kqqwqpc04eruqa	provider.akash.world:8443
1>	3.00	1.21	$1.45	4815510/1/1	akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0	provider.provider-0.prod.ams1.akash.pub:8443
2>	4.00	1.62	$1.94	4815510/1/1	akash19yhu3jgw8h0320av98h8n5qczje3pj3u9u2amp	provider.bdl.computer:8443
3>	6.00	2.43	$2.92	4815510/1/1	akash1g8m36ge6yekgkfktl08x8vrp0nq9v0l73jzy32	provider.xch.computer:8443
4>	3.00	1.21	$1.45	4815510/1/1	akash1m7tex89ddnwp3cm63ehfzfe2kj2uxmsugtx2qc	provider.provider-0.prod.sjc1.akash.pub:8443
5>	3.00	1.21	$1.45	4815510/1/1	akash1r7y2msa9drwjss5umza854he5vwr2czunye9de	us-east01-akash.qloudit.com:8443
6>	2.00	0.81	$0.97	4815510/1/1	akash1u5cdg7k3gl43mukca4aeultuz8x2j68mgwn28e	d3akash.cloud:8443
7>	3.00	1.21	$1.45	4815510/1/1	akash1vky0uh4wayh9npd74uqesglpaxwymynnspf6a4	provider.provider-2.prod.ewr1.akash.pub:8443
8>	3.00	1.21	$1.45	4815510/1/1	akash1x32axkrtkv2et7etdwh77hj9a6vnc8un9th4e9	supernaut.ddns.net:8443
```

#### Expected/Example Out (Post Bid Selection)

```
INFO: Accepting the bid offered by akash1x32axkrtkv2et7etdwh77hj9a6vnc8un9th4e9 provider for 4748311 deployment
INFO: Broadcasting 'akash market lease create -y' transaction...
Enter keyring passphrase:
gas estimate: 442786
INFO: Waiting for the TX 5E33B27E631B0FD94BD9FB23D705B8D40F4BDC741829B0F669EC44C31ACA8A9C to get processed by the Akash network
INFO: Success
5E33B27E631B0FD94BD9FB23D705B8D40F4BDC741829B0F669EC44C31ACA8A9C
```

## Send Manifest to Provider

```
akash_send_manifest <path-to-Akash-SDL-file>
```

#### Expected/Example Output



```
root@ip-10-0-10-163:~/akash-tools/cli-booster[https://rpc.akash.forbole.com:443][deploymentone][4748311-1-1]$ akash_send_manifest /root/akashApps/helloWorld/deploy.yml

Enter keyring passphrase:
[{"provider":"akash1x32axkrtkv2et7etdwh77hj9a6vnc8un9th4e9","status":"PASS"}]
```

## Status of Deployment

```
akash_status
```

#### Example/Expected Output

```
root@ip-10-0-10-163:~/akash-tools/cli-booster[http://akash-sentry01.skynetvalidators.com:26657][deploymentone][4751918-1-1]$ akash_status

Enter keyring passphrase:
{
  "services": {
    "web": {
      "name": "web",
      "available": 1,
      "total": 1,
      "uris": [
        "scottsdgsrepprrtt.com",
        "toegk7990pcnb7jefh423r2gdk.ingress.provider-2.prod.ewr1.akash.pub"
      ],
      "observed_generation": 1,
      "replicas": 1,
      "updated_replicas": 1,
      "ready_replicas": 1,
      "available_replicas": 1
    }
  },
  "forwarded_ports": {}
}
```
