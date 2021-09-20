# Akash Deploy UI \(Web App\)

## **Akash Deploy Overview**

Akash Deploy delivers a web application allowing workload deployment onto the Akash network with ease.  The platform lessens the learning curve and reduces friction in comparison to traditional methodologies of deployment provisioning through the Akash CLI.

The exploration that follows offers detailed guidance in the usage of Akash Deploy with explicit instruction, examples, and sample depictions.

Akash Deploy is an open-source project written in ReactJS.  The repository for the application is listed below.  However a demo site of the app is available, may serve as launch point for initial/continued experimentation with Akash Deploy, and will serve as the platform utilized for the demonstrations that exist in this guide.

[**https://github.com/spacepotahto/akash-deploy-ui**](https://github.com/spacepotahto/akash-deploy-ui)

## **Prepare the Environment**

The Akash Deploy app integrates with available Keplr wallet instances.  Keplr is a simple, open-source browser extension wallet for the Cosmos interchain ecosystem and supports the Akash blockchain.  In this section - serving as a prerequisite for Akash Deploy usage -  assurances are conducted to ensure the Keplr wallet is available and funded sufficiently.

### **Keplr Wallet Browser Extension Guidance**

The Keplr wallet extension for Chrome may be found at the following location:

[**https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en\#:~:text=Keplr%20is%20a%20browser%20extension,for%20the%20Cosmos%20interchain%20ecosystem**](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en#:~:text=Keplr%20is%20a%20browser%20extension,for%20the%20Cosmos%20interchain%20ecosystem)

Download of the browser extension and further description of the application may be found within this site.

Post installation and extension activation the Keplr wallet should appear as a browser extension as depicted below in a Chrome use case.  The wallet may be opened for subsequent validations in this guide and future needs by clicking the browser’s extension icon highlighted.

![](https://lh3.googleusercontent.com/yhagSgBYkSDIuYUvUBDtoEM-yd8J2YtCphOcUrHYj3FeR5_JjlkCtJoTEzzlvzT6DzmSuM4WRZLzEPJy0wZ293iTHQ8cn1hfseKjJVfhuIuwkeHjBFRahizVXP8fE47j9R6UYFkp=s0)

### **Ensure Adequately Funded Keplr Wallet**

* Open the ​Keplr wallet browser extension and ensure sufficient AKT funds are available to allow application deployment to the Akash network 
* A minimum 5 AKT would be necessary to allow a deployment and fund the deployment’s escrow account
* The depiction that follows demonstrates a launched Keplr wallet instance with the Akash network selected and adequate AKT funds available

![](https://lh5.googleusercontent.com/DdHCWmQFBuKA4sp8wPSHX_hhm_UHkWfoy0QcgY4QlGPgRyXOQHMpEUDCdiNyp6gjFu_XDwt1NVpcEgY7TgurBbgDFUeUg-LyUUm1_vr7MmkZsDPi0UDkVp--kxJyL8h5FB5dB12U=s0)

## **Initial Akash Deploy Access and Configuration**

As discussed previously - a demo Akash Deploy site will be used within this guide.  The demo site may be utilized to follow along and reproduce all referenced examples  using your own wallet/certificates/deployments.  The demo site is multi tenant enabled and only the user’s own workloads and funding will be visible and accessible.

### **Akash Deploy Demo Site Access**

Access instructions and expected landing page of the Akash Deploy demo site are provided in this section.

* Akash Deploy demo site URL

[**https://akashdeploy.hns.siasky.net/**](https://akashdeploy.hns.siasky.net/)

* The page depicted below serves as the landing site of the application

![](https://lh4.googleusercontent.com/f0cIAce8G3916Ln1139xhtXx-hXXgdvr2Gk8dz4o3Jf9DNMH1tzy1GX5mrgPjvXkPXAoPy1_Nm8ItFKlr_HKgIxVKdYAuj102L90ea4Iuo2XRcPNTLeYDYd8mdwknYC1NH_Pzd4p=s0)

### **Assure Akash Deploy Access to Keplr Wallet and Associated Funds**

In the “Prepare the Environment” section of this guide assurances of an available Keplr wallet instance were conducted.  Within this section validations of Akash Deploy access to the Keplr wallet and associated AKT funds are completed.

* Validate Akash Deploy visibility of Keplr wallet AKT funds as per the depiction below
* In the example depiction Akash Deploy correctly discovers and renders 52.786 AKT
* The funds displayed should be identical to the funds represented and available in the Keplr wallet and the associated account

![](https://lh5.googleusercontent.com/lADn1khoxFgKxQJRj6mKVfBi9Zrj-HRDWbIGC09jh21m3_xW47Ss3JF_DmTM_fCWndW4WGza0LL1A8JgJCesb3Imnjbo1fcMs4caVP3cmrg-WUdvul7SVhr8StfyPUqRunE0QJhM=s0)

### **Create Certificate for Transactions**

The Akash Deploy instance must have access to a certificate to sign transactions placed onto the blockchain.  On initial access of the demo site no such certificate will be in place.  The steps that follow complete the simple process of certificate creation within the application.

* Utilize the “CERTIFICATE” to provoke the certificate creation process
* In the dialog box that appears select the “CREATE” button

![](https://lh6.googleusercontent.com/M_cUADVPBj8Xhg12WfC4l0m7tjyZQNYoLiC7EofhPgqX5uyTCcK3kIaSjgsEQJUV64G7h1hImKcvDSStWWFxBUclB70nAnw553DuOh-hak_cgr0NsK9sbVMzHZWYZ1-n9Fi1Mj-r=s0)

* Upon certificate create invoke Keplr will prompt to accept gas fees for transaction
* Accept the medium/default gas fees to ensure timely transaction completion
* Note - the transaction process may take a few seconds as the associated block is constructed and placed onto the chain

![](https://lh4.googleusercontent.com/n6bkRDWpqL3qhaIQIZrtsZ2zh3d3VIC7ZGejfO8h_BtzVcUhlCquK3axZj5P5YLNVWk7xPrCjgrLfYzaENu_GQ5beZ422llr_sA-ENgbYSuab9P6gfQcY1QYaaCA-SjSfPJGKLMv=s0)

* Resultant confirmation of successful transaction and certificate creation

![](https://lh4.googleusercontent.com/4tBhrsGyIHG0RFPFdQI_XudHmV0hVQW_WTwHY8oXwYAr4WuJAkhppCYXsCWjp1Va_dy4DcOJZRXKNfjfQ7LA5djX8_6-VfH-_5AXnDCWF1Dka8ZaIsOXdRiz3IVe_GtIWLXx-WMK=s0)

## **Deployment of Sample Workload**

Upon initial launch the Akash Deploy application displays an editing pane populated with Stack Definition Language \(SDL\) pertaining to a Lunie Light application.  The sample application \(Lunie Light\) is a non-custodial, web wallet for Akash.  But for the purpose of demonstration the intent of the application is not of importance.  To explore workload deployments to the Akash network the sample application is utilized for ease.  In subsequent sections - exploration of greater sets of available applications/SDLs within the Akash Deploy Gallery and custom SDL deployment will be detailed.

### **Steps in Application Deployment**

#### **SDL Edit/Deploy**

* If not currently on the Akash Deploy default landing page - navigate to “DEPLOY” from the top toolbar and as depicted below

![](https://lh4.googleusercontent.com/w4QZ0PB7Wi_ee-eoO1qe8Sy95Kd-LKFGLwqIQ5mOe5wYYYWDmCkE99ji2kYp4SCX0UNtXTDrT7G4boBW8Jfxc-hFUSnsNpoZupRYl9WdVyNggHZyBsbTXdvpENhdEgyKIbBI5CFa=s0)

* As mentioned prior - Akash Deploy renders the Lunie Light Application SDL in the embedded code editor initially
* Without need of editing the SDL - click the “DEPLOY” button as depicted

![](https://lh4.googleusercontent.com/zK7oHSZLutPjfHYGJnfmzfRLqQbzKYe5rmYJO9COKQT4ax_3oCZy72uu1_wqRRo2qMHruVSjHWGSAOojm6kTXD08A7WEx_AP-Gbl8nvqFm1GIvVA1lX3dtU8TwpwbJdc4Jg-wQee=s0)

* Upon invoke of the deployment a Keplr wallet prompt will display - as depicted below - requesting acceptance of the deployment’s transaction gas fees
* Additionally Akash Deploy displays a pane detailing the running progress of the deployment
* Accept the default gas fee selection to allow deployment to proceed
* Post acceptance of gas fees the Akash Deploy deployment tracking will update to “waiting for bids” as provider bids are obtained

![](https://lh4.googleusercontent.com/-DsAha7_Gry6z4aFEQAaOQhWTEla9BJNrwxqMQ1qPURmArhvqoi-vUwDsoZ2-JQ24h9O2MDcQswl1mG-54BBGcHC6Oqyj-2zYLz42pE75hxMQK_RgwWwG91j1CLZSJxKouyZUFTi=s0)

#### **Provider Selection**

* Select a provider from the list of submitted bids
* Press “SUBMIT” once the preferred provider has been selected

![](https://lh3.googleusercontent.com/Zrz73djx5-xqvt1Qj5rLH8NUJlKOCNu0Vo_M1elSOkdKYDzharubO8lQm_LRTdHy5wYIF8xrK9Oy9C5dT8SA8bgBiMxtCbcY4ELIxcrWoz5jCK1tpWKOQRRfaUIOruj19jQj2LUH=s0)

* Transaction gas fee prompt following provider selection
* Following gas fee acceptance - Akash Deploy messaging will proceed thru statuses of “Confirming the lease” &gt; “Querying the provider” &gt; “Sending the manifest” &gt; “Querying lease status”

![](https://lh3.googleusercontent.com/zkMddw9w4iiyau77tUR_bp3ARPVsGAFkhIyWUvnbQH4DQ1ZBiGbc5lYAKF9Zg9yt1hnhrY6-M7uEqA2R5H9Uuzt4PQflvGWdPtdLgO1VfmNHgRV2RjOKzNIlWNTwtCXxI1CfaOse=s0)

* Upon completion of the deployment to the selected provider the following confirmation is received
* Amongst a wealth of interesting and important information revealed note:
  * Number of workload replicas
  * Available replicas
  * In the case of web services workloads the exposed URI 

![](https://lh4.googleusercontent.com/X_OZsXq9d7IRHBzw0lSWbqjvdW5z6I3a4z4WFc1AqQp_fIvZwmRBJulZ5QO3rTFeCgNPbNKs37ORDaD5GEzl_s5yf2aIhHk2nJHkINOyQspDnBLT4BqTNWNyIJjAV4Ohj5CrFQ1M=s0)

#### **Validation of Workload Deployment and Usage**

The Lunie Light application is a web service and thus the SDL deployment generated an externally reachable URI.  Using the exposed intel from the prior step - access to the web service will be validated.

* Capture/copy the URI from the information exposed following deployment completion and as depicted below
* Note - if the deployment information detail panel was closed - the URI may be obtained by navigating to “MY DEPLOYMENTS” from the toolbar and then clicking the info “I” icon next to the relevant deployment.  Further detailing of the “MY DEPLOYMENTS” pane will be conducted in a subsequent section of this guide.

![](https://lh4.googleusercontent.com/8QKbtcSpAdWu0OMm-2e5ky4YCk4k7DVsidCOID5Izys8Kx1M2D3h6rt3xf2vFoTM92DYaEr2kyDPuVWpNbte3gEnC-s67BBcKxe5dF8JZ4hE-QHFBhPbEFzU0JxuXCubdQlbeFlG=s0)

* Attempt to visit the exposed URI in a web browser
* Note - if a 502 Bad Gateway HTTP response is returned - continue refreshing the page for a few seconds as the workload may not yet be fully deployed on the provider
* Receipt of the page displayed below confirms the web service \(Lunie Light\) was fully deployed successfully

![](https://lh4.googleusercontent.com/MXlZz_gRmriE3O1wsZpFnTAe5iCAtcA2hLKVcdFAIDahf6Erg3bQXSdSbs6cYpj3mN3T7lcgVk5VkMUBzHRuU3yYEj7TSx0eJQucNObC1nZMF7VFNbLnPnYjPHJbfjnYFdhDCDv5=s0)

## **Manage Deployments**

Akash Deploy serves as an intriguing platform not only to deploy new workloads but also to manage, monitor, and close active workloads as needed.  In the subsections that follow such deployment management techniques within the platform are explored in detail.

Monitoring and managing deployments from Akash Deploy often proves to be considerably less cumbersome than performing the same operations - particularly across many deployments - within the Akash CLI.

### **View Active and Inactive Deployment Details**

Akash Deploy affords visualization of active and inactive deployments with minimal effort.

#### **Display Deployments**

* Navigate to “MY DEPLOYMENTS” as depicted below

![](https://lh6.googleusercontent.com/dhsDeco-LVIudmwhpXK5UL_CM8rSdIDngxtknEzcgRjJD5vRclt0_a_kXuSE8j2DSmgbn_Mjh-zGD6SwTEOO2Py9lvb7wgEEXeF6aKTMstUiWWVPKZEEuLyTJwmF6OLrAUuTfLEl=s0)

* Toggle the “Show Inactive” button
* Active deployments are distinguished by a red filled circle containing a cloud icon
* Inactive deployments are distinguished by a grey filled circle container a cloud icon slashed

![](https://lh6.googleusercontent.com/oACJ7NX58-9vs6DuR4-uVBltpQMpOLzqw7IHRewPv6bJDudWDHCgrDjqmOFytFH8rhhCVHfnMJORaRnmwXr-9uoIM0tuEWeunN9qYcz_Ktfd76NcQCdVAt9YZNnmuuxOoAOrF0FZ=s0)

#### **Deployment Details Revealed**

* Reveal additional information on an active deployment’s lease information by selecting the information \(“i”\) icon as depicted

![](https://lh5.googleusercontent.com/ZmkkOcNV0b0dmjQSpPf6Aev7SujE2BE_lHI5EHxN4OMZvQASNrLcTfg6IHatHyt2RVB7Kr0vCwcQPpMog4xjH7oxw1UOCmjNQ3eyoSuabGJjChuVvRnrBWBl3kYDpChHwSbF8x_O=s0)

* Intelligence pertaining to the deployment revealed post selection
* Note that the information revealed is identical to the intel first displayed in a provoke pane when the deployment process completed and includes details such as replica count/available replicas/URI if applicable

![](https://lh5.googleusercontent.com/jr1tuQQKD0tLC6ULg8Bqz8FUGAX_1Gv9Z-DnufSSXlZDYmNtyxemcWnykFp2O6exgYUKAWJF_7HFvt6p0hdDh4vYN2rdTdrAStLDMw7oo4U4f3pR8H-5qWmTorxdS8XkZUQxOE_q=s0)

* Reveal detailed intelligence regarding the deployment via click on the Deployment identifier \(DSEQ\) or anywhere in the white space to the right of the DSEQ as depicted

![](https://lh5.googleusercontent.com/jgKHsBMTxYbuQV-kAi4Y-R6pDXAZK5fNMmMeF4YsrKZRIRcdfSF-aFvxioIhtTpK_HMOuCF-APvULyyekCmX0k9Gz8DCPLqco5GwzNO10YU9ioavmuUY_d6l1dag8OzZEvcXWUzS=s0)

* Revealed intelligence is spawned in a rather lengthy JSON string and includes:
  * Hardware utilized by the deployment \(CPU/mem/disk\)
  * Escrow Account information including current balance
  * Deployment details \(DSEQ, OwnerID, etc\)

![](https://lh5.googleusercontent.com/6ziS3SZ8FUFN7cg49xGgVSmzCUg7qT6t6PMF_Y3UZiqME8Ro3TpYiIdTqURxsq5Dp-w6YEyE4fTDIYj7pSkpe55zaCTDkfQ_ZxwuCD15t_PrKmwgd6-sf4q7-iFLCG-2nKz_Umw0=s0)

* Below is a depiction of the Escrow Account information reveal in the returned data

![](https://lh6.googleusercontent.com/hwQJwSqe9Pu2M0V7o36vkj3yMuIvX13pawGz5103C2TA6YZ1fJCz33RRvTcIFdmJFNJab3xKryoAZagUkAcqTfAppIBig0GlfhJthEtgocODRfe7aYRZ8bPoCoQS7er1qSru3XCN=s0)

### **Close a Deployment**

Akash Deploy may also facilitate closure of active deployments.  Follow the steps provided below to render a deployment as inactive.

* Navigate to “MY DEPLOYMENTS” as depicted below

![](https://lh6.googleusercontent.com/dhsDeco-LVIudmwhpXK5UL_CM8rSdIDngxtknEzcgRjJD5vRclt0_a_kXuSE8j2DSmgbn_Mjh-zGD6SwTEOO2Py9lvb7wgEEXeF6aKTMstUiWWVPKZEEuLyTJwmF6OLrAUuTfLEl=s0)

* Close a deployment of interest by selecting the trash can iron within the deployment’s associated row and as depicted below

![](https://lh6.googleusercontent.com/iAlfgfqTX4Qgee3Ajh5VQjlSf_-gWVg7WKGPLgF8X3W61unmVPurOawQGhE9HEsTVKRidYR1DBtS_vobTjZgY0XIEyf7zMmbV5O3w7UJDLJLW9nWLR8jDwOdEeqZ-y4X1VwPvTbv=s0)

* Approve related transaction gas fees within Keplr

![](https://lh6.googleusercontent.com/Dz4RecTOpzj7eLTtaNJ_GZ6bGvdlUeNKqJVRsj5PMtNO1j8YVsttLTbJcCbEV2dzF2Y88mSoPSr2cXXB4HRGcwPICK7pSioNKPa5gSSJ0-qNOnMVg2hbUGd5u5gdlh0mh92AsCxf=s0)

* Deployment now displays as closed and remaining funds in the deployment’s escrow have been returned to the Keplr wallet

![](https://lh6.googleusercontent.com/yc4NYsk0N0Y4f0UKchf9wSnAN8MivK8t0tC_IQ40VLGAxRvhd415tOqc6I_6ivTKCHy7nMb6IDYk7J64X0D3WN5rE5MABWbEAo7bpXQKgbPoLJcuMVuFkbHhvOJejSH13potomJe=s0)

## **SDL Gallery**

Akash Deploy offers a rich ecosystem of available pre-defined SDL definition files for rapid deployment of popular workloads.  Exploration in this section includes accessing the SDL Gallery, review of gallery categories, and using a specific SDL definition for deeper inspection/usage.

### **SDL Gallery Access and Overview**

The Akash Deploy SDL Gallery may be accessed via the following navigation:

#### **Accessing SDL Gallery**

* Navigate to the gallery via the selection of  “SDL GALLERY” from the toolbar and  as depicted below

![](https://lh3.googleusercontent.com/OEHPtu7NxL0rJT5H5VpqS1k8bz1wHpJVXkD40iI2ZJXGqn-ibPYQ9kCTa9tbRH5AJWjIkitgeiZMQA497JR4SAWW09C_d_0FU_RpJH0zwCqk1fZ6IK0a1iP5NJSDH-X7UD6A2YQG=s0)

#### **Exploring SDL Categories and Available Software Deployments**

Scroll thru SDL Gallery available categories and relational definition files to reveal a wealth of pre-developed SDLs/applications 

* **SDL categories include :**
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

* Locate the “supermario” SDL via the search bar at the top of the Gallery page and then click on the Tetris “SOURCE” link as depicted below

![](https://lh6.googleusercontent.com/gZjc6uH7-BuASiUvjZxCocM5L8s0edondSCvp0Shj35EoTfrdkxZne2w7B4hp161hsMOkd5_37ou2FaxeMV8aC4ZUcz-OCA4_z_joN2DgqSfDD1TcO4T4zqgV2k4RtjxT1vJ0FsM=s0)

* Upon invoke of the “SOURCE” link from the prior step - a redirect to the corresponding Awesome Akash Github repository for the SDL will occur as depicted 

![](https://lh6.googleusercontent.com/9ma84JkRyjSOTDQef27v_8tdoL86llkrIzANc7bjx61LLe7My2rLExTyoaiBmkDyNo0EbdN0Ld5ofaYzzhGag2TB9qSg-LhfjwUmwwfy8Z5peJffH2AZgyapNN7nw7xUQoAY8ubG=s0)

* Select the deploy.yaml file in the GitHub repo to view the SDL YAML file for the deployment 

![](https://lh5.googleusercontent.com/WUzNmnyg6IRpqP0a-FQkF5KNiWhRJpCvaH8u4Lz2x4uYKOjpidZIxfkpe4BtPKoI0BIW4ERhf5gEC-Ec11FgRE2FQbDM5VrMg0MLjoLLAyP2iqLETo8baGzTz6ZLPzB2aMUOkvZi=s0)

### **Utilize a SDL Gallery Definition in Deployment**

In the prior sub-section the Tetris SDL from the SDL Gallery was isolated.  The isolated definition will now be utilized in the creation of an Akash deployment.

#### **Provoke the Deployment from the SDL Gallery**

Two paths exist to deploy the SDL Gallery definition of interest:

1. The code from the GitHub repository explored prior could be copied into the Akash Deploy SDL code editor with subsequent “DEPLOY” button provoke
2. The SDL Gallery instance “DEPLOY!” option may be used to provoke deployment

The latter of these possible options - provoking deployment from within the SDL Gallery - will be utilized for this demonstration.

* Return to the Akash Deploy application and select the SuperMario SDL’s “DEPLOY!” option as depicted

![](https://lh3.googleusercontent.com/FG7p1xV_RxRAxL0FgUdbQMBOKtHvVGxDFzf1M_mXjluYiUGYw4V48SVW7z6uakx-j-oi_7NwhR0-FZ9EFw7koDQUdYHQjV6vVxEL98zSZX4Z0DD-jR7eAnNhucgDM3I40SJ4s8tR=s0)

* The user is redirected to the “DEPLOY” pane with the SuperMario SDL now present within the code editor 
* Proceed with deployment via the “DEPLOY” button as depicted

![](https://lh5.googleusercontent.com/IenswOH_-DTzgG3mSQ6PVFR59wiwxliIQd_roWzwJX_H2enp8dqGU5Fam-cTrHzvU3STwp4e4Zal3F_Hqy72LAEZBgzanLnuJ6Dr1cLh1g1PmARTFLIc1SxrmXWvRX-FuGdMWtps=s0)

* Approve the gas fees within Keplr allowing the deployment to proceed

![](https://lh4.googleusercontent.com/19Rx__kafjjus_FOtk99N9xvn_mdCnkTG4sn_dYY_EjfAdxhqNy5V94BZJYNevRwYUK_rCjctvQ4N0ADWwi2DdXfHx8BtTqob4KE2qf-KGE2nbuii-s1ZUy1GltcV1dlRfWHMbO0=s0)

* Select a provider and press “SUBMIT”

![](https://lh3.googleusercontent.com/d3dqKJDy1zU_FwDu3mVjTMORSuIWn43dac1hCjn0RT2yZ2OZXNxPoR0rMpsoNwEf4MkN0TtzxyOA48Y9UKLYgfxuOMi5mFsnK4W8X6qpNYGIGJnyMTC3oxyDF_nYEf5vtSPp5owc=s0)

* Accept the transaction gas fees to allow the deployment to proceed

![](https://lh3.googleusercontent.com/xBEoEn84T24nisGU2NuPfOQcJRT-uYdrvrP756XAAiQm3wNxMrGNc83Z28JyjqM5sr2_dj3Q5aM1KSExWwrPUE12nEEsOqISXjPNyEh8VLojyc--Ccx0KX66qOiaT3UStm2WWXBV=s0)

* Capture the URI from the deployed workload informational screen
* Allow a couple of minutes for the deployment to complete build and then visit the URI in a web browser

![](https://lh5.googleusercontent.com/3l2QTInt0JnuEArPwquyu7bQEVRPvdOfAflCHcYagFgkcYUN5uTLaSM5B8MeZcJ3Ei0iQ1fp2r6L24aT09U0Bt0SY_cMucNFJokdEAM56IJfAn7XKYMkDPUpkSSL0q9MAHPSKSiu=s0)

* Confirmation of deployment provoked within the Akash Deploy SDL Gallery

![](https://lh6.googleusercontent.com/lbdFSdoGaVSndayoV092iGRYTs9jNsW1U9SB1YkjfA8HDKf7rySsBvg8Hjqg_WzkrULiL45bTEczxUDdu0k6PdA415MtPizE2OLjLy1jZ9lNqoKsGF8RbaXG186WKsCgzAsPqkzm=s0)

