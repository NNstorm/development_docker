#!/bin/bash
set -e

cuda=$1

conda update conda
conda install -y conda-libmamba-solver
conda config --set solver libmamba
conda config --set channel_priority strict
conda config --remove channels conda-forge || echo "done"
conda config --add channels conda-forge

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
    conda install --solver=libmamba --strict-channel-priority --satisfied-skip-solve -y -c pytorch-nightly -c nvidia -c conda-forge python=3.11 pytorch pytorch-cuda=11.8 cuda-version=11.8 --file /tmp/requirements.txt
    # pip install cudf-cu11 dask-cudf-cu11 cuml-cu11 cugraph-cu11 cuspatial-cu11 cucim --index-url=https://pypi.nvidia.com
fi
if [ "$cuda" == "12.1.1" ]; then
    conda install --solver=libmamba --strict-channel-priority --satisfied-skip-solve -y -c pytorch-nightly -c nvidia -c conda-forge python=3.11 pytorch pytorch-cuda=12.1 cuda-version=12.1 --file /tmp/requirements.txt
    # pip install cudf-cu12 dask-cudf-cu12 cuml-cu12 cugraph-cu12 cuspatial-cu12 cucim --extra-index-url=https://pypi.nvidia.com
fi

conda clean -ya
