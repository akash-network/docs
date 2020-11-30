# Guided Deployments

In Week 1, challenges will focus on deploying stand-alone applications, from website deployments to single-node blockchain networks.

**Qualification Criteria**:

Although we do not limit anyone from participating, to claim AKT rewards:

* You must not be a resident of any of the OFAC sanctioned countries.
* You must pass KYC/AML verification when collecting the reward. The details for which will be posted at a later time.

{% hint %}
Each of these challenges will ask you to follow the [deployment guide](/guides/deploy) to deploy a specific [SDL](/sdl) file.
{% endhint %}

* [Challenge 1 (Week 1)](#challenge-2-week-1)
* [Challenge 2 (Week 1)](#challenge-2-week-1)
* [Challenge 3 (Week 1)](#challenge-3-week-1)

## Challenge 1 (Week 1)

**Challenge**: Deploy a web app on Akash and attach a custom domain.

**Reward**: 150 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

1) Sign up to Akash [Testnet](https://app.akash.network).

2) Using [this](deploy-1-1.yaml) SDL file when following the [deploy instructions](/guides/deploy) to deploy your own
instance of the [Lunie-Lite](https://github.com/luniehq/lunie-light) wallet.

### Submission

**Scoring Starts**: Nov 30, 2020 9:00 AM PT 

**Scoring End**: Dec 2, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge1` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge1/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \> akashian/phase3/challenge1/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.

4) Commit your code, and send a pull request to [ecosystem repo](https://github.com/ovrclk/ecosystem).

## Challenge 2 (Week 1)

**Challenge**: Deploy a databased-backed web app on Akash and attach a custom domain.

**Reward**: 200 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**: Instructions will be available on Dec 1, 2020 9:00 AM 

### Submission

**Scoring Starts**: Dec 1, 2020 9:00 AM PT 

**Scoring End**: Dec 3, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge2` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge2/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \> akashian/phase3/challenge1/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.

4) Commit your code, and send a pull request to [ecosystem repo](https://github.com/ovrclk/ecosystem).


## Challenge 3 (Week 1)

**Challenge**: Deploy a single node network on Akash.

**Reward**: 250 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**: Instructions will be available on Dec 2, 2020 9:00 AM 

### Submission

**Scoring Starts**: Dec 2, 2020 9:00 AM PT 

**Scoring End**: Dec 4, 2020 5:00 PM PT

**Instructions**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).

2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for your lease as the proof with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge2` directory.

For example, if your code is `dgbfr0rugcxnyuu`, the file will be `akashian/phase3/challenge2/dgbfr0rugcxnyuu.json`.

Popuate `$CODE` with your **Participation ID** from [Testnet](https://app.akash.network) and run the below:

```sh
akash query market lease get \
  --dseq $DSEQ \
  --gseq $GSEQ \
  --oseq $OSEQ \
  --provider $PROVIDER \
  --owner $ACCOUNT_ADDRESS \
  --node $AKASH_NODE -o json \> akashian/phase3/challenge1/$CODE.json
```

See https://github.com/ovrclk/ecosystem/tree/master/akashian/phase3/challenge1/dgbfr0rugcxnyuu.json for example.
