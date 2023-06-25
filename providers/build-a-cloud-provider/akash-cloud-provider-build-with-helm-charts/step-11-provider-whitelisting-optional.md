# STEP 11 - Provider Whitelisting (Optional)

## Overview

* Akash Provider deployment address Whitelist functionality is now enabled in the bid price script
* To use it simply specify the list via whitelist\_url attribute as detailed in this section
* Complete the steps in this section to enable/customize Akash Provider Whitelisting

## Update the Akash Helm-Charts Repo

```
helm repo update akash
```

## Verify Akash/Provider Helm Chart is 4.3.4 Version or Higher

```
helm search repo akash/provider
```

#### Expected/Example Output

```
# helm search repo akash/provider
NAME              CHART VERSION    APP VERSION    DESCRIPTION                          
akash/provider    4.3.4            0.2.1          Installs an Akash provider (required)
```

## Download Bid Price Script Which Supports Whitelisting

```
wget https://raw.githubusercontent.com/akash-network/helm-charts/main/charts/akash-provider/scripts/price_script_generic.sh
```

## Prepare the Whitelist

* Example whitelist hosted on GitHub Gist can be found [here](https://gist.github.com/andy108369/1fa6cfa81674bce438a450d6c14395ea)

## Specify the Bid Price Script and Whitelist URL

> _**NOTE**_ - Whitelist will only work when `bidpricescript` is also set.  
> _**NOTE**_ - You need to specify the direct link to the whitelit (with Github Gist you need to click Raw button to get it)

```
helm upgrade --install akash-provider akash/provider -n akash-services -f provider.yaml \
--set bidpricescript="$(cat /root/provider/price_script_generic.sh | openssl base64 -A)" \
--set whitelist_url=https://gist.githubusercontent.com/andy108369/1fa6cfa81674bce438a450d6c14395ea/raw/9181887be8e3e019b58e5dc8e7fce4ae0a66eeec/whitelist.txt
```
