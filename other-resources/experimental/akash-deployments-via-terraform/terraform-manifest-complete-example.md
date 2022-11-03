# Terraform Manifest - Complete Example

```
terraform {
  required_providers {
    akash = {
      source = "cloud-j-luna/akash"
      version = "0.0.3"
    }
  }
}

provider "akash" {
  account_address = "akash1ggk74pf9avxh3llu30yfhmr345h2yrpf7c2cdu"
  keyring_backend = "os"
  key_name = "chainzeroforakash"
  node = "http://akash.c29r3.xyz:80/rpc"
  chain_id = "akashnet-2"
  chain_version = "0.16.4"
}

resource "akash_deployment" "hello_world" {
  sdl = file("${path.module}/deploy.yaml")
}

output "services" {
  value = akash_deployment.hello_world.services
}
```
