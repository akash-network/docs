# Terraform Manifest - Template

## Overview

Within this section we review a Terraform Manifest example for building an Akash deployment.

## Terraform Manifest File

* Use the blocks reviewed in this section to create your Terraform Manifest.
* Create a directory to house the files for your Terraform project and use this directory for all files created in the rest of this guide
* Create a file named `akashdeployment.tf` and populate the file with the blocks review below
* Refer to the [Terraform Manifest - Complete Example ](terraform-manifest-complete-example.md)for clarity on how the blocks covered in this section fit together.

## Terraform Block

* The `akash` provider is defined and current version specified
* No adjustments to the Terraform manifest block should be necessary
* Periodically check to ensure the latest version is specified

```
terraform {
  required_providers {
    akash = {
      source = "cloud-j-luna/akash"
      version = "0.0.5"
    }
  }
}
```

## Provider Block

* Provider attributes are defined in this block
* Replace the `account_address` and `key_name` attributes with your own values

```
provider "akash" {
  account_address = "akash1<redacted>"
  keyring_backend = "os"
  key_name = "mykey"
  node = "https://akash-rpc.polkachu.com:443"
  chain_id = "akashnet-2"
  chain_version = "0.1.0"
}
```

## **Resource Block**

* Definition of the Akash Deployment
* Replace `hello_world` with the preferred name of your deployment
* Assumes that the `deploy.yaml` Akash SDL exists in the same directory as the Terraform file

```
resource "akash_deployment" "hello_world" {
  sdl = file("${path.module}/deploy.yaml")
}
```

## **Output Block**

* Output the assigned URI and ports of the deployment
* Replace `hello_world` with the name of your deployment defined in the Resource Block

```
output "services" {
  value = akash_deployment.hello_world.services
}
```
