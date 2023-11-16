#!/bin/bash
set -e

cuda=$1

conda update conda
conda install -y conda-libmamba-solver
conda config --set solver libmamba
conda config --set channel_priority strict
conda config --remove channels conda-forge || echo "done"
conda config --add channels conda-forge

if [ "$cuda" == "11.8.0" ]; then
    conda install --solver=libmamba --strict-channel-priority --satisfied-skip-solve -y -c pytorch-nightly -c nvidia -c conda-forge python=3.11 pytorch pytorch-cuda=11.8 cuda-version=11.8 --file /tmp/requirements.txt
    # pip install cudf-cu11 dask-cudf-cu11 cuml-cu11 cugraph-cu11 cuspatial-cu11 cucim --index-url=https://pypi.nvidia.com
fi
if [ "$cuda" == "12.1.1" ]; then
    conda install --solver=libmamba --strict-channel-priority --satisfied-skip-solve -y -c pytorch-nightly -c nvidia -c conda-forge python=3.11 pytorch pytorch-cuda=12.1 cuda-version=12.1 --file /tmp/requirements.txt
    # pip install cudf-cu12 dask-cudf-cu12 cuml-cu12 cugraph-cu12 cuspatial-cu12 cucim --extra-index-url=https://pypi.nvidia.com
fi

conda clean -ya
