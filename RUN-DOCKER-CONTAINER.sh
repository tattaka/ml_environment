#!/bin/bash

################################################################################

# Set the Docker container name from a project name (first argument).
# If no argument is given, use the current user name as the project name.
FRAMEWORK=$1

PROJECT=${USER}

if [ -z "${FRAMEWORK}" ]; then
    FRAMEWORK="base"
fi
CONTAINER="${PROJECT}_${FRAMEWORK}_1"
echo "$0: PROJECT=${PROJECT}"
echo "$0: CONTAINER=${CONTAINER}"

# Run the Docker container in the background.
# Any changes made to './docker/docker-compose.yml' will recreate and overwrite the container.

docker-compose -p ${PROJECT} -f ./docker/docker-compose.yml up -d ${FRAMEWORK}
################################################################################

# Display GUI through X Server by granting full access to any external client.
# xhost +

################################################################################

# Enter the Docker container with a Bash shell.
docker exec -i -t ${CONTAINER} bash

