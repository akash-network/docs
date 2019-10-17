# Service Logs

**Usage**

```text
$ akash logs <service> <lease> [flags]
```

**Example**

```text
$ akash logs webapp 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 -f
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.307976982Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET / HTTP/1.1" 200 3583 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.614215684Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET /css/main.css HTTP/1.1" 200 195072 "http://webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.712794998Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET /images/qr.png HTTP/1.1" 200 7039 "http://webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
```

> In the example above, `webapp` is a simple web page serving static content.

Use `akash logs` to tail the application logs for each of your services.

**Arguments**

| Argument | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| service | string | Y | The service name originally defined in your deployment file |
| lease | string | Y | The lease ID belonging to that service, returned by `akash deployment status` |

**Flags**

| Short | Verbose | Argument | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| -f | --follow | none | N | Whether update the console with new log lines or simply return the last n lines defined by `-l`. |
| -l | --lines | uint | N | Number of lines from the end of the logs to show per service \(default 10\). |
| -n | --node | string | N | Node host \(defaults to [https://api.akashtest.net:80](https://api.akashtest.net:80)\). |
