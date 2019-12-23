#!/usr/bin/env bash

ubuntu_version="18.04"
cuda_version="10.0"
cudnn_version="7"

ubuntu_name="ubuntu${ubuntu_version}"
base_image="nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel-${ubuntu_name}"


repo_name="modellingmind/cuda-cudnn-opengl"
development_repo_name="modellingmind/cuda-dev-gui"


tag="${ubuntu_name}-${cuda_version}-${cudnn_version}"
