ci_dir=$(pwd)
repo_dir="${ci_dir}/.."

base_image=$1
target_image=$2
cuda_version=$3

if [[ -z "${base_image}" ]]; then
    base_image="xmindai/cuda-cpp:ubuntu18.04-10.1-cudnn7"
fi

if [[ -z "${cuda_version}" ]]; then
    cuda_version="10.1"
fi

if [[ -z "${target_image}" ]]; then
    target_image="xmindai/cuda-python:ubuntu18.04-${cuda_version}"
fi

set -e

cd "${repo_dir}/cuda-python-development"
./build.sh ${base_image} ${target_image} ${cuda_version}

