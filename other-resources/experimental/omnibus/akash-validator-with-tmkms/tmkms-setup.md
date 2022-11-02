# TMKMS Setup

## Prepare TMKMS Dependencies (Ubuntu Instructions)

* All steps in this section should be performed on the TMKMS server unless otherwise noted

### **Rust Install**

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source $HOME/.cargo/env
```

### **GCC**

```
sudo apt update

sudo apt install git build-essential ufw curl jq snapd --yes
```

### **Libusb**

```
apt install libusb-1.0-0-dev

export RUSTFLAGS=-Ctarget-feature=+aes,+ssse3
```

## Setup TMKMS

* All steps in this section should be performed on the TMKMS server unless otherwise noted

### Compiling TMKMS from Source Code

```
cd ~
git clone https://github.com/iqlusioninc/tmkms.git
cd ~/tmkms
cargo install tmkms --features=softsign
mkdir /etc/tmkms
tmkms init /etc/tmkms/
```

### Copy Validator Private Key into TMKMS Config File

* Create the `priv_validator_key.json` file

```
vi ~/tmkms/config/secrets/priv_validator_key.json
```

* Copy/paste the validator private key into the `priv_validator_key.json` file

### **Import the Private Validator Key into TMKMS**

```
tmkms softsign import ~/tmkms/config/secrets/priv_validator_key.json ~/tmkms/config/secrets/priv_validator_key
```

### **Delete Private Key File on the Validator**

* Conduct this step on the Akash Validator machine
* Securely delete the priv\_validator\_key.json from your validator node and store it safely offline in case of an emergency. The `priv_validator_key` will be what TMKMS will use to sign for your validator.
* Return to the TMKMS server after this step to complete subsequent steps in this section

```
shred -uvz ~/.akash/config/priv_validator_key.json
```

## **Modify tmkms.toml**

* Begin by deleting the existing `tmkms.toml` file and re-creating anew

```
rm ~/tmkms/config/tmkms.toml

vi ~/tmkms/config/tmkms.toml
```

* Copy the following configuration into the new `tmkms.toml` file
* Updating this file with your Akash validator URI - in the `addr` field - is the only edit that should be necessary
* The Akash validator URI was revealed and captured in the [Akash Validator Deployment](../../../../validating/akash-validator-with-tmkms-and-stunnel/akash-validator-deployment.md) section of this guide
* Refer to the [example](tmkms-setup.md#example-tmkms.toml-file) for further clarification

```
## Chain Configuration

### Cosmos Hub Network

[[chain]]
id = "akashnet-2"
key_format = { type = "bech32", account_key_prefix = "akashpub", consensus_key_prefix = "akashvalconspub" }
state_file = "/root/tmkms/config/state/priv_validator_state.json"

## Signing Provider Configuration

### Software-based Signer Configuration

[[providers.softsign]]
chain_ids = ["akashnet-2"]
key_type = "consensus"
path = "/root/tmkms/config/secrets/priv_validator_key"

## Validator Configuration

[[validator]]
chain_id = "akashnet-2"
addr = "tcp://<akash-provider-address>:<akash-deployment-port>"
secret_key = "/etc/tmkms/secrets/kms-identity.key"
protocol_version = "v0.34"
reconnect = true
```

#### Example tmkms.toml File

```
## Chain Configuration

### Cosmos Hub Network

[[chain]]
id = "akashnet-2"
key_format = { type = "bech32", account_key_prefix = "akashpub", consensus_key_prefix = "akashvalconspub" }
state_file = "/root/tmkms/config/state/priv_validator_state.json"

## Signing Provider Configuration

### Software-based Signer Configuration

[[providers.softsign]]co
chain_ids = ["akashnet-2"]
key_type = "consensus"
path = "/root/tmkms/config/secrets/priv_validator_key"

## Validator Configuration

[[validator]]
chain_id = "akashnet-2"
addr = "tcp://provider.mainnet-1.ca.aksh.pw:31508"
secret_key = "/etc/tmkms/secrets/kms-identity.key"
protocol_version = "v0.34"
reconnect = true
```
