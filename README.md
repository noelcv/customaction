# Custom GitHub Action

The structure of a custom GitHub Action require the following elements:

1. Dockerfile
2. Entrypoint.sh
3. Makefile
4. Metadata - Action.yml
5. README.md

## Dockerfile

We define the running environment, install the dependencies necessary for the Action, specify an entrypoint that will run all the instructions, and copy all the required files.

In this example, beyond the entrypoint script, we copy two python scripts - `deploy.py` and `exit.py` - that will run accordingly to the conditions specified in `entrypoint.sh`.

## Entrypoint.sh

This is a regular bash script that can contain any commands you like. Technically, all the jobs defined herein could also be specified in the ENTRYPOINT array of the Dockerfile, but it's not as tidy.

In our case, the first part of the script evaluates if a GITHUB_ENV_PATH is set to determine whether the job is running on GitHub and can access the workflow resources or if it running locally and shall use sample data instead.

In the second part of the script, we look into the event payload, and check if the commit message contains a keyword passed as an argument to determine whether to trigger the deployment process.


## testing the entrypoint script

```bash
#!/bin/bash
set -e

# if keyword is found
if echo "$*" | grep -i -q "DEPLOY";
then
  # do something: start deployment process
  python3 deploy.py

else
  # do nothing and exit gracefully
  python3 exit.py
fi
```

```bash
./entrypoint.sh deploy
```

```bash
#prints: DEPLOY keyword found in commit message. Starting deployment process...
```

```bash
./entrypoint.sh something
```

```bash
#prints: No further tasks required. Exiting gracefully...
```