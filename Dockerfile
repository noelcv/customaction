# define base image
FROM ubuntu:latest
#  run commands to set up the environment and install dependencies
RUN apt-get update && apt-get install -y python3 python3-pip jq
# copy the entrypoint script into the WORKDIR
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# make it executable
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY sample_push_event.json /sample_push_event.json
COPY deploy.py /deploy.py
COPY exit.py /exit.py
# set the arguments of the entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]