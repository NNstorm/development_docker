ci_dir=$(pwd)
repo_dir="${ci_dir}/.."

base_image=$1
target_image=$2
cuda_version=$3

if [[ -z "${base_image}" ]]; then
    base_image=" xmindai/cuda-cudnn-opengl:ubuntu18.04-10.0-cudnn7"  # xmindai/cuda-cudnn-opengl:ubuntu18.04-10.0-cudnn7
fi

if [[ -z "${target_image}" ]]; then
    target_image="xmindai/cuda-cpp:ubuntu18.04-10.0-cudnn7"
fi

if [[ -z "${cuda_version}" ]]; then
    echo "No cuda version given" 1>&2
    exit 1
fi

set -e

cd "${repo_dir}/general-development"
./build.sh ${base_image} temp-dev-img

cd "${repo_dir}/user-layer"
./build.sh temp-dev-img temp-dev-user-img

cd "${repo_dir}/cuda-cpp-development"
./build.sh temp-dev-user-img ${target_image} ${cuda_version}

# cleanup
docker rmi temp-dev-img temp-dev-user-img
