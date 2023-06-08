#!/bin/bash
set -e

cuda=$1

conda update conda
conda install -y conda-libmamba-solver
conda config --set solver libmamba

if [ "$cuda" == "10.0" ]; then
    conda install -y -c rapidsai -c nvidia -c conda-forge -c defaults -c pytorch -c anaconda python=3.7 cudatoolkit=10.0 pytorch --file /tmp/requirements.txt
fi
if [ "$cuda" == "10.1" ]; then
    conda install -y -c rapidsai -c nvidia -c conda-forge -c defaults -c pytorch -c anaconda python=3.7 cudatoolkit=10.1 pytorch --file /tmp/requirements.txt
fi
if [ "$cuda" == "10.2" ]; then
    conda install -y -c rapidsai -c nvidia -c conda-forge -c defaults -c pytorch-nightly -c anaconda python=3.7 cudatoolkit=10.2 pytorch=1.6 --file /tmp/requirements.txt
fi
if [ "$cuda" == "11.5.1" ]; then
    conda install -y -c rapidsai -c nvidia -c conda-forge -c defaults -c pytorch-nightly -c anaconda python=3.9 cudatoolkit=11.5 pytorch=1.11 --file /tmp/requirements.txt
fi
if [ "$cuda" == "11.8.0" ]; then
    conda install -y -c nvidia -c conda-forge -c pytorch-nightly -c anaconda python=3.10 pytorch pytorch-cuda=11.8 --file /tmp/requirements.txt
    # conda install -y -c rapidsai -c conda-forge -c nvidia rapids=23.04 python=3.10
fi
if [ "$cuda" == "12.1.1" ]; then
    conda install -y -c rapidsai -c nvidia -c conda-forge -c pytorch-nightly -c anaconda python=3.10 pytorch pytorch-cuda=12.1 --file /tmp/requirements.txt
fi

conda clean -ya
