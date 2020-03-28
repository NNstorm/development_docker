#!/bin/bash
set -e

cuda=$1

if [ "$cuda" == "10.0" ]
then
    conda install -y -c rapidsai-nightly -c nvidia -c conda-forge -c defaults -c pytorch -c anaconda python=3.7 cudatoolkit=10.0 --file /tmp/requirements.txt
fi
if  [ "$cuda" == "10.1" ]
then
    conda install -y -c rapidsai-nightly -c nvidia -c conda-forge -c defaults -c pytorch -c anaconda python=3.7 cudatoolkit=10.1 --file /tmp/requirements.txt
fi
if [ "$cuda" == "10.2" ]
then
    conda install -y -c rapidsai-nightly -c nvidia -c conda-forge -c defaults -c pytorch -c anaconda python=3.7 cudatoolkit=10.2 --file /tmp/requirements.txt
fi

conda clean -ya