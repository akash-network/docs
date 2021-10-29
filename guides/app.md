# Akashlytics Deploy (Desktop App)

## **Akashlytics Deploy Overview**

The Akashlytics Deploy Tool is a desktop application which simplifies the deployment process on the Akash Network.  Post deployment the tool provides a dashboard to view the status and details of workloads.  The dashboard also has the ability to perform administrative tasks including closing the deployment, updating the deployment, redeploying, and increasing the funding available to the deployment.

This guide will cover the following topics:

* Akashlytics Deploy Installation and Initial Configuration
  * Installation package download instructions
  * Installation on MacOS
  * Installation on Windows
  * Configuration
* Walkthrough of a example WordPress deployment using the tool
* Teardown and cleanup of the example app

## **Akashlytics Deploy Installation**

### **Software Access and Download Instructions**

The Akashlytics Deploy software may be found at the project’s documentation here.

[**https://www.akashlytics.com/deploy**](https://www.akashlytics.com/deploy)

![](https://lh5.googleusercontent.com/\_pjwvet6jDYdwGhkthqAOggo0lGUgHke0SaHtFpKaSqXHJBEwbAu2H1pg4q7KqV4uIeKRP-q6-bk\_T3HtSjf7poU62Kwn8RsJIdB\_gN9KQ0xJXSnT90M-crUNOM4XY8MlclIjuQF=s0)

### **MacOS Installation Details**

#### **STEP1 - Locate the Downloaded DMG File**

* After completing the download find the MacOS DMG in the Downloads directory.
* Locate the DMG and double-click.

![](https://lh6.googleusercontent.com/iATssC490Hng7W5luV\_iB8ahwTvlVx3rMIb5PJoDgOAyUHd1LOOKDd2L5NnuPXd9K2B8FeMhI1O4a4GlyYuO2r4JmN2nBHSa2koUNJ4FU8EIGOOAxBqTYgz\_Up61w06z2MtFDWMt=s0)

#### **STEP2 - Move Akashlytics Deploy to the Applications Directory**

* After installation - MacOS will prompt the user to move the Akashlytics Deploy shortcut to the Applications directory
* Drag and drop the Akashlytics Deploy icon into the Applications folder from the prompt

![](https://lh4.googleusercontent.com/IhoAr8KXuGMFDgZE8TGgZRPHnk3huaxw-jX3vf5i6WF9aHvu3Gb5vbgFViFbXp4iYkUUvEkU4Cjk0AHKDd5gU\_2CBNBKeDJm3Q2OUgnRFw5K4ndey2bNXh9J6WcWBsU3-W5u1r\_e=s0)

#### **STEP3 - Launching the Tool**

* With the installation completed - open MacOS Finder and type “akashlytics deploy”
* Double click the Akashlytics Deploy icon

![](https://lh4.googleusercontent.com/MBeLz1wziLAqCO6PQ3bKwgjdiR4wcvMiycKSWDs-YMBBZeD\_YMXumAw7e7QRhY4zVrsIeXJG2KRCCFFODFqqT2CxbmakFM-CJh1Llo7uivuSfgbyYeGdVUzb6aldHkIUQWyQD7wk=s0)

#### **STEP4 - Override MacOS Unidentified Developer Warning**

When first launching Akashlytics Deploy your mac will have an “unidentified provider” warning preventing the application from launching.  As this software is created, maintained by the Akash community and can be trusted as such.  To get past this prompt do the following

* Click the Question Mark (“?”) icon provided on the warning message.

![](https://lh6.googleusercontent.com/arJiEJgSGuz0oqbKXt7q5Phd9GyvNSyWN73A19oqogZNgYgwOWCV9t8sTHhElovI03YP5uttf2pDNEKNieTeDXBew1KaZNh1CnOuRb2EpZFsWovjEI4AsovSTi6rsKJOoqwuvMMs=s0)

* Press “Ok” to exit the warning message dialog box and follow the instructions that pop up.

![](https://lh4.googleusercontent.com/sYSIOWncayYLyaClOtxcFtIZM42RSR2sOurIiIVLWi5zWh\_6-ijwli9lJKIJ8vpgGGJnVAFgL1y5ygmQm-DbSEMKEyAcsofuKh6SWGHCYm1RIbWvlBAO\_wWG1bv6Hq2aKXneRS-1=s0)

* Locate App within the MacOS Finder utility and Control-Click the icon
* Select “Open”

![](https://lh4.googleusercontent.com/QnaI15EOGA\_OA1wOzaATAHR3NHiQVdjDTgwKCR943T4-xPMew1f7Pab\_kFvvp7doAmmsNROn2kmSVVBpM2LEbxBMkVKq2V1JjAgl2ufogQlw4no\_qcsdGop4DGcJFV8XxrB9pZVW=s0)

* ** **You will be prompted with an “unidentified developer” dialog box
* Click the “Open” button.

![](https://lh6.googleusercontent.com/6E6GPuZTqEr78CicCBJvU5hS8\_KgJa8LmYpfQyXZiToqeWvzhHwIwlRR8f4Zq5E\_y9hKKPub8ild6XSCSau\_HzPmwLacoW76xxTP2QT3ixrGOpTiWU\_J5Rmr677Aem7thWmUhzWH=s0)

### **Windows Installation**

Note: The installation steps captured in the steps and screenshots that follow were conducted on a Windows Server instance but the application install should be nearly identical on other Windows Platforms (I.e. Windows 10).

#### **STEP1 - Launch the Installer**

* Find the installer on your computer and double click

![](https://lh6.googleusercontent.com/N\_qb4pKmkRKHGq\_dDshrznrJXQx1TUXyPjpFfMjgFbtoFh2jX-9CLauLp3EKPyLek2uilQdyiS\_87Vs1jGVr4PdFDhm8-DDKJTyQGSe-rJqGUDpeR7E3Bo6NB\_yV-5BdFUXjAMCI=s0)

**STEP2 - Windows Defender Warning**

Depending on the Operating System version and installed/enabled security tools - Windows Defender may pop up with an “unrecognized app” message.  As this software is created, maintained by the Akash community and can be trusted as such.  We can get past this with the following steps.

* Expand the available options on the warning prompt and select “Run anyway”

![](https://lh3.googleusercontent.com/GzzI3N0uOSMqDUDR4oDEm1EbiH75wIJ\_ctzaSwtQzEjlcn5Nq8q8QfkFpN5XCOlyc1l40Wibv5nlS8T3cDQ6VQtJs1xPqeRWfFwU6vuSjrlMq6j\_qrkUojW\_gfjTZnxxO0jZoztk=s0)

* Feel free to use the default install options and follow the prompts.

![](https://lh4.googleusercontent.com/4l1By-gVjfWNo4x2tX7TFwKoagY67qke4O2Y6r2\_hH2dNtsxpph416ldfShLs3k5aWbfLl4Ykq-VQlUIrOAS\_S0OlPH7pGcI43zERVY8ow-d-kH5pIKKP8KbFhMlNfa1a9XLkrxC=s0)

* On the last step of the install in the “Completing Akashlytics Deploy Setup” section - check the “Run Akashlytics Deploy” option (likely selected by default) and select “Finish”.

![](https://lh3.googleusercontent.com/6Cyequp89\_MuGfOSrZtep\_nNHYpuOlpab-2Ojxbmh5alKiYsY7fdZvo0irWCJj-2FfHJ4MHthGsF3LGVZxDAXO-3SWipLbdE9LsbHk5zerqWNgK8\_bxEnkPoeAsII-Vb9WiuIHg4=s0)

### Initial Configuration

In this section we will configure the following:

* Import an Existing Wallet
* Create a Certificate to Interact With the Blockchain

#### **STEP1 - Import Existing Wallet**

* The first thing you will need is a wallet. With a mnemonic phrase you have access to.
* In the tool you can choose a name for this wallet. This will not affect the functionality of the tool but is just an easy way to track what wallet is currently in use.
* Next choose a password that you will remember for the wallet.

![](https://lh4.googleusercontent.com/dCDPg7h0GCboGGryK5QgzsTk8ngnsoRimfS6MJ9cx7vPWx1G40FSeGu2rAj8w-YiLsgSyD9OTDlNZTg1ZEJjZLcNMjAbP2vajnDAE\_RETz6XLF1JDnGW64DQg2ujaVwNXIrEkDVU=s0)

Note: The funds available in the pre-existing wallet instance should now be available to Akashlytics and displayed in the upper left corner of the application (52.943 AKT in the provided example)

Should a need arise to delete the wallet click the ellipsis (triple dot icon) to the right of the wallet instance on this screen and select the delete option

#### **STEP2 - Certificate Creation**

When first launching the tool there will not be a valid certificate.  To fix this select the ellipsis to the right of the Certificate status and click “Create Certificate”

![](https://lh5.googleusercontent.com/D1Pq065Fv5vZesW6t2gj0UQzWVNy5k-9HM3ehq9oQQNfb7O0JJHgyYHvXECUvg2vUjg82K7XBNAZx\_MgevWi1aRJFgPNLMiV1TPxr9vyoXqpdKb5GPUxRjMmuUT6iKzO1Wb0lVlA=s0)

## **Create a Deployment**

In this section we will use the tool to deploy our own example WordPress page on the Akash Network. You can follow the same process for any other workload so long as it is containerized and you have an appropriate SDL.

#### **STEP1 -  Create the Deployment**

* From the Deployments pane click the “CREATE DEPLOYMENTS” button.

![](https://lh3.googleusercontent.com/cITOXBIBZWEZe7vFJfQYpzHEO6ZS8K4FPCI5mpRDAYFzdZ9FIV7dJtvUY8THbd7ll3UqpKjEd6ZdWb0EdUvUAdNXzea40JpXe9CoBR22NpfOge2AwtTuwmnJyVpdiHK2U2XMVNf8=s0)

#### **STEP2 -  Checking Deployment Pre-Reqs**

* Before getting started make sure you have met the following requirements:
  * 5AKT are available in wallet/escrow accountIf everything is in order click the “CONTINUE” button
  * Valid certificate (on chain and matching cert locally)
* If everything is in order click the “CONTINUE” button

![](https://lh3.googleusercontent.com/19ivZkQtByvta\_6a8lV8nuPnxtn8PDcv6a65pSLansGB1JOsdVCcNWPk8pBLcRAzuZ\_Qdc3r9WaahdPj9vVCnXea5dBS-p3GekVPBAbo0uodNUb5tsEBSopdv4XjPhKXVPHV0Jkv=s0)

#### **STEP3 -  Choose Template**

* The tool provides several sample templates including Games (Supermario, Minecraft, etc), and some more general (Wordpress, Hello-World, etc)
* To deploy a custom application select the Empty template option
* Press “CONTINUE” with the Wordpress template selected

![](https://lh6.googleusercontent.com/70YVBS9Q\_lB5j7mHDnwcC8iNFJT6ueqarfPG9\_BnDcvmcBwgHDG24RyiTJDvbbvq-HngUgMnC05-Cex6QeiM-VbBxBIs78259J\_NUgexDIrkOfNBsfQ203WqwbGR1FC0b\_9MBx99=s0)

#### **STEP4 -  Create Deployment**

* If you select a empty template now would be the time to paste in your SDL
* For this example we will be making a small change to the example SDL file. Change the domain name in the SDL’s “expose” section.
  * In a production system we would want a real domain name. Since this is an example we can use something fake.

![](https://lh5.googleusercontent.com/snngoD7lecf77Y5PZBjqfrnhCTCxgm555meZRGl4oPQX8yZXsv0im7JEbNYGGF46wRiFmLSokFIoSVkP4rGGBwKSnx6vaIzejiGKz\_-XR8VFoUGhr-TZ1-lZakr68744b-iS5IBt=s0)

* Once you have changed the domain name, enter a name for your deployment in the bottom pane and press “CREATE DEPLOYMENT”

![](https://lh3.googleusercontent.com/kuUkw36MAiq64xBgwLYUqF2Tp22UJG4LdymryZCQog2QxDrcxkfxQp-WFrgXgo6GJL\_S\_oPi3q\_EYZMr9jjdanjY9N0TuxwqQUk4iOqPHkFZKZuBRXQ47smegsyofNBgadRZCmvp=s0)

#### **STEP5 -  Create Deployment Transaction**

* Once the process has kicked off a screen will appear asking for a selection of Gas Fees and to add the request for bids on chain. Feel free to use the defaults and select the “APPROVE” button.

Note: The process to write the transaction to the chain may take a couple of minutes to complete. This is true of every step that results in a on chain transaction.

![](https://lh3.googleusercontent.com/Os4DkJBJFNg4jQRzoLit0or0fZJJfqn0y70I0CQJd2v\_EK4IYQUeWaRG9RyPr4-HSsum0zs-sg5wK6BB6Hgmb543zTmvsgr4XEgOUp90KEEbVadX4x4fH81ZMJ4XXk\_GXnBiwK62=s0)

#### **STEP6 -  Review/Accept Bids**

* After a minute or so a list of bids will display. Select the most affordable lease for this example deployment and then press “ACCEPT BID”

![](https://lh6.googleusercontent.com/n77KZpFFF\_-MKeGnk1MU0HSswyNc7mEvFWjOATz8QmFHRCxiovMbJf3FUlALQzARjZMUuMf1xmYhuQIQo5vM3FSpKmVfdZfSc9eKnTADLhibUeFCw0e64G8YpAELlb6mntyCm\_Ho=s0)

#### **STEP7 -  Create Lease Transaction**

* Just as before leave the default selection for Gas Fees and click “APPROVE”

![](https://lh5.googleusercontent.com/j4X1OOUx6jI-t5jOoO-bRCGXOyLHbVcLFCaZkbc3yDc1jUUoQl1ZcKvONW3YpItamT8HzvcRo\_iQe4xBHFptTvu2MeqF8WSAk3xlVzsSMnBqBWOiIZNiU1K610MAZlNEMaz35Dms=s0)

#### **STEP8 -  Post Deployment**

Once the process is complete you can click the Deployments tab and select the new deployment. This is where you can interact with and retrieve information about the deployment.

![](https://lh3.googleusercontent.com/hYHbU35JXkBV0GsZCg0VrIeBcIE0MJyxoPTjHUCWg-o3qhnUcHRS39p1U4kCqlrnHGMURw1U4okbXLE2Ei4lgJhI2JYHkgpa3fM0lsxXLtHkC9ZavW8QRHJKHmwBPJUooly9f1vP=s0)

* To easily navigate to the page you spun up click the icon to the right of the Akash URL

Note: The Wordpress site may take a couple of minutes to load depending on the status of the deployment

![](https://lh4.googleusercontent.com/ShhvDqBaKAEap3KywKlF8eggHb2b2wL7VVX3STX2euLxFUGvcDEdMitMexutzZIgTGrK9R78JgPrSOj3uBBFLQdUXO\_eVghvFV3e\_poO46OgZyVFG7IDY00\_OScdtwsjwWmz0-R3=s0)

## **Manage Deployments**

There are a couple important operations you can do with the deploy tool.

* Add funds to existing deployment’s Escrow Account
* Close an active deployment
* Update an active deployment

### **Deployment Dashboard Overview**

* To get an overview of what you have deployed click the Dashboard button on the left hand side of the screen

![](https://lh5.googleusercontent.com/1Q3Zdx-NO-kvbzxgNCHfLSsFXF2ES9R1B3BlJXN-VQskuGDn4tp0GkwCDjfmpd\_ay724m\_vNoveIJDFJ\_pGmVPz3ltX7\_qSmxaMIMxghkYBsrhvvfGZGGOJxLdMJUa8z8BJVkN1R=s0)

* From the deployment window you can see the resources that are dedicated to each deployment.

![](https://lh5.googleusercontent.com/PGtLDklCS5-BBmLDNAXcosnzUOnmAM4qyQwRahXoxOAyVSk0QnQe22G9Uagk1W6bsLOthavS0JzXTDJFzULvVWfuxzRJnrZ\_WJlJpZV91a36uac6FExJBJqbDx5tSloqiXpoQ8\_4=s0)

### **Add Funding to Active Deployment**

If your escrow for a deployment is running low you will need to add some funds.

* Navigate to Deployments in the left hand navigation pane and select the deployment in need of updating

![](https://lh4.googleusercontent.com/oRIKwYdsMbqdVSepMvJGh7UISvqy-\_YW4WoK9ohvakEUCkLk7JJvaHkrPpFcnTWjI4JnjRp6Ee5OTgIoPGythqID9kuuGfkKc\_ka3qRySaqQqz6pMXBBx5qGMnBQ8RbZdh15anhh=s0)

* At the top of the screen click “ADD FUNDS”

![](https://lh4.googleusercontent.com/5kGhRVBTG642h1mWjSCOOiR3XRseRBcvF9XCrbJy-aYQTbMfwCWhOJ-A1FwNNQOcZzLGaRsK6baKPxHTMDyoyUHeZSrqJrexYVNUqBUrFJgag\_E64nI7oBFDtj-Ulk3zdHmiiHow=s0)

* A dialog box will pop up allowing you to add tokens to the deployment’s escrow account
* Select the DEPOSIT button once you have put in the correct amount

![](https://lh4.googleusercontent.com/kUS0dIDN-eLJP2-C4ohVI3ql96Atm5FNlRoHvjd7lRIK0aTV8DiVSPq5LPvnGTiYSgLd0W0xgBUgmq7JhHDIN-sMHcEqOaVPfJ\_0But4RPKrYmdwUIxetN-4RJahKvOkc6KjjqBN=s0)

* As always you must confirm the gas fees and transaction to the blockchain by clicking “APPROVE”

![](https://lh5.googleusercontent.com/HK2Hw8gsWuLJ4DiH\_FvbtahEKCoSa1cL6AxdlVEEdl2XbvS8TskwkJwY2i7Rr2wY8X8Ez0LmpP249ZHdcpR5RNF04LPgAEHTMyOgawy5x6e4OSGGwMUekGTzJ2M431MUD6k0IT7j=s0)

* Notice the balance change in the escrow account for the deployment

![](https://lh6.googleusercontent.com/3M34J2JWHXlwVZyPUBvYwVb7IhkV6gsNSt9NG3v-DV7\_qqaekqxn5Fp4fURFkSMUpGAZ1JkwmB23Hk-kISaUU5L\_HeDhafIckQwqQx\_SFPn9\_Z8dvOH-awr2K8vldW-p5Po0krg5=s0)

### **Close Active Deployment**

Closing a deployment is very simple.

* Visit the Deployments pane and click the deployment you want to close
* Select the ellipsis to the right of the “ADD FUNDS” button
* Select the close button that appears.

![](https://lh3.googleusercontent.com/afqBVnGVgjXHeuxyvedV\_lAldA60xS-Jl7JpfK9STEQ89gKTRm5NCpalxg-\_xjHI72m5BMRgbD-cWUeucieOo156obgJLLgffnXVEQmL2rYBsGYyNa-I3CkKR2SIL6gZpKk5UNY1=s0)

* Confirm the transaction to the blockchain

![](https://lh6.googleusercontent.com/E\_pygnqUpwOWDvlJl-aBr0W\_jzZF\_SXAkFhibfoxcjJFO-ZOoKEgANc2BLYWZmhTLgIIprVNgyQn8Y99dEIU5C3b-UIVXTAO\_tgerEL0W\_Rsnd1T55wc3ROdfpqUabydTl7Vk3yN=s0)

The deployment should now be gone from the list.
