# Obtain a Deployment’s Logs

```
akash_logs -f
```

#### Example/Expected Output

```
root@ip-10-0-10-163:~/akash-tools/cli-booster[http://akash-sentry01.skynetvalidators.com:26657][deploymentone][4815131-1-1-web]$ akash_logs -f

Enter keyring passphrase:
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
[akash1f53fp8kk470f7k26yr5gztd9npzpczqv4ufud7/4815131/1/1/akash14c4ng96vdle6tae8r4hc2w4ujwrsh3x9tuudk0][web-7d44bb6d6f-n9cbk] /docker-entrypoint.sh: Configuration complete; ready for start up
```
