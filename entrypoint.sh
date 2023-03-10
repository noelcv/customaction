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