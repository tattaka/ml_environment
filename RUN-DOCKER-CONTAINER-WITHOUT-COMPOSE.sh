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
IMAGE_REPO="tattaka/ml_environment"
HOSTNAME=${FRAMEWORK}
echo "$0: CONTAINER=${CONTAINER}"
echo "$0: IMAGE=${IMAGE_REPO}:${FRAMEWORK}"
DOCKER_FOUND_NAME=`docker ps -f "Name=${CONTAINER}" --format "{{.Names}}"`

if [ -z $DOCKER_FOUND_NAME ]; then
    DOCKER_FOUND_NAME="_"
fi
echo "$0: DOCKER_FOUND_NAME=${DOCKER_FOUND_NAME}"

if [ $DOCKER_FOUND_NAME != $CONTAINER ]; then
    echo "Create new container !"
    docker run -itd \
        --runtime=nvidia \
        --privileged \
        --env DISPLAY=${DISPLAY} \
        --env QT_X11_NO_MITSHM=1 \
        --env NVIDIA_VISIBLE_DEVICES=all \
        --env NVIDIA_DRIVER_CAPABILITIES=all \
        --env PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
        --volume ${PWD}:/root/ml_environment/ \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --volume ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse\/native \
        --network=host \
        --name ${CONTAINER} \
        "${IMAGE_REPO}:${FRAMEWORK}" 
    docker exec -it ${CONTAINER} bash
else
# Enter the Docker container with a Bash shell.
    echo "Use ${CONTAINER} !"
    docker exec -it ${CONTAINER} bash
fi