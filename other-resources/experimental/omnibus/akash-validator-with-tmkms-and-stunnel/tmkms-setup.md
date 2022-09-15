# TMKMS Setup

## Considerations

* In a future step in this guide we deploy a Stunnel client which must co-exist on the same machine as the TMKMS server
* For simplicity we use Docker Compose to build the Stunnel client
* We do not offer a TMKMS image based on security concerns in using a third party TMKMS image.  However you may want to consider using the Linux instructions below for TMKMS server build and get a container image yourself so that both the TKMKS server and the Stunnel client may both be deployed as containers on the single host.

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

<pre><code><strong>cd ~/tmkms
</strong><strong>mkdir -p config/secrets
</strong>mkdir config/state
vi ~/tmkms/config/secrets/priv_validator_key.json</code></pre>

* Copy/paste the validator private key into the `priv_validator_key.json` file

#### Example `priv_validator_key.json` file

```
{
  "address": "3407CC1<REDACTED>243E2865",
  "pub_key": {
    "type": "tendermint/PubKeyEd25519",
    "value": "5uAJKqd<REDACTED>mr5LrY6wsRs="
  },
  "priv_key": {
    "type": "tendermint/PrivKeyEd25519",
    "value": "d1feQqRc<REDACTED>p1pDs6B6avkutjrCxGw=="
  }
}
```

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
#Remove command will report `No such file or directory` if it did not exist prior
rm ~/tmkms/config/tmkms.toml

vi ~/tmkms/config/tmkms.toml
```

* Copy the following configuration into the new `tmkms.toml` file
* No edits to the file syntax below should be necessary

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
addr = "tcp://127.0.0.1:36658"
secret_key = "/etc/tmkms/secrets/kms-identity.key"
protocol_version = "v0.34"
reconnect = true
```
