#!/bin/bash
set -e

# if keyword is found
if echo "$*" | grep -i -q "DEPLOY";
then
  # do something: start deployment process
  echo "DEPLOY keyword found in commit message. Start deployment process"

else
  # do nothing and exit gracefully
  echo "No further tasks required. Exiting gracefully..."
fi