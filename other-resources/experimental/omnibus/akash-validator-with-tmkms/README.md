# Akash Validator with TMKMS

**NOTE** - the steps in this guide are currently deemed experimental pending security enhancements that will be introduced prior to becoming production grade.  At this time, please only use this guide for experimentation or non-production use.

In this guide we will create an Akash Validator as a deployment.  The Tendermint Key Management System (TMKMS) will be used so that we do not store the validator's private key on the validator server itself.

The Validator deployment will take advantage of statesync for rapid blockchain synchronization.

Sections in this guide:

* [Validator Topology](../../../../validating/akash-validator-with-tmkms-and-stunnel/validator-topology.md)
* [Obtain Private Key](../../../../validating/akash-validator-with-tmkms-and-stunnel/obtain-private-key.md)
* [Akash Validator Deployment](../../../../validating/akash-validator-with-tmkms-and-stunnel/akash-validator-deployment.md)
* [TMKMS Setup](tmkms-setup.md)
* [Start and Verify the TMKMS Service](../../../../validating/akash-validator-with-tmkms-and-stunnel/start-and-verify-the-tmkms-service.md)
