#!/bin/bash
set -e

cuda=$1

if [ "$cuda" == "10.0" ]
then
    tag="cuda10.0-trt7.0.0.11-ga-20191216"
fi
if  [ "$cuda" == "10.1" ]
then
    echo "CUDA 10.1 is not supported by TensorRT, so it is not installed in this container!!"
    exit 0
fi
if [ "$cuda" == "10.2" ]
then
    tag="cuda10.2-trt7.0.0.11-ga-20191216"
fi

cd /tmp
wget --no-check-certificate https://mindstore0.blob.core.windows.net/blob0/nv-tensorrt-repo-ubuntu1804-${tag}_1-1_amd64.deb
dpkg -i nv-tensorrt-repo-ubuntu1804-cuda10.0-trt7.0.0.11-ga-20191216_1-1_amd64.deb
apt-key add /var/nv-tensorrt-repo-${tag}/7fa2af80.pub

dpkg -i /var/nv-tensorrt-repo-${tag}/*.deb
dpkg --remove nv-tensorrt-repo-ubuntu1804-${tag}

apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -rf /var/nv-tensorrt*
