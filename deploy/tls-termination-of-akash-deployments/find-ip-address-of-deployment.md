# Find IP Address of Deployment

We will need to lookup the IP address of the deployment to later use in the Cloudflare configuration

### Domain of the Deployment

* Find the domain name of the deployment in the Cloudmos Deployment Detail page

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-LrNFlfuifzmQ\_NMKu9C-887967055%2Fuploads%2F1OLAZX7ITvAbCClUClxb%2FcloudflareURL.png?alt=media\&token=c3a3e6f0-5e71-49dc-8688-afe8a58d57a8)

### IP Address of Deployment

* From your terminal ping the domain name of the deployment and the IP address will be revealed
* In the example shown the IP address is listed as `147.75.75.107`

```
scarruthers@Scotts-MacBook-Pro ghost % ping t2ns2f7105b7t38aukju1calp4.ingress.provider-2.prod.ewr1.akash.pub

PING t2ns2f7105b7t38aukju1calp4.ingress.provider-2.prod.ewr1.akash.pub (147.75.75.107): 56 data bytes

64 bytes from 147.75.75.107: icmp_seq=0 ttl=53 time=47.975 ms
64 bytes from 147.75.75.107: icmp_seq=1 ttl=53 time=49.651 ms
64 bytes from 147.75.75.107: icmp_seq=2 ttl=53 time=51.948 ms
```
