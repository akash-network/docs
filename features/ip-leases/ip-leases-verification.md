# IP Leases Verification

Assigned IP Leases info can be displayed from the Akash CLI via the `lease-status` command.

_**NOTE**_ _**-**_ ensure the `AKASH_DSEQ` and `AKASH_PROVIDER` environment variables are defined prior to issuing this command. Additional info on environment variables set up for the Akash CLI is available [here](broken-reference).

```
provider-services lease-status --from $AKASH_ACCOUNT_ADDRESS
```

### Example/Expected Output

**NOTE** - the IP Leases info displayed in the `ips` section.

```
{
  "services": {
    "web": {
      "name": "web",
      "available": 1,
      "total": 1,
      "uris": [
        "bnd9dtb1rddsl6gfcn3q0j771g.www.nocixp1.iptestnet.akashian.io"
      ],
      "observed_generation": 1,
      "replicas": 1,
      "updated_replicas": 1,
      "ready_replicas": 1,
      "available_replicas": 1
    }
  },
  "forwarded_ports": null,
  "ips": {
    "web": [
      {
        "Port": 3000,
        "ExternalPort": 80,
        "Protocol": "TCP",
        "IP": "198.204.231.229"
      }
    ]
  }
}
```
