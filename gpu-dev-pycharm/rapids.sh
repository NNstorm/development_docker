#!/bin/bash

if [[ -d "/usr/local/cuda-10.0" ]]
then
    conda install -c rapidsai-nightly -c nvidia -c conda-forge -c defaults rapids=0.13 python=3.7
fi
if [[ -d "/usr/local/cuda-10.1" ]]
then
    conda install -c rapidsai-nightly -c nvidia -c conda-forge -c defaults rapids=0.13 python=3.7 cudatoolkit=10.1
fi
if [[ -d "/usr/local/cuda-10.2" ]]
then
    conda install -c rapidsai-nightly -c nvidia -c conda-forge -c defaults rapids=0.13 python=3.7 cudatoolkit=10.2
fi
