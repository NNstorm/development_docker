ARG from
FROM $from

# Install make and compilers
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    autoconf automake bison build-essential byacc bzip2 ca-certificates ccache clang cmake cowsay curl dnsutils \
    emacs flake8 flex gcc gdb gdbserver git git-lfs htop inetutils-ping iproute2 less libcanberra-gtk-module \
    libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev \
    libfontconfig1 libfreetype6-dev libgtk2.0-0 libjpeg-dev libpng-dev libprotoc-dev libsnappy-dev libx11-6 libxext-dev \
    libxrender-dev libxtst-dev lldb llvm mc mesa-utils nano netcat net-tools nvtop nmon openssh-client openssh-server pigz protobuf-compiler \
    rsync sl software-properties-common sudo tcpdump telnet x11vnc xvfb \
    tmux traceroute tree valgrind vim wget xauth zlib1g-dev zsh && \
    add-apt-repository ppa:git-core/ppa -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.conf
RUN sysctl -p --system

# Set up ssh server for VS code development in Azure/AWS cloud
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 20022

# Microsoft Azure CLI
RUN cd /tmp && wget https://aka.ms/InstallAzureCLIDeb && bash ./InstallAzureCLIDeb && rm ./InstallAzureCLIDeb &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&\
    chmod +x kubectl &&\
    sudo mv kubectl /usr/local/bin

# Microsoft Azure azcopy
RUN wget https://aka.ms/downloadazcopy-v10-linux && \
    tar xvzf downloadazcopy-v10-linux && \
    sudo mv azcopy*/azcopy /usr/local/bin/ && \
    chmod +x /usr/local/bin/azcopy && \
    rm -rf azcopy* && \
    rm -rf downloadazcopy-v10-linux
