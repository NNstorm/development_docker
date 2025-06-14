#!/usr/bin/env bash

base_image=$1
target_image=$2
cuda_version=$3
python_version=$4

if [[ -z "${base_image}" ]]; then
    echo "No base image given" 1>&2
    exit 1
fi

if [[ -z "${target_image}" ]]; then
    echo "No target image given" 1>&2
    exit 1
fi

if [[ -z "${cuda_version}" ]]; then
    echo "No cuda version given" 1>&2
    exit 1
fi

if [[ -z "${python_version}" ]]; then
    echo "No python version given" 1>&2
    exit 1
fi

set -e

docker build -t ${target_image} --build-arg from=${base_image}  --build-arg cuda=${cuda_version}  --build-arg python_version=${python_version} .
