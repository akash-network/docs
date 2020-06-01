## How to Upgrade

If the proposal goes through, everyone gets to switch/update their binaries to new version (v0.7.2). The old binary (v0.7.2) will stop working from 01 June, 16:00 UTC and it won't be able to sync/sign new blocks from then.

Note: We should use new binaries only after 01 June, 16:00UTC, if you try to update it before, it fails.

### Download the binaries

Download the [linux archive](https://github.com/ovrclk/akash/releases/download/v0.7.2/akash_0.7.2_linux_amd64.zip) from the [release page](https://github.com/ovrclk/akash/releases/tag/v0.7.2).

Alternatively, install the `v0.7.2` version via [`godownloader`](https://github.com/goreleaser/godownloader) with:

```sh
curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh -s -- v0.7.2
```

The final step is to make sure that the akash binaries are available in your shell `PATH`.[This page](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix) contains instructions for setting the PATH on Linux.

### Build from source

Installing Akash suite from source

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ git checkout v0.7.2
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.14+](https://golang.org/). Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Most golang libraries will be installed via `go mod`, however the following packages will be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akashctl` and `akashd` using `make install`
