# Validator Topology

In this guide we create a Validator within an Akash Deployment.

The topology of the environment will be as follows:

* Akash Validator as a deployment and as created in the [Akash Validator Deployment](../../../../validating/akash-validator-with-tmkms-and-stunnel/akash-validator-deployment.md) section of this guide
* Tendermint Key Managment System (TMKMS) used for storage of the Validators private key on a secured server.  The TMKMS instance - configured in the [TMKMS Setup](broken-reference) section of this guide - may be created on any secure server of your choosing.  The TMKMS server must have connectivity to the Akash Validator.
