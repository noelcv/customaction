# Custom Action



'chmod +x entrypoint.sh' to make it executable

## testing the entrypoint script

```bash
./entrypoint.sh deploy
```

```bash
//prints: DEPLOY keyword found in commit message. Starting deployment process...
```

```bash
./entrypoint.sh something
```

```bash
//prints: No further tasks required. Exiting gracefully...
```