## provider-services run

run akash provider

```
provider-services run [flags]
```

### Options

```
  -a, --account-number uint                         The account number of the signing account (offline mode only)
      --auth-pem string                             
      --bid-deposit string                          Bid deposit amount (default "5000000uakt")
      --bid-price-cpu-scale string                  cpu pricing scale in uakt per millicpu (default "0")
      --bid-price-endpoint-scale string             endpoint pricing scale in uakt (default "0")
      --bid-price-ip-scale string                   leased ip pricing scale in uakt (default "0")
      --bid-price-memory-scale string               memory pricing scale in uakt per megabyte (default "0")
      --bid-price-script-path string                path to script to run for computing bid price
      --bid-price-script-process-limit uint         limit to the number of scripts run concurrently for bid pricing (default 32)
      --bid-price-script-process-timeout duration   execution timelimit for bid pricing as a duration (default 10s)
      --bid-price-storage-scale string              storage pricing scale in uakt per megabyte (default "0")
      --bid-price-strategy string                   Pricing strategy to use (default "scale")
      --bid-timeout duration                        time after which bids are cancelled if no lease is created (default 5m0s)
  -b, --broadcast-mode string                       Transaction broadcasting mode (sync|async|block) (default "sync")
      --cached-result-max-age duration              max. cache age for results from the RPC node (default 5s)
      --chain-id string                             The network chain ID
      --cluster-k8s                                 Use Kubernetes cluster
      --cluster-node-port-quantity uint             The number of node ports available on the Kubernetes cluster (default 1)
      --cluster-public-hostname string              The public IP of the Kubernetes cluster
      --cluster-wait-ready-duration duration        The time to wait for the cluster to be available (default 5s)
      --deployment-blocked-hostnames strings        hostnames blocked for deployments
      --deployment-ingress-domain string            
      --deployment-ingress-expose-lb-hosts          
      --deployment-ingress-static-hosts             
      --deployment-network-policies-enabled         Enable network policies (default true)
      --deployment-runtime-class string             kubernetes runtime class for deployments, use none for no specification (default "gvisor")
      --docker-image-pull-secrets-name string       Name of the local image pull secret configured with kubectl
      --dry-run                                     ignore the --gas flag and perform a simulation of a transaction, but don't broadcast it
      --fee-account string                          Fee account pays fees for the transaction instead of deducting from the signer
      --fees string                                 Fees to pay along with transaction; eg: 10uatom
      --from string                                 Name or address of private key with which to sign
      --gas string                                  gas limit to set per-transaction; set to "auto" to calculate sufficient gas automatically (default 200000)
      --gas-adjustment float                        adjustment factor to be multiplied against the estimate returned by the tx simulation; if the gas limit is set manually this flag is ignored  (default 1)
      --gas-prices string                           Gas prices in decimal format to determine the transaction fee (e.g. 0.1uatom)
      --gateway-listen-address string               Gateway listen address (default "0.0.0.0:8443")
      --generate-only                               Build an unsigned transaction and write it to STDOUT (when enabled, the local Keybase is not accessible)
  -h, --help                                        help for run
      --hostname-operator-endpoint string           host & port for hostname-operator (empty for autodetect)
      --inventory-resource-debug-frequency uint     The rate at which to log all inventory resources (default 10)
      --inventory-resource-poll-period duration     The period to poll the cluster inventory (default 5s)
      --ip-operator                                 enable usage of the IP operator to lease IP addresses
      --ip-operator-endpoint string                 host & port for ip-operator (empty for autodetect)
      --k8s-manifest-ns string                      Cluster manifest namespace (default "lease")
      --keyring-backend string                      Select keyring's backend (os|file|kwallet|pass|test|memory) (default "os")
      --keyring-dir string                          The client Keyring directory; if omitted, the default 'home' directory will be used
      --kubeconfig string                           kubernetes configuration file path (default "$HOME/.kube/config")
      --lease-funds-monitor-interval duration       interval at which lease is checked for funds available on the escrow accounts. >= 1m (default 10m0s)
      --ledger                                      Use a connected Ledger device
      --manifest-timeout duration                   time after which bids are cancelled if no manifest is received (default 5m0s)
      --metrics-listener string                     ip and port to start the metrics listener on
      --minimum-balance uint                        minimum account balance at which withdrawal is started (default 10000000)
      --note string                                 Note to add a description to the transaction (previously --memo)
      --offline                                     Offline mode (does not allow any online functionality
  -o, --output string                               Output format (text|json) (default "json")
      --overcommit-pct-cpu uint                     Percentage of CPU overcommit
      --overcommit-pct-mem uint                     Percentage of memory overcommit
      --overcommit-pct-storage uint                 Percentage of storage overcommit
      --provider-config string                      provider configuration file path
      --rpc-query-timeout duration                  timeout for requests made to the RPC node (default 1m0s)
  -s, --sequence uint                               The sequence number of the signing account (offline mode only)
      --sign-mode string                            Choose sign mode (direct|amino-json), this is an advanced feature
      --timeout-height uint                         Set a block timeout height to prevent the tx from being committed past a certain height
      --tx-broadcast-timeout duration               tx broadcast timeout. defaults to 30s (default 30s)
      --withdrawal-period duration                  period at which withdrawals are made from the escrow accounts (default 24h0m0s)
  -y, --yes                                         Skip tx broadcasting prompt confirmation
```

### Options inherited from parent commands

```
      --node string   The node address (default "http://localhost:26657")
```

### SEE ALSO

* [provider-services](provider-services.md)	 - Provider services commands

###### Auto generated by spf13/cobra on 5-Dec-2022
