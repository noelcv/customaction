# Custom Action

'chmod +x entrypoint.sh' to make it executable

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