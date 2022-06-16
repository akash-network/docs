# Chia on Akash

## Why use Akash?

Welcome [Chia](https://www.chia.net/) community! We are excited to announce support for Chia on the [Akash](https://akash.network/) network! You can now run nodes, plotting, and farming on our marketplace of compute. Below you will find details on how to configure your deployment for different use cases. Akash is a part of the [Cosmos](https://cosmos.network/) ecosystem of blockchains.

## Summer Sale

![](<../.gitbook/assets/Summer Sale for Chia Plots 5.png>)

## Demo

{% embed url="https://www.youtube.com/watch?v=HLhrSeDemBI" %}
Jonmichael Hands - VP of Storage Business Development at Chia
{% endembed %}

{% embed url="https://youtu.be/RY2cjiizk5k?t=1434" %}
Andrew Mello - Head of Mining at Akash
{% endembed %}

{% embed url="https://www.youtube.com/watch?v=xCNoXI6_Tf8" %}
@DigitalSpaceport
{% endembed %}

## Windows/Linux/Mac Users

1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en) wallet as a browser plugin&#x20;
2. Install [Akashlytics](https://akashlytics.com/deploy) and import your AKT wallet address from Keplr.&#x20;
3. [Fund your wallet](https://github.com/ovrclk/awesome-akash/tree/chia/chia#Quickest-way-to-get-more-AKT)

For additional help we recommend you [follow our full deployment guide](../guides/deploy/akashlytics-deploy-installation.md) in parallel with this guide.

## How does this work?

Akash uses its blockchain to manage your container deployment and accounting. To deploy on Akash you will need to fund your wallet with at least 10 AKT.  Each time you create a deployment, 5 AKT will be used for escrow and to fund the deployment.  If the deployment is canceled, the balance of the escrow is returned to you.  You can spin up deployments without worrying about any long term contracts and you can cancel anytime.

## Default wallet

Akash uses [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en) as the desktop wallet. Advanced users can follow the [CLI instruction](../guides/cli/)s.

Once you have set up your Keplr wallet and imported the address to Akashlytics you are ready to create your first deployment. Follow the instructions in Akashlytics to create a certificate, then click on _Create Deployment_.

## Quickest way to get more AKT

To fund your deployment you will need AKT in your account. The fastest way to do that is in one of the following two ways.

### Buy on an Exchange

1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en)&#x20;
2. Buy AKT on an [exchange](https://www.coingecko.com/en/coins/akash-network#markets)&#x20;
3. Withdraw your AKT to your Keplr wallet

### Swap from ATOM to AKT

1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en)
2. Send 10 ATOM to your new Cosmos wallet address inside Keplr (this address will start with cosmos)
3. Go to [Osmosis Assets](https://app.osmosis.zone/assets) > next to Cosmos Hub - ATOM click on Deposit.  This step will deposit ATOM from your Keplr wallet onto the Osmosis platform.  Press Connect Wallet to connect your Keplr wallet to Osmosis.
4. Now go back to [Osmosis Homepage](https://app.osmosis.zone/?from=ATOM\&to=AKT) and ensure ATOM > AKT is selected to complete the swap.  This step swaps your ATOM you deposited onto the Osmosis platform into any other supported coin.
5. Return to the [Osmosis Assets](https://app.osmosis.zone/assets) page to withdraw your AKT to your Keplr wallet.  This step withdraws AKT from the Osmosis platform back into your Keplr wallet.  You can now send AKT to Akashlytics.

Have more questions? Find our team in [Discord](https://discord.com/invite/DxftX67) and [Telegram](https://t.me/AkashNW).



## MadMax Disk Plotting

**Recommended MadMax CPU Settings for 1Gbps Connections:**\
****\~75 minute plots = 8 cpu / 715Gi Storage

```yaml
---
version: "2.0"

services:
  chia:
    image: cryptoandcoffee/akash-chia:199
    expose:
      - port: 8080
        as: 80
        proto: tcp
        to:
          - global: true
    env:
    #############################REQUIRED##############################
      - VERSION=1.3.5 
     #Always check https://github.com/Chia-Network/chia-blockchain/releases
      - CONTRACT=xch16txqvdlh67m9stvwmx848xzpgesd60swqxll3rrnnafunuluflds03jkt4
      - FARMERKEY=847b826e653279b9e54ce66a1c55cbfdb1ddc4118e70038cdfbaa7e5cb0a785087bc3a6f055f01bbbf84a2c6a3be4a97
      - PLOTTER=madmax
     #Choose your plotter software - madmax, bladebit, bladebit-disk
      - FINAL_LOCATION=upload
     #Set to "local" to access finished plots through web interface.
     #Set to "upload" and finished plots will be uploaded to a SSH destination like user@ip:/home/user/plots
      - CPU_UNITS=8
      - MEMORY_UNITS=6Gi
      - STORAGE_UNITS=715Gi
     #Must match CPU/Memory/Storage units defined in resources.
    #############################OPTIONAL##############################
     #Uncomment the variables below when set FINAL_LOCATION=upload to enable remote uploading
      #- REMOTE_HOST=changeme.com #SSH upload host
      #- REMOTE_LOCATION=changeme #SSH upload location like /root/plots
      #- REMOTE_PORT=22 #SSH upload port
      #- REMOTE_USER=changeme #SSH upload user
      #- REMOTE_PASS=changme #SSH upload password
      #- UPLOAD_BACKGROUND=true
     #Change to true to enable multiple background uploading of plots, this is the best option to use use 100% of your bandwidth.
      #- RAMCACHE=32G
      #Used only for PLOTTER=bladebit-disk, you must increase the memory resources requested below with this additional cache size.
      #- RCLONE=true
     #When true must also update JSON_RCLONE and add any destination in same format.
      #- TOTAL_UPLOADS=1000
     #Set the total number of parallel uploads allowed to an rclone destination
      #- ENDPOINT_LOCATION=google
     #Only used for RCLONE=true
      #- ENDPOINT_DIR=plots 
     #Only used for RCLONE=true
      #- JSON_RCLONE=
      #  [google]\n
      #  type = x\n
      #  scope = x\n
      #  token = x\n
      #  root_folder_id = x
     #Example of STORJ config for RCLONE=true.  If you want to use your own endpoint please escape each line with a backslash n, like in the example.
profiles:
  compute:
    chia:
      resources:
        cpu:
          units: 8.0
        memory:
          size: 6Gi
        storage:
          size: 715Gi
  placement:
    akash:
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      attributes:
        chia-plotting: "true"
      pricing:
        chia:
          denom: uakt
          amount: 100000
deployment:
  chia:
    akash:
      profile: chia
      count: 1
```

## Bladebit RAM Plotting

Plotting with Bladebit has never been easier!  There are a few things to note before you start using Bladebit instead of Madmax.  Bladebit is so fast it can create plots faster than most home/consumer internet connections (1Gbps) can download them.  To compensate for this we can adjust the Bladebit plotting speed by changing the CPU count of the deployment.\
\
**Recommended Bladebit CPU Settings for 1Gbps Connections:**\
****\~20 minute plots = 8 cpu / 915Gi Storage\
\~15 minute plots = 16 cpu / 915Gi Storage\
\~10 minute plots = 32 cpu / 2Ti Storage\
\
**Recommended Bladebit CPU Settings for Multi-Gigabit Connections:**\
****\~7 minutes plots = 64 CPU / 2Ti Storage\
\~4 minutes plots = 100 cpu / 4Ti Storage\
\~3 minutes plots = 186 cpu / 6Ti Storage

\
For a standard 1Gbps connection use the settings below, otherwise adjust the CPU units to match the plot time you want to achieve.

```yaml
---
version: "2.0"

services:
  chia:
    image: cryptoandcoffee/akash-chia:199
    expose:
      - port: 8080
        as: 80
        proto: tcp
        to:
          - global: true
    env:
    #############################REQUIRED##############################
      - VERSION=1.3.5 
     #Always check https://github.com/Chia-Network/chia-blockchain/releases
      - CONTRACT=
      - FARMERKEY=
      - PLOTTER=bladebit
     #Choose your plotter software - madmax, bladebit, bladebit-disk
      - FINAL_LOCATION=upload
     #Set to "local" to access finished plots through web interface.
     #Set to "upload" and finished plots will be uploaded to a SSH destination like user@ip:/home/user/plots
      - CPU_UNITS=32
      - MEMORY_UNITS=430Gi
      - STORAGE_UNITS=1200Gi
     #Must match CPU/Memory/Storage units defined in resources.
    #############################OPTIONAL##############################
     #Uncomment the variables below when set FINAL_LOCATION=upload to enable remote uploading
      #- REMOTE_HOST=changeme.com #SSH upload host
      #- REMOTE_LOCATION=changeme #SSH upload location like /root/plots
      #- REMOTE_PORT=22 #SSH upload port
      #- REMOTE_USER=changeme #SSH upload user
      #- REMOTE_PASS=changme #SSH upload password
      #- UPLOAD_BACKGROUND=true
     #Change to true to enable multiple background uploading of plots, this is the best option to use use 100% of your bandwidth.
      #- RAMCACHE=32G
      #Used only for PLOTTER=bladebit-disk, you must increase the memory resources requested below with this additional cache size.
      #- RCLONE=true
     #When true must also update JSON_RCLONE and add any destination in same format.
      #- TOTAL_UPLOADS=1000
     #Set the total number of parallel uploads allowed to an rclone destination
      #- ENDPOINT_LOCATION=google
     #Only used for RCLONE=true
      #- ENDPOINT_DIR=plots 
     #Only used for RCLONE=true
      #- JSON_RCLONE=
      #  [google]\n
      #  type = x\n
      #  scope = x\n
      #  token = x\n
      #  root_folder_id = x
     #Example of STORJ config for RCLONE=true.  If you want to use your own endpoint please escape each line with a backslash n, like in the example.
profiles:
  compute:
    chia:
      resources:
        cpu:
          units: 32
        memory:
          size: 430Gi
        storage:
          size: 1200Gi
  placement:
    akash:
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      attributes:
        chia-plotting: "true"
      pricing:
        chia:
          denom: uakt
          amount: 100000
deployment:
  chia:
    akash:
      profile: chia
      count: 1
```

## Downloading  plots

To access the Chia Plot Manager, click on the \`Uri\` link on the deployment detail page.  \
To download plots, click an invididual plot in the Chia Plot Manager and click on Download/Open.

![Chia Plot Manager](<../.gitbook/assets/image (5).png>)

\*Once your download has finished - Delete the plot from the container - to make room for new plots!  Plots will continue to be created as long as there is enough free space available in the container (Max 1Tb) and the deployment is fully funded.&#x20;

## Speed up downloads

Windows/Mac/Linux : Use a download manager like [DownThemAll](https://www.downthemall.net/) on Chrome/Firefox/Opera\
Linux/CLI: Use [aria2](https://aria2.github.io/) : `apt-get install aria2`

```
aria2c -c -s 16 -x 16 -k 64M -j 1 $plot_download_url
```

## Choosing a provider

Akash has partnered with Chia to provide $0.20/plots on `Bigtractorplotting.com.`

## Waiting for bids...

If Akashlytics hangs on "Waiting for Bids" that could be an indication that all providers are full at the moment.  The recommended fix is to reduce the requested storage amount from `1Ti` to something more reasonable like `768Gi`

```
profiles:
  compute:
    chia:
      resources:
        cpu:
          units: 8.0
        memory:
          size: 6Gi
#Chia blockchain is currently ~40gb as of November 2021 / if you are plotting please use at least 256Gi
        storage:
          size: 768Gi
```

## How to speed up plotting?

### Use only providers with the _chia-plotting_ attribute

To limit the selection of providers to those with fast storage that meets the requirements for plotting, we recommend you keep the _chia-plotting_ attribute to the placement section of deploy.yaml file.

```
placement:
  akash:
    attributes:
      chia-plotting: "true"
    pricing:
      chia:
        denom: uakt
        amount: 100000
```

### Create more deployments

Easily scale your total plotting output by creating a new deployment.  Click the three dots next to the Add Funds button on the deployment details page and click Redeploy. &#x20;
