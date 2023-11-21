# Kill Zombie Processes

## Issue

There's a possibility that some pods initiate processes without correctly using the `wait()` function, leading to the creation of `<defunct>` processes, commonly known as "zombie" processes. These could potentially occupy all available process slots.

These zombie processes aren't too harmful much (they don't occupy cpu/mem / nor impact cgroup cpu/mem limits) unless they take up the whole process table space so no new processes will be able to spawn, i.e. the limit:

```
$ cat /proc/sys/kernel/pid_max
4194304
```

To address this issue, tenants should ensure they manage and terminate child processes appropriately to prevent them from becoming zombie processes.

One of the correct ways to approach that would be this example:

```
#!/bin/bash

# Start the first process
./my_first_process &

# Start the second process
./my_second_process &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
```

Or using a proper container init (tini) / supervision system (such as s6, supervisor, runsv, ...) that would reap adopted child processes.

Refs

- https://docs.docker.com/config/containers/multi-service_container/#use-a-wrapper-script
- https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/


## Example of the zombie processes on the provider

Someone's running a wrongly configured image, with the `service ssh start` in it, which fails to start, hence creating bunch of `<defunct>` zombie `sshd` processes growing every `20` seconds:

```
root      712532  696516  0 14:28 ?        00:00:00      \_ [bash] <defunct>
syslog    713640  696516  0 14:28 ?        00:00:00      \_ [sshd] <defunct>
root      807481  696516  0 14:46 ?        00:00:00      \_ [bash] <defunct>
root      828096  696516  0 14:50 ?        00:00:00      \_ [bash] <defunct>
root      835000  696516  0 14:51 pts/0    00:00:00      \_ [haproxy] <defunct>
root      836102  696516  0 14:51 ?        00:00:00      \_ SCREEN -S webserver
root      836103  836102  0 14:51 ?        00:00:00      |   \_ /bin/bash
root      856974  836103  0 14:55 ?        00:00:00      |       \_ caddy run
root      849813  696516  0 14:54 pts/0    00:00:00      \_ [haproxy] <defunct>
pollina+  850297  696516  1 14:54 ?        00:00:40      \_ haproxy -f /etc/haproxy/haproxy.cfg
root      870519  696516  0 14:58 ?        00:00:00      \_ SCREEN -S wallpaper
root      870520  870519  0 14:58 ?        00:00:00      |   \_ /bin/bash
root      871826  870520  0 14:58 ?        00:00:00      |       \_ bash change_wallpaper.sh
root     1069387  871826  0 15:35 ?        00:00:00      |           \_ sleep 20
syslog    893600  696516  0 15:02 ?        00:00:00      \_ [sshd] <defunct>
syslog    906839  696516  0 15:05 ?        00:00:00      \_ [sshd] <defunct>
syslog    907637  696516  0 15:05 ?        00:00:00      \_ [sshd] <defunct>
syslog    913724  696516  0 15:06 ?        00:00:00      \_ [sshd] <defunct>
syslog    914913  696516  0 15:06 ?        00:00:00      \_ [sshd] <defunct>
syslog    922492  696516  0 15:08 ?        00:00:00      \_ [sshd] <defunct>
```

## Steps to implement a workaround for the providers

Providers can't control this, hence they are recommended to implement the following workaround across all worker nodes.

1. create `/usr/local/bin/kill_zombie_parents.sh` script

```
cat > /usr/local/bin/kill_zombie_parents.sh <<'EOF'
#!/bin/bash

# This script detects zombie processes and kills their parent processes.

# Get a list of zombie processes.
zombies=$(ps -eo pid,ppid,stat,cmd | awk '$3 == "Z" { print $2 }' | sort -u)

# If there are no zombies, exit.
if [[ -z "$zombies" ]]; then
    #echo "No zombie processes found."
    exit 0
fi

# Kill parent processes of the zombies.
for parent in $zombies; do
    # Double check that the parent process is still alive.
    if kill -0 $parent 2>/dev/null; then
        echo "Killing parent process $parent."
        kill -TERM $parent
        sleep 2  # Give the process a chance to terminate.
        
        # Force kill if it didn't terminate.
        if kill -0 $parent 2>/dev/null; then
            echo "Force killing parent process $parent."
            kill -KILL $parent
        fi
    fi
done
EOF
```

2. mark it as executable
```
chmod +x /usr/local/bin/kill_zombie_parents.sh
```

3. create cronjob

This way the workaround will automatically run every 5 minutes.

```
cat > /etc/cron.d/kill_zombie_parents << 'EOF'
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
SHELL=/bin/bash

*/5 * * * * root /usr/local/bin/kill_zombie_parents.sh
EOF
```
