# Terraform Manifest - Complete Example

* Replace the \`account\_address\` and \`key-name\` with your own values

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
  account_address = "akash1g<redacted>
  keyring_backend = "os"
  key_name = "mykey"
  node = "https://akash-rpc.polkachu.com:443"
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
