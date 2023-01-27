# STEP2 - Add Akash Install Location in the User’s Path

Add the Akash install location to the user’s path for ease of use.

**NOTE -** below we provide the steps to add the Akash install directory to a user’s path on a Linux Ubuntu server.  Please take a look at a guide for your operating system and how to add a directory to a user’s path.

### Open User’s Path Settings in an Editor

```
vi /etc/environment
```

### View Current Path Settings

* It is always best practice to view the path within a text editor or cat it out to console prior to the update to avoid errors.
* Example file_**:**_

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
```

### Add the Akash Executable Path

* Add the following directory, which is the Akash install location, to PATH
*   _**Note**_ - this assumes Akash was installed while logged in as the root user.

    ```
    /root/bin
    ```

### Post Update Path Settings

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/bin"
```

### Activate New Path Settings

*   Make the new path active in the current session

    ```
    . /etc/environment
    ```

### Verify New Path Settings and Akash Install

*   Display the version of Akash software installed.  This confirms the software installed and that the new user path addition worked.

    ```
    akash version
    ```
* Expected result (version displayed may be different)

```
root@ip-10-0-10-146:~# akash version

v0.22.0
```
