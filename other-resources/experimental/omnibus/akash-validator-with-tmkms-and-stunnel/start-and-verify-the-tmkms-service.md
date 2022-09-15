# Start and Verify the TMKMS Service

All steps in this section should be performed on the TMKMS server unless otherwise noted

## Start the TMKMS Service

```
tmkms start -c $HOME/tmkms/config/tmkms.toml
```

### Initial Log Messages

* The following connection error messages will initially display after the TMKMS service start
* Wait approximately 5-10 minutes for the connection to establish and at which time these error messages should cease

```
2022-03-08T23:42:37.926816Z  INFO tmkms::commands::start: tmkms 0.11.0 starting up...
2022-03-08T23:42:37.926968Z  INFO tmkms::keyring: [keyring:softsign] added consensus Ed25519 key: osmovalconspub1zcjduepq2qfkp3ahrhaafzuqglme9mares0eluj58xr6cy7c37cdmzq0eecqk0yehr
2022-03-08T23:42:37.927216Z  INFO tmkms::connection::tcp: KMS node ID: 948f8fee83f7715f99b8b8a53d746ef00e7b0d9e
2022-03-08T23:42:37.929454Z ERROR tmkms::client: [osmosis-1@tcp://123.456.32.123:26659] I/O error: Connection refused (os error 111)
```

### Log Messages Indicating Successful TMKMS Connection

* _**NOTE**_ - these verifications and log entries will not be seen until after the Stunnel Client is created and configured
* Eventually the following TMKMS log messages should display indicating successful connection between the TMKMS server and the Akash validator

```
2022-09-15T00:08:10.604353Z  INFO tmkms::connection::tcp: KMS node ID: 7a1f7c7f726d94787045cca9fee05c1ec67cd09a
2022-09-15T00:08:10.899641Z  INFO tmkms::session: [akashnet-2@tcp://127.0.0.1:36658] connected to validator successfully
2022-09-15T00:08:10.899670Z  WARN tmkms::session: [akashnet-2@tcp://127.0.0.1:36658]: unverified validator peer ID! (aa9cdfb9e1af2d8033168f562941a95c98545372)
```

### Active Validator Set Log Messages

* If the Akash validator is part of the active set the following singed block messages should be seen in the TMKMS logs

```
2022-03-08T23:46:06.208451Z  INFO tmkms::connection::tcp: KMS node ID: 948f8fee83f7715f99b8b8a53d746ef00e7b0d9e
2022-03-08T23:46:06.210568Z  INFO tmkms::session: [osmosis-1@tcp://164.92.136.160:26659] connected to validator successfully
2022-03-08T23:46:06.210604Z  WARN tmkms::session: [osmosis-1@tcp://164.92.136.160:26659]: unverified validator peer ID! (ba44dd36899602e255b04e3608e5ef0fe4bc5f5b)
2022-03-08T23:46:15.929787Z  INFO tmkms::session: [osmosis-1@tcp://164.92.136.160:26659] signed PreCommit:<nil> at h/r/s 3399910/0/2 (0 ms)
2022-03-08T23:46:17.344579Z  INFO tmkms::session: [osmosis-1@tcp://164.92.136.160:26659] signed PreCommit:<nil> at h/r/s 3399911/0/2 (0 ms)
2022-03-08T23:46:22.367627Z  INFO tmkms::session: [osmosis-1@tcp://164.92.136.160:26659] signed PreCommit:<nil> at h/r/s 3399912/0/2 (0 ms)
2022-03-08T23:46:27.409777Z  INFO tmkms::session: [osmosis-1@tcp://164.92.136.160:26659] signed PreCommit:<nil> at h/r/s 3399913/0/2 (0 ms)
2022-03-08T23:46:32.442300Z  INFO tmkms::session: [osmosis-1@tcp://164.92.136.160:26659] signed PreCommit:<nil> at h/r/s 3399914/0/2 (0 ms)
2022-03-08T23:46:37.452162Z  INFO tmkms::session: [osmosis-1@tcp://164.92.136.160:26659] signed PreCommit:<nil> at h/r/s 3399915/0/2 (0 ms)
```
