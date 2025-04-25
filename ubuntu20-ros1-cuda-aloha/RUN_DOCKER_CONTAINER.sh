#!/bin/bash

# - Author: Tomohiro MOTODA <tomohiro.motoda@aist.go.jp>
# - date: 20254-04-23
# ""Aloha Docker Container Runner""
# This script runs the Docker container for Aloha with ROS1.
# It sets up the necessary environment variables and mounts the X11 socket for GUI applications.
# Ensure that the X11 server is running on the host machine and that it allows connections from the Docker container.
# Usage: ./RUN_DOCKER_CONTAINER.sh

OFF='\033[0m'
RED='\033[0;31m'
GRN='\033[0;32m'
BLU='\033[0;34m'
# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Check if the X11 server is running
if ! pgrep -x "Xorg" > /dev/null; then
    echo "X11 server is not running. Please start it and try again."
    exit 1
fi
# Check if the DISPLAY variable is set
if [ -z "$DISPLAY" ]; then
    echo "DISPLAY variable is not set. Please set it and try again."
    exit 1
fi
# Check if the Docker image exists
if ! docker images | grep -q "aloha-cuda-ros1"; then
    echo "Docker image 'aloha-cuda-ros1' not found. Please build the image first."
    exit 1
fi

echo -e "${BLU}Running Docker container for Aloha with ROS1...${OFF}"
echo -e "${GRN}Please ensure that the X11 server is running and that you have the necessary permissions to access it.${OFF}"
echo -e "${RED}If you encounter any issues, please check the Docker documentation for troubleshooting tips.${OFF}"
echo -e "${GRN}Starting the Docker container...${OFF}"

echo -e "${BLU}Aloha is a ROS1-based software for autonomous driving research and development.${OFF}"
echo -e "${GRN}For more information, please visit the Aloha GitHub repository: https://www.trossenrobotics.com/${OFF}"


# Run the Docker container with the necessary environment variables and volume mounts
# The --rm flag automatically removes the container when it exits
# The --env flag sets environment variables inside the container
# The --volume flag mounts the X11 socket from the host to the container
# The --name flag gives the container a name for easier reference
# The bash command starts a shell session inside the container
# The -it flag allows for interactive terminal access
# The --rm flag automatically removes the container when it exits
# The --runtime=nvidia flag enables GPU support for the container
# The --gpus all flag allows the container to use all available GPUs
# Run the Docker container with the specified options

xhost +local:
docker run -it --rm \
    --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/dev:/dev" \
    --name=aloha-cuda-ros1 \
    --privileged \
    aloha-cuda-ros1:latest \
    bash

