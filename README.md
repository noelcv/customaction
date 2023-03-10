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

In the second part of the script, we look into the event payload, and check if the commit message contains the keyword "DEPLOY" passed as an argument to determine whether to trigger the deployment process.

## Makefile

The purpose of the Makefile is create different build targets, so that we don't have to run them each time while testing locally. As an example, instead of running:

```bash
docker run --rm keyword-release-action $(KEYWORD)

docker build --tag keyword-release-action .

./entrypoint.sh $(KEYWORD)
```

We can simply define equivalent targets in the Makefile, and then run only `make` and have all the specified targets running in sequence.

## Metadata

`Action.yml` contains the metadata for the custom data and needs to specify:

- name
- description
- author
- commands

Optionally, it can also include information on:

- inputs / output
- branding elements (should you want to publish your Custom GitHub Action on the Marketplace)


## Example

If a commit message contains deploy, the workflow will detect it and execute the `deploy.py` script.

```bash
git commit -m "TICKET-FOO-2023: fix center div - ready to deploy"
```

```md
Keyword found. Deploying...
Starting deployment process..."
```

Otherwise, the workflow would check that the keyword deploy is not present and execute the `exit.py` script.

```bash
git commit -m "TICKET-FOO-2023: update README file"
```

```md
Keyword not found. Exiting...
No further tasks required. Exiting gracefully...
```

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