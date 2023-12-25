# Development Docker images

Deep learning development tools using Docker

[![Build Status](https://dev.azure.com/XMindAI/OpenXMind/_apis/build/status/xmind.ai%20-%20Docker%20Development?branchName=master)](https://dev.azure.com/XMindAI/OpenXMind/_build/latest?definitionId=6&branchName=master)

## Instructions

* Get docker (at least 19.03)
* Get nvidia-container-toolkit: https://github.com/NVIDIA/nvidia-docker


Add these lines to your .bashrc or .zshrc, this enables using docker with own user:

```bash
export GID=$(id -g)
export USER=$(id -u -n)
export HOST_GROUP=$(id -g -n)
export HOST_UID=$(id -u)
```

Set Nvidia as default container runtime for Docker in `/etc/docker/daemon.json`, it is needed to run docker-compose:

```
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```

## GUI, IDE Usage in container

To make development portable and deployable on cloud, it is recommended to run the IDE inside the container. Legacy solution installed the IDE inside the container which resulted in large container sizes (moving around useless packages). Best practice is to mount your IDE inside the container (to be specified in the docker-compose file or docker run) and start them from the container. GUI access is granted on Intel, AMD and NVIDIA GPUs by default. This enables portable code and easier cooperation of teams.

## Available Docker images

Supported CUDA versions: `11.8.0` and `12.1.1` in all images, `latest` tag is not used as a best practice implementation.

### `xmindai/cuda-cudnn-opengl`

> [DockerHUB link](https://hub.docker.com/repository/docker/xmindai/cuda-cudnn-opengl)

Content:

* CUDA-dev
* CUDNN-dev
* CUDA OpenGL-dev

### `xmindai/cuda-cpp`

> [DockerHUB link](https://hub.docker.com/repository/docker/xmindai/cuda-cpp)

Built on `xmindai/cuda-cudnn-opengl`

* User layer - support for arbitrary user to log in
* Development layer from folder `general-development`, supporting complete, graphical dev life-cycle in a single container

### `xmindai/cuda-python`

> [DockerHUB link](https://hub.docker.com/repository/docker/xmindai/cuda-python)

Built on `xmindai/cuda-cpp`

Adds CUDA Python libs with `pyenv`:

* PyTorch - GPU 
* Tensorflow - GPU
* CUDA RAPIDS
* Many more defined in `cuda-python-development/requirements.txt`

## Start container examples

Start interactive session:

```bash
docker-compose -f xmind-development/docker-compose.yml run dev
```

Start ssh service (background):

```bash
docker-compose -f xmind-development/docker-compose.yml up -d ssh
```

Kill ssh service:

```bash
docker-compose -f xmind-development/docker-compose.yml down ssh
```
