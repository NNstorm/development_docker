# development_docker
Deep learning development tools using Docker

[![Build Status](https://dev.azure.com/ModellingMind/ModellingMind/_apis/build/status/Docker%20build%20and%20publish?branchName=master)](https://dev.azure.com/ModellingMind/ModellingMind/_build/latest?definitionId=4&branchName=master)


# Instructions

* Get docker (at least 19.03)
* Get nvidia-container-toolkit: https://github.com/NVIDIA/nvidia-docker


Add these lines to your .bashrc or .zshrc:
```bash
export GID=$(id -g)
export USER=$(id -u -n)
export HOST_GROUP=$(id -g -n)
export UID=${UID}
```