# Create an Account

Configure the name of your key. The command below will set the name of your key to `myWallet`, run the below command and replace `myWallet` with a name of your choice:

```bash
AKASH_KEY_NAME=myWallet
```

Verify you have the shell variables set up . The below command should return the name you've used:

```bash
echo $AKASH_KEY_NAME
```

We now need to point Akash to where the keys are stored for your configuration. To do this we will set the AKASH\_KEYRING\_BACKEND environmental variable.

```bash
AKASH_KEYRING_BACKEND=os
```

Copy and paste this command into Terminal to create an Akash account:

```bash
provider-services keys add $AKASH_KEY_NAME
```

Read the output and save your mnemonic phrase is a safe place. Let's set a Shell Variable in Terminal `AKASH_ACCOUNT_ADDRESS` to save your account address for later.

```bash
export AKASH_ACCOUNT_ADDRESS="$(provider-services keys show $AKASH_KEY_NAME -a)"

echo $AKASH_ACCOUNT_ADDRESS
```

Note that if you close your Terminal window this variable will not be saved.
