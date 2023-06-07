#!/usr/bin/env bash

base_image=$1
target_image=$2
ubuntu_version=$3

if [[ -z "${base_image}" ]]; then
    echo "No base image given" 1>&2
    exit 1
fi

if [[ -z "${target_image}" ]]; then
    echo "No target image given" 1>&2
    exit 1
fi

if [[ -z "${ubuntu_version}" ]]; then
    echo "No ubuntu version given using: ubuntu22.04" 1>&2
    ubuntu_version="ubuntu22.04"
fi

set -e
rm -rf opengl
git clone -b ${ubuntu_version} https://gitlab.com/nvidia/container-images/opengl.git

docker build --build-arg from=${base_image} -t cudagl_base -f ./opengl/base/Dockerfile ./opengl
docker build --build-arg from=cudagl_base -t cudagl_runtime ./opengl/glvnd/runtime
docker build --build-arg from=cudagl_runtime -t ${target_image} ./opengl/glvnd/devel

# clean up:
rm -rf opengl
docker rmi cudagl_base cudagl_runtime
