# Guided Deployments

The Akashian Challenge Phase 3 will test and showcase Akash DeCloud’s deployment platform. Akashian Challengers will be incentivized to deploy applications using the Akash Network. Encompassing two weeks, Phase 3 will include guided challenges for deploying applications of increasing complexity — from simple single-page applications to blockchain network components, and open ended challenges where users can show off their Akash OPS skills by extending the guided examples to deploy any application they desire — from DeFi to CI.

There are additional rewards for participation outside of the deployment challenges, including contributions such as active validator participation, writing blog posts and how-to guides, and sharing novel uses of our platform.

**Qualification Criteria**:

Although we do not limit anyone from participating, to claim AKT rewards:

* You must not be a resident of any of the OFAC sanctioned countries.
* You must pass KYC/AML verification when collecting the reward. The details for which will be posted at a later time.

## Week 1: Challenge 1 

**Challenge**: Deploy a web app on Akash and attach a custom domain.

**Reward**: 150 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:

1) Sign up to Akash [Testnet](https://app.akash.network).
2) Follow the [instructions](/guides/deploy) for deploying a web app on Akash.

**Submission**:

1) Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).
2) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3) Submit the JSON for you lease with the **Participation ID** from [Testnet](https://app.akash.network) as the filename under `akashian/phase3/challenge1` directory.

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

## Week 1: Challenge 2

**Challenge**: Deploy a databased-backed web app on Akash and attach a custom domain.

**Reward**: 200 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:
1. Sign up to Akash [Testnet](https://app.akash.network).
2. Follow the [instructions](https://docs.akash.network/v/master/guides/deploy) for deploying a web app on Akash.

**Submission**:
1. Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).
2. Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```

3. Create a file with the `deployment id` mapped and your participation id from [Testnet](https://app.akash.network). For example:

  ```shell
  echo "0082fa1da40c1a50489f51404e914c191f06e0122d4dff8a7f54027a280a0e55/1/2/d4a9d2283e2d6a442c95d7593ec9ad7bd22b68eca41905f1154b05d12430fa67" > 3bif3qp17x22l
  ```

  Where `3bif3qp17x22l` is the participation id and `0082fa1da40c1a50489f51404e914c191f06e0122d4dff8a7f54027a280a0e55/1/2/d4a9d2283e2d6a442c95d7593ec9ad7bd22b68eca41905f1154b05d12430fa67` is the deployment id. See [submissions](akashian/phase3/challenge1) for examples.

4. Commit your code, and send a pull request to [ecosystem repo](https://github.com/ovrclk/ecosystem).

## Week 1: Challenge 3

**Challenge**: Deploy a single node network on Akash.

**Reward**: 250 AKTs

**Winners**: First 200 submissions — measured by the timestamp of the git commit — that pass the qualification criteria. 

**Instructions**:
1. Sign up to Akash [Testnet](https://app.akash.network).
2. Follow the [instructions](https://docs.akash.network/v/master/guides/deploy) for deploying a web app on Akash.

**Submission**:
1. Fork the [ecosystem repository](https://github.com/ovrclk/ecosystem).
2. Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/ecosystem.git
  ```
3. Create a file with the `deployment id` mapped and your participation id from [Testnet](https://app.akash.network). For example:

  ```shell
  echo "0082fa1da40c1a50489f51404e914c191f06e0122d4dff8a7f54027a280a0e55/1/2/d4a9d2283e2d6a442c95d7593ec9ad7bd22b68eca41905f1154b05d12430fa67" > 3bif3qp17x22l
  ```

  Where `3bif3qp17x22l` is the participation id and `0082fa1da40c1a50489f51404e914c191f06e0122d4dff8a7f54027a280a0e55/1/2/d4a9d2283e2d6a442c95d7593ec9ad7bd22b68eca41905f1154b05d12430fa67` is the deployment id. See [submissions](akashian/phase3/challenge1) for examples.

4. Commit your code, and send a pull request to [ecosystem repo](https://github.com/ovrclk/ecosystem).
