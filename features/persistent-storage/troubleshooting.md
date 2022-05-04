# Troubleshooting

## Hostname Conflict - May Cause Manifest Send Errors

If the hostname defined in the accept field is already in use within the Akash provider, a conflict occurs if another deployment attempts to launch with the same hostname.  This could occur within our testnet environment if multiple people are attempting to use the same SDL and deploy to the same provider.  Consider changing the accept field to a unique hostname (I.e. \<myname>.locahost) if you receive an error in send of the manifest to the provider.

```
 grafana:
    image: grafana/grafana
    expose:
      - port: 3000
        as: 80
        to:
          - global: true
        accept:
          - webdistest.localhost
```
