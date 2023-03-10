# define base image
FROM ubuntu:latest
#  run commands to set up the environment and install dependencies
RUN apt-get update && apt-get install -y python3 python3-pip
# copy the entrypoint script into the WORKDIR
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# set the arguments of the entrypoint
ENTRYPOINT [ "entrypoint.sh" ]