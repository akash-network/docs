# Akash Validator with TMKMS and Stunnel

In this guide we will create an Akash Validator as a deployment on the Akash network.  The Tendermint Key Management System (TMKMS) will be used so that we do not store the validator's private key on the validator server itself.

An implementation of Stunnel is included to provide secure peer to peer communication between the Akash validator and the TMKMS server.

The Validator deployment will take advantage of statesync for rapid blockchain synchronization.

Sections in this guide:

* [STEP 1 - Validator Topology](validator-topology.md)
* [STEP 2 - Obtain Private Key](obtain-private-key.md)
* [STEP 3 - Akash Validator Deployment](akash-validator-deployment.md)
* [STEP 4 - TMKMS Setup](tmkms-setup.md)
* [STEP 5 - Start and Verify the TMKMS Service](start-and-verify-the-tmkms-service.md)
* [STEP 6 - Stunnel Client](stunnel-client.md)
* [STEP 7 - Verify Validator Status](verify-validator-status.md)
* [Additional Resources](additional-resources.md)
