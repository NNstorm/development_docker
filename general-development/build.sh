#!/usr/bin/env bash

base_image=$1
target_image=$2

tag=$(sed 's/.*:\(.*\)-.*/\1/' <<< "$base_image")
distro=$(sed 's/\.//g' <<< "$tag")

if [[ -z "${base_image}" ]]; then
    echo "No base image given" 1>&2
    exit 1
fi

if [[ -z "${target_image}" ]]; then
    echo "No target image given" 1>&2
    exit 1
fi

set -e

docker build -t ${target_image} --build-arg from=${base_image} --build-arg distro=${distro} .
