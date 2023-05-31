# STEP 6 - DNS Configuration

## Upstream DNS Servers

Add  `upstream_dns_servers` in your Ansible inventory

```
$ cd kubespray
kubespray$ grep -A2 upstream_dns_servers inventory/akash/group_vars/all/all.yml
upstream_dns_servers:
  - 8.8.8.8
  - 8.8.4.4
```
