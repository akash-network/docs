# Stunnel Client

## Overview

* The Stunnel client is used to connect to the Stunnel server which was co-located on the Akash Validator server in prior steps
* We will install the Stunnel client via Docker Compose
* The Stunnel client must co-exist on the same server as TMKMS which was built in the prior step

## Stunnel Client Source Code

### Stunnel Repository with Docker Files

* The Stunnel Dockerfile and Docker Compose files used in this section are located [here](https://github.com/ovrclk/stunnel-proxy) for your review

### Pull Down a Copy of the Stunnel Repo

* This step and all subsequent steps should be performed on the server TMKMS was installed on prior

```
mkdir ~/stunnel
cd ~/stunnel
git clone https://github.com/ovrclk/stunnel-proxy
```

## Customize the Stunnel Client Docker Compose File

* Navigate into the `client` directory and make necessary updates to the `docker-compose.yml`file as detailed below

```
cd ~/stunnel/stunnel-proxy/client
vi docker-compose.yml
```

### Necessary Docker Compose File Updates

* Use the details captured in the [Akash Validator Deployment](akash-validator-deployment.md) section of the guide - within the `Capture Deployment URI and Port` subsection - for the Docker Compose file updates discussed below

#### STUNNEL\_SVC\_RPC\_CONNECT

* Update the `STUNNEL_SVC_RPC_CONNECT` field
* This field should use the exposed Proxy/RPC port captured during the Akash Validator deployment and within this step
* Template - update the provider and exposed port variables with your unique Akash deployment values

```
STUNNEL_SVC_RPC_CONNECT=<akash-provider-url>:<expose-proxy-port>
```

* Example of the setting based on the example deployment in this guide

```
STUNNEL_SVC_RPC_CONNECT=provider.mainnet-1.ca.aksh.pw:32675
```

#### STUNNEL\_SVC\_SIGNER\_CONNECT

* Update the `STUNNEL_SVC_SIGNER_CONNECT` field
* This field should use the exposed Signer port captured during the Akash Validator deployment and within this step
* Template - update the provider and exposed port variables with your unique Akash deployment values

```
STUNNEL_SVC_SIGNER_CONNECT=<akash-provider-url>:<signer-port>
```

* Example of the setting based on the example deployment in this guide

```
STUNNEL_SVC_SIGNER_CONNECT=provider.mainnet-1.ca.aksh.pw:31684
```

#### Network > Server\_Default Setting

* Update the Network > Server\_Default setting to external: false such as:

```
networks:
  server_default:
    external: false
```

#### Pre-Shared Key (PSK)

* Ensure the PSK field matches the value defined earlier in the [Akash Validator Deployment](akash-validator-deployment.md) section

### Example `docker-compose.yaml` File

```
version: "3.3"
services:
  stunnel:
    build: ../
    environment:
      - PSK=DmtaC6N3HOWFkJZpNZs2dkabFT5yQONw
      - STUNNEL_SVC_RPC_CLIENT=yes
      - STUNNEL_SVC_RPC_ACCEPT=0.0.0.0:36657
      - STUNNEL_SVC_RPC_CONNECT=provider.mainnet-1.ca.aksh.pw:32323
      - STUNNEL_SVC_SIGNER_CLIENT=yes
      - STUNNEL_SVC_SIGNER_ACCEPT=0.0.0.0:36658
      - STUNNEL_SVC_SIGNER_CONNECT=provider.mainnet-1.ca.aksh.pw:32435
    networks:
      - server_default
    ports:
      - '36657:36657'
      - '36658:36658'
networks:
  server_default:
    external: false
```

## Docker Compose Up

* Create the Stunnel Client Container

```
cd ~/stunnel/stunnel-proxy/client
docker compose up -d
```

## Stunnel Client Successful Connection Logs

### Confirm Name of Container

```
docker container ls
```

#### Example Output

```
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                                                                   NAMES
a4bd1b21f551   client-stunnel   "/usr/local/configur…"   44 minutes ago   Up 44 minutes   0.0.0.0:36657-36658->36657-36658/tcp, :::36657-36658->36657-36658/tcp   client-stunnel-1
```

### View Stunnel Client Container Logs

```
docker container logs <container-name-obtained-in-last-step>
```

#### Example

```
docker container logs client-stunnel-1
```

### &#x20;Example Logs Indicating Successful Connection

```
client-stunnel-1  | 2022.09.15 00:08:09 LOG6[0]: s_connect: connecting 216.202.234.124:30017
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: s_connect: s_poll_wait 216.202.234.124:30017: waiting 10 seconds
client-stunnel-1  | 2022.09.15 00:08:09 LOG5[0]: s_connect: connected 216.202.234.124:30017
client-stunnel-1  | 2022.09.15 00:08:09 LOG5[0]: Service [signer] connected remote server from 172.18.0.2:48336
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: Setting remote socket options (FD=8)
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: Option TCP_NODELAY set on remote socket
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: Remote descriptor (FD=8) initialized
client-stunnel-1  | 2022.09.15 00:08:09 LOG6[0]: SNI: sending servername: provider.mainnet-1.ca.aksh.pw
client-stunnel-1  | 2022.09.15 00:08:09 LOG6[0]: Peer certificate not required
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): before SSL initialization
client-stunnel-1  | 2022.09.15 00:08:09 LOG6[0]: PSK client configured for identity "node"
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS write client hello
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS write client hello
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS read server hello
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS write change cipher spec
client-stunnel-1  | 2022.09.15 00:08:09 LOG6[0]: PSK client configured for identity "node"
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: Deallocating application specific data for session connect address
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS write client hello
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS write client hello
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: Deallocating application specific data for session connect address
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS read server hello
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): TLSv1.3 read encrypted extensions
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS read finished
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]: TLS state (connect): SSLv3/TLS write finished
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]:      1 client connect(s) requested
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]:      1 client connect(s) succeeded
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]:      0 client renegotiation(s) requested
client-stunnel-1  | 2022.09.15 00:08:09 LOG7[0]:      1 session reuse(s)
```
