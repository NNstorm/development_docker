# development_docker
Deep learning development tools using Docker


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