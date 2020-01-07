ARG from
FROM $from

ARG PYCHARM=2019.3.1

# Install make and compilers
RUN apt update && \
    apt install -y \
    autoconf automake bison build-essential byacc bzip2 ca-certificates ccache clang cmake cowsay curl dnsutils \
    emacs flake8 flex gcc gdb gdbserver git git-lfs htop inetutils-ping iproute2 less libcanberra-gtk-module \
    libfontconfig1 libfreetype6-dev libgtk2.0-0 libjpeg-dev libpng-dev libprotoc-dev libx11-6 libxext-dev \
    libxrender-dev libxtst-dev lldb llvm nano net-tools openssh-client openssh-server protobuf-compiler \
    pydocstyle python python-dev python-numpy python-opencv python-pip python-scipy python-setuptools \
    python3 python3-dev python3-pip python3-pydocstyle python3-setuptools rsync sl sudo tcpdump telnet \
    tmux traceroute tree valgrind vim wget xauth zsh  && \
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
    rm pycharm-professional-${PYCHARM}.tar.gz && mv pycharm* pycharm && \
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
    graphviz opencv cython jupyterlab notebook && conda clean -ya

RUN /opt/conda/bin/pip install --upgrade pip
RUN conda install pytorch -c pytorch && conda clean -ya

COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade -r /tmp/requirements.txt && rm /tmp/requirements.txt

# Microsoft Azure CLI
RUN cd /tmp && wget https://aka.ms/InstallAzureCLIDeb && bash ./InstallAzureCLIDeb && rm ./InstallAzureCLIDeb

# Set up ssh server for VS code development in Azure/AWS cloud
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 20022

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
