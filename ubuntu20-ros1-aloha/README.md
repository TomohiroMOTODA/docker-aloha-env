# Dockerfile for install aloha (w/o GPUs) 

## Overview

This repository contains a Dockerfile to build a simple container with ROS1 on Ubuntu20.04. 

## Prerequisites

- Docker installed on your system.
- Access to an NVIDIA GPU with the NVIDIA Container Toolkit installed.

> [!Note]
> SSH key configured for accessing private repositories!


> [!Note]
> You need choose the proper base images: 
> Default: nvidia/cuda:12.8.1-cudnn-devel-ubuntu20.04

## Usage

### Build the Docker Image

Run the following command to build the Docker image:

```bash
docker build -t aloha-ros1 .
```

### Run the Docker Container

To start a container from the built image, use:

```bash
bash RUN_DOCKER_CONTAINER.sh
```

If you use the own options: 
```bash
docker run --gpus all -it --rm aloha-ros1 ~....
```

This command enables GPU access and starts an interactive session in the container.

## Notes

- Ensure your system has the necessary NVIDIA drivers installed.
- Modify the Dockerfile as needed to customize the environment for your specific use case.
- For more information about AIST ALOHA, refer to the [official documentation](https://www.aist.go.jp/index_en.html).


## References

* <https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html>
* <https://gitlab.com/nvidia/container-images/cuda>
* <https://hub.docker.com/r/nvidia/cuda/tags?name=ubuntu20.04>
* <https://zenn.dev/kyoizmy/articles/333ffb5102e2cf>
* <https://qiita.com/enmaru/items/00b7a747fc682524cf2f>
* <https://qiita.com/takeru0208/items/3b4e24c291432a37ceda>
* <https://zenn.dev/3w36zj6/scraps/5a157d90398306>