#!/bin/bash
set -eu
usage_exit() {
  prog="./$(basename $0)"
  echo_err "usage: $prog [OPTIONS...] ARGS..."
  echo_err ""
  echo_err "options:"
  echo_err " -r, --refresh_container: Delete the existing container if there is it"
  echo_err " -u, --update_image: Update the docker image if there is the update"
  echo_err " -n: Set the name of the container"
  echo_err " -h, --help"
  exit 1
}
echo_err() {
  echo "$1" 1>&2
}
################################################################################

# Set the Docker container name from a project name (first argument).
# If no argument is given, use the current user name as the project name.
CONTAINER="${USER}_pytorch_gpu_1"
IMAGE_REPO="pytorch/pytorch"
TAG="1.9.1-cuda11.1-cudnn8-devel"
REFRESH_FLAG="FALSE"
UPDATE_FLAG="FALSE"
while getopts -- "-:run:h" OPT; do
    case $OPT in
        -)
            case $OPTARG in
                refresh_container) REFRESH_FLAG="TRUE";;
                update_image) UPDATE_FLAG="TRUE";;
                help) usage_exit;;
            esac;;
        r) REFRESH_FLAG="TRUE";;
        u) UPDATE_FLAG="TRUE";;
        n) CONTAINER=$OPTARG;;
        h) usage_exit;;
    esac
done
echo "$0: CONTAINER=${CONTAINER}"
echo "$0: IMAGE=${IMAGE_REPO}:${TAG}"
if [ "$REFRESH_FLAG" = "TRUE" ]; then
    EXISTING_CONTAINER_ID=`docker ps -aq -f name=${CONTAINER}`
    if [ ! -z "${EXISTING_CONTAINER_ID}" ]; then
        echo "Stop the container ${CONTAINER} with ID: ${EXISTING_CONTAINER_ID}."
        docker stop ${EXISTING_CONTAINER_ID}
        echo "Remove the container ${CONTAINER} with ID: ${EXISTING_CONTAINER_ID}."
        docker rm ${EXISTING_CONTAINER_ID}
    fi
fi

if [ "$UPDATE_FLAG" = "TRUE" ]; then
    docker pull $IMAGE_REPO:$TAG
fi
DOCKER_FOUND_NAME=`docker ps -f "Name=${CONTAINER}" --format "{{.Names}}"`

if [ -z $DOCKER_FOUND_NAME ]; then
    DOCKER_FOUND_NAME="_"
fi
if [ $DOCKER_FOUND_NAME != $CONTAINER ]; then
    echo "Create new container !"
    docker run -itd \
        --gpus=all \
        --privileged \
        --env NVIDIA_VISIBLE_DEVICES=all \
        --env NVIDIA_DRIVER_CAPABILITIES=all \
        --volume ${PWD}/projects:/home/jupyter/projects/ \
        --network=host \
        --ipc=host \
        --name ${CONTAINER} \
        "${IMAGE_REPO}:${TAG}"
    docker exec -it ${CONTAINER} bash
else
# Enter the Docker container with a Bash shell.
    echo "Use ${CONTAINER} !"
    docker exec -it ${CONTAINER} bash
fi
