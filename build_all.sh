#!/usr/bin/env bash
set -e

cd nvidia-cuda-cudnn-opengl
./build.sh
cd ..

cd user-layer
./build.sh
cd ..

cd steam-games
./build.sh
cd ..