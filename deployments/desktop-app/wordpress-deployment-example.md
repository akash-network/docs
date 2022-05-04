# WordPress Deployment Example

In this section we will use the tool to deploy our own example WordPress page on the Akash Network. You can follow the same process for any other workload so long as it is containerized and you have an appropriate SDL.

#### **STEP1 -  Create the Deployment**

* From the Deployments pane click the “CREATE DEPLOYMENTS” button.

![](https://lh3.googleusercontent.com/cITOXBIBZWEZe7vFJfQYpzHEO6ZS8K4FPCI5mpRDAYFzdZ9FIV7dJtvUY8THbd7ll3UqpKjEd6ZdWb0EdUvUAdNXzea40JpXe9CoBR22NpfOge2AwtTuwmnJyVpdiHK2U2XMVNf8=s0)

#### **STEP2 -  Checking Deployment Pre-Reqs**

* Before getting started make sure you have met the following requirements:
  * 5AKT are available in wallet/escrow account.&#x20;
  * Valid certificate (on chain and matching cert locally)
* If everything is in order click the “CONTINUE” button

![](https://lh3.googleusercontent.com/19ivZkQtByvta\_6a8lV8nuPnxtn8PDcv6a65pSLansGB1JOsdVCcNWPk8pBLcRAzuZ\_Qdc3r9WaahdPj9vVCnXea5dBS-p3GekVPBAbo0uodNUb5tsEBSopdv4XjPhKXVPHV0Jkv=s0)

#### **STEP3 -  Choose Template**

* The tool provides several sample templates including Games (Supermario, Minecraft, etc), and some more general (WordPress, Hello-World, etc)
* To deploy a custom application select the Empty template option
* Press “CONTINUE” with the WordPress template selected

![](https://lh6.googleusercontent.com/70YVBS9Q\_lB5j7mHDnwcC8iNFJT6ueqarfPG9\_BnDcvmcBwgHDG24RyiTJDvbbvq-HngUgMnC05-Cex6QeiM-VbBxBIs78259J\_NUgexDIrkOfNBsfQ203WqwbGR1FC0b\_9MBx99=s0)

#### **STEP4 -  Create Deployment**

* If you select a empty template now would be the time to paste in your SDL
* For this example we will be making a small change to the example SDL file. Change the domain name in the SDL’s “expose” section.
  * In a production system we would want a real domain name. Since this is an example we can use something fake.

![](https://lh5.googleusercontent.com/snngoD7lecf77Y5PZBjqfrnhCTCxgm555meZRGl4oPQX8yZXsv0im7JEbNYGGF46wRiFmLSokFIoSVkP4rGGBwKSnx6vaIzejiGKz\_-XR8VFoUGhr-TZ1-lZakr68744b-iS5IBt=s0)

* Once you have changed the domain name, enter a name for your deployment in the bottom pane and press “CREATE DEPLOYMENT”.

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
