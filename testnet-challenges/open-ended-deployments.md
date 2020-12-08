As a generic cloud platform, Akash DeCloud has the potential to be used in a wide variety of use cases. This open-ended challenge is meant to explore what kinds of applications can be deployed on DeCloud, and how.

You’ll support the Akash DeCloud community by finding unique applications to deploy and sharing your deployment configuration via a pull request on [Awesome Akash](https://github.com/ovrclk/awesome-akash).

## Rewards

| Task | Reward | Notes |	Start |	Deadline
| --- | --- | --- | --- | --- | ---
| Unique Application Added to Awesome Akash List |500	| Up to first 200	| December 7, 2020 at 9AM	| December 11, 2020 at 5PM
| Deployed an application from the Awesome Akash List	| 150	|Up to first 200	| December 7, 2020 at 9AM	| December 11, 2020 at 5PM

## Submission

**Instructions**:

1) Sign up to Akash [Testnet](https://app.akash.network).

2) Create an [SDL](/sdl) for your application and use the [deploy guides](/guides/deploy) to deploy it.

4) Fork the [Awesome Akash Repository](https://github.com/ovrclk/awesome-akash).

5) Clone the ecosystem repository to your workstation. For example, where `<user>` is your GitHub username:
  
  ```shell
  git clone https://github.com/<user>/awesome-akash.git
  ```

6) Create a directory for your app in the `awesome-akash` repository.

1. Add your [SDL](/sdl) file to the directory for your application.
1. Add a `README.md` to your application directory that describes your application and any special instructions needed for deploying it.
1. Add your app to the list of applications in the main [`README.md`](https://github.com/ovrclk/awesome-akash/blob/master/README.md)

7) Commit your code; include your **Participation ID** from [Testnet](https://app.akash.network) in the body of
the commit message.

8) Send a pull request to [Awesome Akash Repository](https://github.com/ovrclk/awesome-akash).  Include your **Participation ID** from [Testnet](https://app.akash.network) in the title of the pull request like so:

> ID dgbfr0rugcxnyuu: Add Lunie-Lite to DeFi apps

The body of the PR should include instructions for verifying your app.  In most cases, including a link to your
deployed app will suffice.  To ensure that all the information is present, include the output of `akash provider lease-status`.

Tag your PR with the appropriate app category.

Please see [this](https://github.com/ovrclk/awesome-akash/pull/22) for an example of a well-formed pull request.

9) We will review and visit your app and merge the PR when it has been verified.  When your PR has been merged you
may close the deployment (see [guides](/guides/deploy) for instructions on closing deployments).
