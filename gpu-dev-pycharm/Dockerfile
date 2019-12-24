ARG from
FROM $from

ARG PYCHARM=2019.3.1

# Install make and compilers and extra stuff
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    build-essential autoconf automake \
    sudo vim nano git curl wget tree \
    krb5-user krb5-locales libpam-krb5 \
    python-numpy python-scipy python-opencv \
    python python-dev python-setuptools python-pip \
    python3 python3-dev python3-setuptools python3-pip \
    flake8 pydocstyle python3-pydocstyle \
    gcc git openssh-client libfontconfig1 \
    vim emacs python tcpdump telnet byacc flex \
    iproute2 gdbserver less bison valgrind \
    libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
    openssh-server cmake gdb build-essential clang llvm lldb ccache \
    zsh sl cowsay git-lfs rsync \
    inetutils-ping traceroute openssh-server openssh-client \
    curl ca-certificates \
    bzip2 libjpeg-dev libpng-dev \
    cmake build-essential libx11-6 libgtk2.0-0 \
    libcanberra-gtk-module protobuf-compiler libprotoc-dev && \
    update-ccache-symlinks && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.conf
RUN sysctl -p --system

# install PyCharm
WORKDIR /opt
ENV PYCHARM_VERSION=${PYCHARM}
RUN wget --no-check-certificate  https://download.jetbrains.com/python/pycharm-professional-${PYCHARM}.tar.gz && \
    tar xvzf pycharm-professional-${PYCHARM}.tar.gz && \
    rm pycharm-professional-${PYCHARM}.tar.gz && \
    mv pycharm* pycharm && \
    echo "/opt/pycharm/bin/pycharm.sh 2> /var/log/pycharm &" > /usr/bin/pycharm && \
    chmod +x /usr/bin/pycharm && (umask 000; touch /var/log/pycharm)

RUN sed -i -r "s#ENV_PATH(.*)PATH=(.*)#ENV_PATH\1PATH=$PATH#" /etc/login.defs

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda clean -ya

ENV PATH /opt/conda/bin:$PATH
RUN conda update conda && conda install pip
ENV CONDA_AUTO_UPDATE_CONDA=true
RUN conda install -y numpy pyyaml mkl mkl-include requests setuptools cmake cffi typing pip h5py \
    graphviz opencv cython && conda clean -ya

RUN /opt/conda/bin/pip install --upgrade pip


ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
RUN conda install pytorch cython -c pytorch && conda clean -ya

RUN pip install h5py-cache tqdm shapely tensorboard tensorboardX graphviz cython matplotlib onnx folium dash pandas plotly \
    slackclient

# Microsoft Azure CLI
RUN cd /tmp && wget https://aka.ms/InstallAzureCLIDeb && bash ./InstallAzureCLIDeb && rm ./InstallAzureCLIDeb

# General Workspace
RUN mkdir -p /workspace
WORKDIR /workspace

# Set up ssh server for VS code development in Azure/AWS cloud
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 20022