# Akash Validator with TMKMS and Stunnel

**NOTE** - the steps in this guide are currently deemed experimental pending security enhancements that will be introduced prior to becoming production grade.  At this time, please only use this guide for experimentation or non-production use.

In this guide we will create an Akash Validator as a deployment.  The Tendermint Key Management System (TMKMS) will be used so that we do not store the validator's private key on the validator server itself.

An implementation of Stunnel is included to provide secure peer to peer communication between the Akash validator and the TMKMS server.

The Validator deployment will take advantage of statesync for rapid blockchain synchronization.

Sections in this guide:

* [Validator Topology](validator-topology.md)
* [Obtain Private Key](obtain-private-key.md)
* [Akash Validator Deployment](akash-validator-deployment.md)
* [TMKMS Setup](broken-reference)
* [Start and Verify the TMKMS Service](start-and-verify-the-tmkms-service.md)
