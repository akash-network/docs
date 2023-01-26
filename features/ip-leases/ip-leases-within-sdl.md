# IP Leases within SDL

To illustrate the use of an IP Leases the simple Hello World SDL is used. Please refer to the full SDL used in this document for further clarification on the place of reviewed stanzas.

## Endpoints Stanza

IP Leases can be included in any SDL via the addition of the endpoints section. The endpoints section must be created at the top level of the SDL.

In this example we name the endpoint `myendpoint` but could be any name of your choosing.

The kind is defined as `ip` which is the only valid option at this time. This adds a requirement that the SDL leases exactly one IPv4 address from a provider.

_**NOTE**_ - the endpoint name must be unique across your deployments on a single provider. Using the example - if we tried to use `myendpoint` in another deployment and on the same provider - no IP lease would be created on that second deployment.

```
endpoints:
 myendpoint:
   kind: ip
```

## Services Stanza

In the services stanza we create the association with the endpoint detailed previously.

In this example we have a service running a docker container with port `3000` globally exposed. Additionally the `myendpoint` endpoint is defined via the `ip` key .

_**NOTE**_ - if an endpoint is declared in an SDL, it must be used at least once. Specifying an endpoint name that is not declared results in an error during deployment.

```
services:
 web:
   image: akashlytics/hello-akash-world:0.2.0
   expose:
     - port: 3000
       as: 80
       to:
         - global: true
           ip: myendpoint
```

## Attributes

Include the attribute key-value pair of `ip-lease: true` in the SDL.  This ensures that only provider advertising this attribute will bid on the workload.

```
     attributes:
        ip-lease: true
```
