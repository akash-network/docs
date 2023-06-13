# Minesweeper Deployment Example

In this section we will use the Akash Console to launch an example Minesweeper deployment on the Akash Testmet. You can follow the same process for any other workload so long as it is containerized and you have an appropriate SDL.

## STEP 1 - Create the Deployment

* Begin the process of creating a new deployment by selecting the `+` symbol from the left hand navigation pane
* A number of deployment types are presented in the gallery
* For our purposes we will import a SDL for the Minesweeper deployment example.  Select `Import SDL` to proceed.

<figure><img src="../../../../../.gitbook/assets/createDeployment.png" alt=""><figcaption></figcaption></figure>

### Copy Awesome Akash Minesweeper SDL

* The Minesweeper SDL (Stack Definition Language) file - which is the recipe for an Akash Deployment - can be found in the Awesome Akash repository [here](https://github.com/akash-network/awesome-akash/blob/master/minesweeper/deploy.yaml).
* Copy the contents of the SDL into the Akash Console editor as demonstrated below.
* Select `Save & Close` when complete

<figure><img src="../../../../../.gitbook/assets/minesweeperSDL.png" alt=""><figcaption></figcaption></figure>

### Name Deployment and Proceed

* Optionally assign the deployment a useful/descript name
* Select `Create Deployment` when complete to proceed to the next step

<figure><img src="../../../../../.gitbook/assets/nameDeployment.png" alt=""><figcaption></figcaption></figure>

## STEP 2 - Pre-Flight Check

* A `Pre-Flight` screen is displayed which ensures all necessary criteria - such as a connected wallet, sufficient funding to launch a deployment, etc - are presented
* Most likely - if this is your first time using the Akash Console - a `Missing Certificate` warning will be displayed
* Select the `Create Certificate` option and approve Keplr gas fee prompts that follow
* Once the creation of the certificate step is complete the warning of `Missing Certificate` should update to `Valid Certificate`
* Select the `Next` button when all Pre-Flight Checks are green
* Accept additional gas fee prompts by Keplr to allow the dpeloyment creation to complete

<figure><img src="../../../../../.gitbook/assets/prefllightCheck.png" alt=""><figcaption></figcaption></figure>

## STEP 3 - Select Provider

* A list of Akash providers who bid on the deployment is presented
* Select the Akash provider of your choice

> NOTE - ensure to select `ALL` instead of the default `Only Audited` selection near the top right of the pane for Testnet purposes.  This will allow bids from all providers to display.

<figure><img src="../../../../../.gitbook/assets/selectProviderr.png" alt=""><figcaption></figcaption></figure>

* Following the initial select of the provider - new options will be presented as depicted below
* Select `Submit Deploy Request` to complete the deployment process
* Accept Keplr gas fee prompt to proceed

<figure><img src="../../../../../.gitbook/assets/sendManifest.png" alt=""><figcaption></figcaption></figure>

## STEP 4 - Deployment Confirmation and Testing

* Following successful deployment of the Minesweeper SDL to the selected Akash provider, a status page will be presented as depicted in the example below
* This page can be used to view logs of the deployment and obtain general deployment info
* Allow the deployment a couple of minutes to fully deploy and then test Minesweeper by selecting the generated URL of the deployment

#### Select URL to Test Deployment

<figure><img src="../../../../../.gitbook/assets/deploymentLogs.png" alt=""><figcaption></figcaption></figure>

#### Expected Result of Initial Deployment Testing

<figure><img src="../../../../../.gitbook/assets/minesweeperComplete.png" alt=""><figcaption></figcaption></figure>

## Summary and Next Steps

* This completes our walk through of a example SDL and associated deployment onto the Akash Testnet network
* The steps presented in this guide can be used for any future deployments and associated SDLs
