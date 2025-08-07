#!/bin/bash
set -e

OS_VERSION="ubuntu24.04"
CUDA_VERSION="12.8.1"
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
./build.sh $BASE-dev-py $TAG
cd ..

docker push $TAG

# install:
# sudo curl -sL https://github.com/shinsenter/docker-squash/raw/main/docker-squash.sh -o /usr/local/bin/docker-squash.sh
# sudo chmod +x /usr/local/bin/docker-squash.sh
docker-squash.sh $TAG -t $TAG-mini --build-arg PRESQUASH_SCRIPTS='rm -rf /tmp/* /usr/share/doc/* /opt/nvidia'
docker push $TAG-mini
