#!/bin/bash
set -e

OS_VERSION="ubuntu22.04"
CUDA_VERSION="12.4.1"
PYTHON_VERSION="3.13.4"
BASE="nvidia/cuda:${CUDA_VERSION}-cudnn-devel-${OS_VERSION}"
TAG="xmindai/cuda-python:${OS_VERSION}-${CUDA_VERSION}-cudnn-py${PYTHON_VERSION}"

cd general-development
./build.sh $BASE $BASE-dev
cd ..

cd cuda-python-development
./build.sh $BASE-dev $BASE-dev-py ${CUDA_VERSION} ${PYTHON_VERSION}
cd ..

cd user-layer
./build.sh $BASE-dev-py $BASE-dev-py-user
cd ..

cd nvidia-cuda-cudnn-opengl
./build.sh $BASE-dev-py-user $TAG ${OS_VERSION}
cd ..

docker push $TAG

# install:
# sudo curl -sL https://github.com/shinsenter/docker-squash/raw/main/docker-squash.sh -o /usr/local/bin/docker-squash.sh
# sudo chmod +x /usr/local/bin/docker-squash.sh
docker-squash.sh $TAG -t $TAG-mini --build-arg PRESQUASH_SCRIPTS='rm -rf /tmp/* /usr/share/doc/* /opt/nvidia'
