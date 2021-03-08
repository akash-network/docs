# Network Support

{% hint style="warning" %}
The incentivized testnet has completed - there are no more challenges to earn rewards from.

Thank you for your interest; stay tuned for more opportunities to participate in the future!
{% endhint %}

While validators and other network components are not necessarily targeted in this testnet, they are of course essential to maintaining a healthy DeCloud.

Leverage this testnet to practice your operations, or try new ones.

To earn rewards for this challenge, you should be actively participating — keep your component\(s\) up-to-date and respond to any network proposals that may come up.

**Qualification Criteria**:

Although we do not limit anyone from participating, to claim AKT rewards:

* You must not be a resident of any of the OFAC sanctioned countries.
* You must pass KYC/AML verification when collecting the reward. The details for which will be posted at a later time.

## Challenges and Rewards

| Task | Reward \(AKT\) | Limit | Start | Deadline |
| :--- | :--- | :--- | :--- | :--- |
| Maintain an active validator with over 80% uptime two-week testnet period | 1000 | 50 | November 30, 2020 at 9AM | December 11, 2020 at 5PM |
| Maintain a public RPC endpoint over 80% uptime two-week testnet period | 1000 | 50 | November 30, 2020 at 9 AM | December 11, 2020 at 5PM |
| Maintain a public gRPC endpoint over 80% uptime two-week testnet period | 1000 | 50 | November 30, 2020 at 9AM | December 11, 2020 at 5PM |

## Instructions

1\) Sign up to Akash [Testnet](https://app.akash.network).

2\) Follow the [node guides](../../guides/node/) to install and configure your node to run on the current **edgenet** network. For full points, ensure that the following are running and publicly-accessible:

* [API Node](../../guides/node/api-service.md)
* [RPC Node](../../guides/node/rpc-service.md)
* [Validator](../../guides/node/validator.md)

## Submission

When your node is ready, make a pull request on [ovrclk/net](https://github.com/ovrclk/net) that adds your host to the appropriate registries:

| Type | Description |
| :--- | :--- |
| Validator | Configure your validator and add its P2P connection details to `edgenet/seed-nodes.txt`. |
| RPC Node | Host an RPC node and add its connection details to `edgenet/rpc-nodes.txt` |
| API Node | Host an API node and add its connection details to `edgenet/api-nodes.txt` |

Include your **Participation ID** from [Testnet](https://app.akash.network) and the component you are submitting in the title of the pull request in the following form:

```text
testnet network support - <participation id> - <comma separated list of components>
```

For example:

```text
testnet network support - dgbfr0rugcxnyuu - validator,rpc,api
```

We will be polling all submissions throughout the testnet - stay up to date, active, and involved to maximize your points!

