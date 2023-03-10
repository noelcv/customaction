#!/bin/bash
set -e

# if a GITHUB_EVENT_PATH is present (running on GitHub) use it as EVENT PATH wer're running it on workflow resources
if [ -n "$GITHUB_EVENT_PATH" ]; 
then
  EVENT_PATH=$GITHUB_EVENT_PATH
# otherwise use a local sample file to test locally
elif [ -f './sample_push_event.json' ];
then
  EVENT_PATH='./sample_push_event.json'
  LOCAL_TEST=true
# otherwise exit with stderr  
else
  echo "No JSON data to process. Exiting..."
  exit 1 
fi  

# debugging: env command will print the contents of the environment variables set by the OS
# debugging: jq command will print the contents of the EVENT PATH environment variable
env 
jq . < $EVENT_PATH
# extract the commit message from the EVENT PATH and grep the output for the keyword
# "$*" is a placeholder for the keyword passed to the script as an argument - make it reusable
if jq '.commits[].message, .head_commit.message' < $EVENT_PATH | grep -i -q "$*"; 
then
  # do something: start deployment process
  pwd
  python3 deploy.py
  echo "Keyword found. Deploying..."

else
  # do nothing and exit gracefully
  python3 exit.py
  echo "Keyword not found. Exiting..."
fi