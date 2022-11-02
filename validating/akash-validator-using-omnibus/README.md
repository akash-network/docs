# Akash Validator Using Omnibus

## **Overview**

Building an Akash Validator is simplified via the use of Cosmos Omnibus and as detailed in this guide.

> _**NOTE**_ - using the procedures in this guide the Validator private key will be stored within the associated Akash deployment.  Ensure that only known, trusted providers are used for such deployments.  Additionally consider storing the private key outside of the deployment through the use of TMKMS which is documented [here](../akash-validator-with-tmkms-and-stunnel/).

The Akash Validator will be built with the following attributes:

* Two Sentry nodes will be created to protect the validator from distributed denial of service (DDOS) attacks
* The Akash Validator will sit behind the Sentry nodes and will not be directly exposed to the internet
* The Sentry nodes and the Akash Validator will launched on the Akash Network as deployments
* This guide will detail the launch of the deployments via the Cloudmos Deploy tool for ease

### Sections within this Guide

[STEP 1 - Cloudmos Deploy Review](cloudmos-deploy-review.md)

[STEP 2 - FileBase Buckets](filebase-buckets.md)

[STEP 3 - Akash SDL Review](akash-sdl-review.md)

[STEP 4 - Cloudmos Initial Deployment](cloudmos-initial-deployment.md)

[STEP 5 - Edit SDL with Known IDs](edit-sdl-with-known-ids.md)

[STEP 6 - Redeploy Validator and Sentries with Cloudmos](redeploy-validator-and-sentries-with-cloudmos.md)
