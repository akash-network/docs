# Dangling Deployments

As part of routine Akash Provider maintenance it is a good idea to ensure that there are no "dangling deployments" in your provider's Kubernetes cluster.

We define a "dangling deployment" as a scenario in which the lease for a deployment was closed but due to a communication issue the associated deployment in Kubernetes is not closed.  This should be a rare circumstance but we want to cleanse the provider of any such "dangling deployments" from time to time.

Please use this [Dangling Deployment Script](https://gist.github.com/arno01/6384d4cb1a3b3a62011f854d2e52e283) to both discover and close any such deployments.
