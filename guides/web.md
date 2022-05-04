# Web App

## **Akash Deploy Overview**

Akash Deploy delivers a web application allowing for easy deployment on the Akash Network.

Akash Deploy is an open-source project written in ReactJS. The repository for the application is listed below. However a demo of the app is available if you want to jump right in. For our walkthrough we will be using the [demo site](https://github.com/spacepotahto/akash-deploy-ui).

## **Prepare the Environment**

The Akash Deploy app integrates with the popular Keplr wallet. Keplr is a simple, open-source browser extension wallet for the Cosmos interchain ecosystem. It also happens to have full support for the Akash blockchain. We will cover the setup of the keplr wallet.

### **Keplr Wallet Browser Extension Guidance**

The Keplr wallet extension for Chrome may be found [here](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en#:\~:text=Keplr%20is%20a%20browser%20extension,for%20the%20Cosmos%20interchain%20ecosystem).

After you have installed the extension the Keplr wallet should appear in the browser extension tray. To open the wallet simply click on the keplr icon in the extension tray.

![](<../.gitbook/assets/KeplrWalletVerify (1).png>)

### **Ensure Adequately Funded Keplr Wallet**

* To check your funds simply open the extension and select Akash from the dropdown at the top of the app
* A minimum 5 AKT is needed to fund a deployment’s escrow account
* For the next section we will assume you have the required funds in the wallet

![](https://lh5.googleusercontent.com/DdHCWmQFBuKA4sp8wPSHX\_hhm\_UHkWfoy0QcgY4QlGPgRyXOQHMpEUDCdiNyp6gjFu\_XDwt1NVpcEgY7TgurBbgDFUeUg-LyUUm1\_vr7MmkZsDPi0UDkVp--kxJyL8h5FB5dB12U=s0)

## **Initial Akash Deploy Access and Configuration**

We will use a demo Akash Deploy site for this guide. To access the site [here](https://akashdeploy.hns.siasky.net).

If all worked as intended you should see something like this.

![](https://lh4.googleusercontent.com/f0cIAce8G3916Ln1139xhtXx-hXXgdvr2Gk8dz4o3Jf9DNMH1tzy1GX5mrgPjvXkPXAoPy1\_Nm8ItFKlr\_HKgIxVKdYAuj102L90ea4Iuo2XRcPNTLeYDYd8mdwknYC1NH\_Pzd4p=s0)

### Linking Keplr to The Deploy Tool

* When launching the tool for the first time Keplr will prompt you for permission to link the wallet to the tool.
* Go ahead and approve the link

![](https://lh5.googleusercontent.com/lADn1khoxFgKxQJRj6mKVfBi9Zrj-HRDWbIGC09jh21m3\_xW47Ss3JF\_DmTM\_fCWndW4WGza0LL1A8JgJCesb3Imnjbo1fcMs4caVP3cmrg-WUdvul7SVhr8StfyPUqRunE0QJhM=s0)

### **Create Certificate for Transactions**

The Akash Deploy instance must have access to a certificate to sign transactions placed onto the blockchain. Since this is our first time using the tool no such certificate exists. Let’s create one now.

* Click the “CERTIFICATE” tab
* In the dialog box that appears select the “CREATE” button

![](https://lh6.googleusercontent.com/M\_cUADVPBj8Xhg12WfC4l0m7tjyZQNYoLiC7EofhPgqX5uyTCcK3kIaSjgsEQJUV64G7h1hImKcvDSStWWFxBUclB70nAnw553DuOh-hak\_cgr0NsK9sbVMzHZWYZ1-n9Fi1Mj-r=s0)

* On certificate creation, Keplr will prompt to accept gas fees for the transaction.
* Accept the default gas fees by clicking the “APPROVE” button.

Note - All transaction processes that interact on chain may take a few seconds to complete.

![](https://lh4.googleusercontent.com/n6bkRDWpqL3qhaIQIZrtsZ2zh3d3VIC7ZGejfO8h\_BtzVcUhlCquK3axZj5P5YLNVWk7xPrCjgrLfYzaENu\_GQ5beZ422llr\_sA-ENgbYSuab9P6gfQcY1QYaaCA-SjSfPJGKLMv=s0)

* Once the process completes you should see a valid certificate as in the screenshot below

![](https://lh4.googleusercontent.com/4tBhrsGyIHG0RFPFdQI\_XudHmV0hVQW\_WTwHY8oXwYAr4WuJAkhppCYXsCWjp1Va\_dy4DcOJZRXKNfjfQ7LA5djX8\_6-VfH-\_5AXnDCWF1Dka8ZaIsOXdRiz3IVe\_GtIWLXx-WMK=s0)

## **Deployment of Sample Workload**

When first launched, the Akash Deploy application displays an editing pane prepopulated with Stack Definition Language (SDL) for the Lunie Light application. The sample application (Lunie Light) is a non-custodial, web wallet for Akash. This is one of many pre-built deployments to choose from. In subsequent sections, we will take a quick look at additional applications/SDLs within the Akash Deploy Gallery.

### **Steps in Application Deployment**

#### **SDL Edit/Deploy**

* Make sure you are on the “DEPLOY” page from the top toolbar and as depicted below

![](https://lh4.googleusercontent.com/w4QZ0PB7Wi\_ee-eoO1qe8Sy95Kd-LKFGLwqIQ5mOe5wYYYWDmCkE99ji2kYp4SCX0UNtXTDrT7G4boBW8Jfxc-hFUSnsNpoZupRYl9WdVyNggHZyBsbTXdvpENhdEgyKIbBI5CFa=s0)

* Akash Deploy has the default Lunie Light SDL in the code editor.
* For our example today we can simply click the “DEPLOY” button.

![](https://lh4.googleusercontent.com/zK7oHSZLutPjfHYGJnfmzfRLqQbzKYe5rmYJO9COKQT4ax\_3oCZy72uu1\_wqRRo2qMHruVSjHWGSAOojm6kTXD08A7WEx\_AP-Gbl8nvqFm1GIvVA1lX3dtU8TwpwbJdc4Jg-wQee=s0)

* Once the process starts a Keplr prompt will popup requesting acceptance of the deployment’s transaction gas fees.
* Accept the default gas fee selection to allow deployment to proceed.
* Once you have accepted the fees notice the status change to “waiting for bids” as the provider bids are collected.

![](https://lh4.googleusercontent.com/-DsAha7\_Gry6z4aFEQAaOQhWTEla9BJNrwxqMQ1qPURmArhvqoi-vUwDsoZ2-JQ24h9O2MDcQswl1mG-54BBGcHC6Oqyj-2zYLz42pE75hxMQK\_RgwWwG91j1CLZSJxKouyZUFTi=s0)

#### **Provider Selection**

* Select a provider from the list of submitted bids
* Press “SUBMIT” once the preferred provider has been selected

![](https://lh3.googleusercontent.com/Zrz73djx5-xqvt1Qj5rLH8NUJlKOCNu0Vo\_M1elSOkdKYDzharubO8lQm\_LRTdHy5wYIF8xrK9Oy9C5dT8SA8bgBiMxtCbcY4ELIxcrWoz5jCK1tpWKOQRRfaUIOruj19jQj2LUH=s0)

* A transaction gas fee prompt will pop up. Feel free to accept the defaults.
* Once a bid is accepted the status message will run through the following steps “Confirming the lease” > “Querying the provider” > “Sending the manifest” > “Querying lease status”.

![](https://lh3.googleusercontent.com/zkMddw9w4iiyau77tUR\_bp3ARPVsGAFkhIyWUvnbQH4DQ1ZBiGbc5lYAKF9Zg9yt1hnhrY6-M7uEqA2R5H9Uuzt4PQflvGWdPtdLgO1VfmNHgRV2RjOKzNIlWNTwtCXxI1CfaOse=s0)

* Once the bid has been accepted and the deployment setup an information window will pop up for the new deployment. A couple things to note:
  * Number of workload replicas
  * Available replicas
  * In the case of web services workloads the exposed URI

![](https://lh4.googleusercontent.com/X\_OZsXq9d7IRHBzw0lSWbqjvdW5z6I3a4z4WFc1AqQp\_fIvZwmRBJulZ5QO3rTFeCgNPbNKs37ORDaD5GEzl\_s5yf2aIhHk2nJHkINOyQspDnBLT4BqTNWNyIJjAV4Ohj5CrFQ1M=s0)

#### Testing Our Deployment

* Copy the URI from the popup window
  * Note - if the deployment information detail panel was closed - the URI may be found by navigating to “MY DEPLOYMENTS” from the toolbar and then clicking the info “I” icon next to the relevant deployment.

![](https://lh4.googleusercontent.com/8QKbtcSpAdWu0OMm-2e5ky4YCk4k7DVsidCOID5Izys8Kx1M2D3h6rt3xf2vFoTM92DYaEr2kyDPuVWpNbte3gEnC-s67BBcKxe5dF8JZ4hE-QHFBhPbEFzU0JxuXCubdQlbeFlG=s0)

* Paste the URI into a browser window and hit enter
  * Note - if a 502 Bad Gateway HTTP response is returned - continue refreshing the page for a few seconds as the workload may not yet be fully deployed on the provider.
* Once the page loads you should see something like this

![](https://lh4.googleusercontent.com/MXlZz\_gRmriE3O1wsZpFnTAe5iCAtcA2hLKVcdFAIDahf6Erg3bQXSdSbs6cYpj3mN3T7lcgVk5VkMUBzHRuU3yYEj7TSx0eJQucNObC1nZMF7VFNbLnPnYjPHJbfjnYFdhDCDv5=s0)

## **Manage Deployments**

With Akash Deploy you can not only deploy but also manage, monitor, and close active workloads.

Monitoring and managing deployments from Akash Deploy is often easier than performing the same operations within the Akash CLI, particularly across many deployments.

### **View Active and Inactive Deployment Details**

Akash Deploy allows you to view active and inactive deployments.

* Navigate to “MY DEPLOYMENTS” from the toolbar.

![](https://lh6.googleusercontent.com/dhsDeco-LVIudmwhpXK5UL\_CM8rSdIDngxtknEzcgRjJD5vRclt0\_a\_kXuSE8j2DSmgbn\_Mjh-zGD6SwTEOO2Py9lvb7wgEEXeF6aKTMstUiWWVPKZEEuLyTJwmF6OLrAUuTfLEl=s0)

* Toggle the “Show Inactive” button
* Active deployments are represented by a red filled circle containing a cloud icon.
* Inactive deployments are represented by a grey filled circle containing a cloud icon slashed.

![](https://lh6.googleusercontent.com/oACJ7NX58-9vs6DuR4-uVBltpQMpOLzqw7IHRewPv6bJDudWDHCgrDjqmOFytFH8rhhCVHfnMJORaRnmwXr-9uoIM0tuEWeunN9qYcz\_Ktfd76NcQCdVAt9YZNnmuuxOoAOrF0FZ=s0)

* To see additional information on an active deployment’s lease, select the information (“i”) icon.

![](https://lh5.googleusercontent.com/ZmkkOcNV0b0dmjQSpPf6Aev7SujE2BE\_lHI5EHxN4OMZvQASNrLcTfg6IHatHyt2RVB7Kr0vCwcQPpMog4xjH7oxw1UOCmjNQ3eyoSuabGJjChuVvRnrBWBl3kYDpChHwSbF8x\_O=s0)

Note that the information revealed is identical to the information first displayed when the deployment process completed and includes details such as replica count, available replicas, and URI if applicable.

![](https://lh5.googleusercontent.com/jr1tuQQKD0tLC6ULg8Bqz8FUGAX\_1Gv9Z-DnufSSXlZDYmNtyxemcWnykFp2O6exgYUKAWJF\_7HFvt6p0hdDh4vYN2rdTdrAStLDMw7oo4U4f3pR8H-5qWmTorxdS8XkZUQxOE\_q=s0)

* For a more detailed block of information regarding the deployment click on the Deployment identifier (DSEQ) or anywhere in the white space to the right of the DSEQ.

![](https://lh5.googleusercontent.com/jgKHsBMTxYbuQV-kAi4Y-R6pDXAZK5fNMmMeF4YsrKZRIRcdfSF-aFvxioIhtTpK\_HMOuCF-APvULyyekCmX0k9Gz8DCPLqco5GwzNO10YU9ioavmuUY\_d6l1dag8OzZEvcXWUzS=s0)

* The revealed information is displayed in a rather lengthy JSON string and includes:
  * Hardware utilized by the deployment (CPU/mem/disk)
  * Escrow Account information including current balance
  * Deployment details (DSEQ, OwnerID, etc)

![](https://lh5.googleusercontent.com/6ziS3SZ8FUFN7cg49xGgVSmzCUg7qT6t6PMF\_Y3UZiqME8Ro3TpYiIdTqURxsq5Dp-w6YEyE4fTDIYj7pSkpe55zaCTDkfQ\_ZxwuCD15t\_PrKmwgd6-sf4q7-iFLCG-2nKz\_Umw0=s0)

### **Close a Deployment**

Akash Deploy makes it simple to close a deployment. Follow the steps provided below to terminate the instance.

* Navigate to “MY DEPLOYMENTS”

![](https://lh6.googleusercontent.com/dhsDeco-LVIudmwhpXK5UL\_CM8rSdIDngxtknEzcgRjJD5vRclt0\_a\_kXuSE8j2DSmgbn\_Mjh-zGD6SwTEOO2Py9lvb7wgEEXeF6aKTMstUiWWVPKZEEuLyTJwmF6OLrAUuTfLEl=s0)

* Close the deployment of interest by selecting the trash can icon on the deployment’s row.

![](https://lh6.googleusercontent.com/iAlfgfqTX4Qgee3Ajh5VQjlSf\_-gWVg7WKGPLgF8X3W61unmVPurOawQGhE9HEsTVKRidYR1DBtS\_vobTjZgY0XIEyf7zMmbV5O3w7UJDLJLW9nWLR8jDwOdEeqZ-y4X1VwPvTbv=s0)

* Approve related transaction gas fees within Keplr

![](https://lh6.googleusercontent.com/Dz4RecTOpzj7eLTtaNJ\_GZ6bGvdlUeNKqJVRsj5PMtNO1j8YVsttLTbJcCbEV2dzF2Y88mSoPSr2cXXB4HRGcwPICK7pSioNKPa5gSSJ0-qNOnMVg2hbUGd5u5gdlh0mh92AsCxf=s0)

* Deployment now displays as closed and remaining funds in the deployment’s escrow have been returned to the Keplr wallet

![](https://lh6.googleusercontent.com/yc4NYsk0N0Y4f0UKchf9wSnAN8MivK8t0tC\_IQ40VLGAxRvhd415tOqc6I\_6ivTKCHy7nMb6IDYk7J64X0D3WN5rE5MABWbEAo7bpXQKgbPoLJcuMVuFkbHhvOJejSH13potomJe=s0)

## **SDL Gallery**

Akash Deploy has a rich selection of pre-defined SDL definition files for all kinds of popular software packages. Within this section we will access the SDL Gallery, review the gallery categories, and use a specific SDL definition for additional deployment experience.

### **SDL Gallery Access and Overview**

* Navigate to the “SDL GALLERY” tab from the toolbar

![](https://lh3.googleusercontent.com/OEHPtu7NxL0rJT5H5VpqS1k8bz1wHpJVXkD40iI2ZJXGqn-ibPYQ9kCTa9tbRH5AJWjIkitgeiZMQA497JR4SAWW09C\_d\_0FU\_RpJH0zwCqk1fZ6IK0a1iP5NJSDH-X7UD6A2YQG=s0)

#### **Exploring SDL Categories and Available Software Deployments**

Scroll through the SDL Gallery’s available categories and related definition files to reveal a wealth of available applications.

* SDL categories include :
  * Official
  * DeFi
  * Blogging
  * Games
  * Databases and Administration
  * Hosting
  * Continuous Integration
  * Project Management
  * Tools
  * Wallet
  * Build with Cosmos SDK
  * Media
  * Data Visualization
  * Chat

### **Example SDL exploration within the gallery**

* Locate the “supermario” SDL file via the search bar at the top of the Gallery page and then click on the “SOURCE” link as depicted below. This will open the git repository that the file lives in.

![](https://lh6.googleusercontent.com/gZjc6uH7-BuASiUvjZxCocM5L8s0edondSCvp0Shj35EoTfrdkxZne2w7B4hp161hsMOkd5\_37ou2FaxeMV8aC4ZUcz-OCA4\_z\_joN2DgqSfDD1TcO4T4zqgV2k4RtjxT1vJ0FsM=s0)

### **Utilize a SDL Gallery Definition in Deployment**

In the prior section the SuperMario SDL was selected. We will now use the SDL to deploy the SuperMario app on the network.

#### Deployment from the SDL Gallery

* Return to the Akash Deploy application and select the SuperMario SDL’s “DEPLOY!” option.

![](https://lh3.googleusercontent.com/FG7p1xV\_RxRAxL0FgUdbQMBOKtHvVGxDFzf1M\_mXjluYiUGYw4V48SVW7z6uakx-j-oi\_7NwhR0-FZ9EFw7koDQUdYHQjV6vVxEL98zSZX4Z0DD-jR7eAnNhucgDM3I40SJ4s8tR=s0)

* This will redirect us to the “DEPLOY” pane with the SuperMario SDL now loaded within the code editor
* Click “DEPLOY”.

![](https://lh5.googleusercontent.com/IenswOH\_-DTzgG3mSQ6PVFR59wiwxliIQd\_roWzwJX\_H2enp8dqGU5Fam-cTrHzvU3STwp4e4Zal3F\_Hqy72LAEZBgzanLnuJ6Dr1cLh1g1PmARTFLIc1SxrmXWvRX-FuGdMWtps=s0)

* Approve the gas fees and transaction within Keplr.

![](https://lh4.googleusercontent.com/19Rx\_\_kafjjus\_FOtk99N9xvn\_mdCnkTG4sn\_dYY\_EjfAdxhqNy5V94BZJYNevRwYUK\_rCjctvQ4N0ADWwi2DdXfHx8BtTqob4KE2qf-KGE2nbuii-s1ZUy1GltcV1dlRfWHMbO0=s0)

* Select a provider and press “SUBMIT”

![](https://lh3.googleusercontent.com/d3dqKJDy1zU\_FwDu3mVjTMORSuIWn43dac1hCjn0RT2yZ2OZXNxPoR0rMpsoNwEf4MkN0TtzxyOA48Y9UKLYgfxuOMi5mFsnK4W8X6qpNYGIGJnyMTC3oxyDF\_nYEf5vtSPp5owc=s0)

* Approve the gas fees and transaction within Keplr again.

![](https://lh3.googleusercontent.com/xBEoEn84T24nisGU2NuPfOQcJRT-uYdrvrP756XAAiQm3wNxMrGNc83Z28JyjqM5sr2\_dj3Q5aM1KSExWwrPUE12nEEsOqISXjPNyEh8VLojyc--Ccx0KX66qOiaT3UStm2WWXBV=s0)

* Copy the URI from the deployed workload informational screen.
* Allow a couple of minutes for the deployment to complete build and then visit the URI in a web browser.

![](https://lh5.googleusercontent.com/3l2QTInt0JnuEArPwquyu7bQEVRPvdOfAflCHcYagFgkcYUN5uTLaSM5B8MeZcJ3Ei0iQ1fp2r6L24aT09U0Bt0SY\_cMucNFJokdEAM56IJfAn7XKYMkDPUpkSSL0q9MAHPSKSiu=s0)

* You should see something similar to the following

![](https://lh6.googleusercontent.com/lbdFSdoGaVSndayoV092iGRYTs9jNsW1U9SB1YkjfA8HDKf7rySsBvg8Hjqg\_WzkrULiL45bTEczxUDdu0k6PdA415MtPizE2OLjLy1jZ9lNqoKsGF8RbaXG186WKsCgzAsPqkzm=s0)
