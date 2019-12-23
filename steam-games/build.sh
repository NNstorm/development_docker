#!/usr/bin/env bash

set -e

source ./../config.sh

docker build -t modellingmind/cuda-steam-gaming --build-arg from=${repo_name}-userlayer:latest .

docker push modellingmind/cuda-steam-gaming