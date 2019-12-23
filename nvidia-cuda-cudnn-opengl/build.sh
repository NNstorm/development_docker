#!/usr/bin/env bash

set -e

. ./../config.sh

docker pull ${base_image}

git clone -b ${ubuntu_name} https://gitlab.com/nvidia/container-images/opengl.git

docker build --build-arg from=${base_image} -t cudagl_base ./opengl/base
docker build --build-arg from=cudagl_base -t cudagl_runtime ./opengl/glvnd/runtime
docker build --build-arg from=cudagl_runtime -t ${repo_name}:latest ./opengl/glvnd/devel

# clean up:
rm -rf opengl
docker rmi cudagl_base cudagl_runtime

docker tag ${repo_name}:latest ${repo_name}:${tag}

docker push ${repo_name}
docker push ${repo_name}:${tag}

