# Create Akash Deployment

## **Overview**

In this section we create an Akash Deployment via Terraform.

Complete the construction of the Terraform manifest before initiating the deployment creation.

Ensure that the steps detailed in this section are executed from the directory in which the Terraform manifest exists.

_**NOTE**_ - at this time the selection of the Akash provider from the bid list is automatic and selects the lowest priced bid. Consider adding attributes to the SDL to further limit provider bids received if necessary. Many providers advertise a**n** `organization` attribute and inclusion of this attribute within the SDL would allow only that provider to bid. In the near future other schemes will be introduced to allow specific provider bid selection in the deployment creation process via Terraform.

## **Steps**

### Initialize the Terraform Project

```
terraform init
```

### Confirm Resources to be Created

```
terraform plan
```

### Create the Akash Deployment via Terraform

```
terraform apply -auto-approve
```

## **Expected/Example Output from Deployment Creation**

* Confirm the application successfully deployed onto the Akash Network by visiting the generated and displayed in output `service_uri`

```
services = tolist([
  {
    "service_name" = "hello_world"
    "service_uri" = "at2flmmh8pdtdfclbmfe2pv59o.praetor.ingress.d3akash.cloud"
  },
])
```
