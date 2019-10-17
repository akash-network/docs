# Akash Developer Documentation

Akash is a decentralized protocol for provisioning, scaling and securing cloud workloads.

This repository contains source code for Akash documentation hosted at [akash.network](http://akash.network/docs).

## Dependencies

This project has the below dependencies:

- Ruby ~> 2.3.1
- Bundler ~> 1.16.1
- Docker ~> 18.6

Once you have installed the dependencies, run `make installdeps` to install gem dependencies

## Build

The below command will build a static version of the site and place the contents under `build`

```
$ make build
```

### Docker

To build a docker image, run:

```
$ make img
```

## Run

The below command will run `middleman` server

```sh
$ make server
```

### Docker (optional)

To run a docker image instead, execute the below:

```
$ make img-run
```

Visit http://localhost:8080 in your browser

## Deploy

Bump the version in `VERSION` file to create a new tag. Deployments on akash are currently limited to a new version of an image.

First check the current version:

```shell
$ cat VERSION

0.0.4
```

Bump the version and run `make deploy`

```shell
$ echo "0.0.5" > VERSION
$ make deploy
```
