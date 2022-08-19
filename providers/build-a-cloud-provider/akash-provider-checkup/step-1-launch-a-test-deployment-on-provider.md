# STEP 1 - Launch a Test Deployment on Provider

In the first step of our checkup, we will launch a test deployment that our provider should bid on. We will subsequently accept the bid from our provider, ensure that the lease was created successfully, and then fully test access to the deployment for verification of inbound communications.

Launch the Cloudmos Deploy application to complete the sections that follow.

## Create Deployment

* Select the CREATE DEPLOYMENT option from the Dashboard page

![](../../../../.gitbook/assets/akashlyticsCreateDeployment.png)

* In our testing we will use the Hello Akash World simple SDL
* Note - this SDL does not specify any attributes. If the list of bids received from the deployment is large and you would like to reduce the list to isolate a bid from your provider a bit easier, consider attribute use as detailed in this [SDL reference](https://docs.akash.network/providers/akash-audited-attributes#attribute-location-within-the-sdl).
* Otherwise process with the deployment with no need for change to the Hello Akash World SDL and pause when you reach reach the Create Lease phase of the deployment

![](../../../../.gitbook/assets/akashlyticsHelloWorldSelect.png)

## Create Lease

* Within the Create Lease screen we encounter one of the primary objectives of our test deployment
* Isolate and ensure that your provider has responded to the deployment order with a bid as demonstrated in this example
* If a bid from your provider was received, select that bid and proceed with ACCEPT BID which will complete our first test deployment on our provider and we can proceed to next verification steps. Leave the test deployment open for next steps.
* If a bid from your provider was not received, review the [Provider Logs](step-5-provider-logs.md) section of this guide in which we will verify that the deployment order reached the provider and was processed successfully.

![](../../../../.gitbook/assets/akashlyticsAcceptBid.png)

