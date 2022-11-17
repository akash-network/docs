# Install streamlined environment locally



The below set of steps downloads the environment for easier setup. For advanced usage, check [Install Akash CLI client](../detailed-steps/part-1.-install-akash.md).

## Download Source Code

* Download the Akash Client source code into your home directory and within a subdirectory named `demo`

```
cd ~

git clone https://github.com/ovrclk/demo-env.git demo

cd demo
```

## Install Akash CLI Client

```
apt install make

apt-get install unzip

make install
```

## Verify Installation

* Issue the following command to verify successful install of the Akash CLI client
* Output that displays the installed Akash client version equals a successful install and verification

```
akash version
```
