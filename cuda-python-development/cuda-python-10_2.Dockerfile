ARG from=xmindai/cuda-cpp:ubuntu18.04-10.2-cudnn7
FROM $from as conda

ARG cuda=10.2

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -ya

ENV PATH /opt/conda/bin:$PATH
RUN conda update conda && conda install -y pip && conda clean -ya
ENV CONDA_AUTO_UPDATE_CONDA=false

# Install required conda packages
COPY requirements.txt /tmp/requirements.txt
COPY conda_packages_installer.sh /tmp/conda_packages_installer.sh
RUN /tmp/conda_packages_installer.sh $cuda \
    && rm /tmp/conda_packages_installer.sh
