#!/bin/bash
set -e

OS_VERSION="ubuntu22.04"
CUDA_VERSION="12.1.1"
BASE="nvidia/cuda:${CUDA_VERSION}-cudnn8-devel-${OS_VERSION}"
TAG="xmindai/cuda-python:${OS_VERSION}-${CUDA_VERSION}-cudnn8"

cd general-development
./build.sh $BASE $BASE-dev
cd ..

cd cuda-python-development
./build.sh $BASE-dev $BASE-dev-py ${CUDA_VERSION}
cd ..

cd user-layer
./build.sh $BASE-dev-py $BASE-dev-py-user
cd ..

cd nvidia-cuda-cudnn-opengl
./build.sh $BASE-dev-py-user $TAG ${OS_VERSION}
cd ..

docker push $TAG
