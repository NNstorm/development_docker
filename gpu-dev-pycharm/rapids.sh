#!/bin/bash
set -e

common="conda install -y -c rapidsai-nightly -c nvidia -c conda-forge -c defaults -c pytorch -c anaconda python=3.7 --file /tmp/requirements.txt"

if [[ -d "/usr/local/cuda-10.0" ]]
then
    ${common}
    #conda install pytorch -c pytorch cudatoolkit=10.1 --override-channels && conda clean -ya
fi
if [[ -d "/usr/local/cuda-10.1" ]]
then
    ${common} # cudatoolkit=10.1
fi
if [[ -d "/usr/local/cuda-10.2" ]]
then
    ${common} # cudatoolkit=10.2
fi

conda clean -ya