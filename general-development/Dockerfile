ARG from
FROM $from

# Install make and compilers
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    autoconf automake bison build-essential byacc bzip2 ca-certificates ccache clang cmake cowsay curl dnsutils \
    emacs flake8 flex gcc gdb gdbserver git git-lfs htop inetutils-ping iproute2 less libcanberra-gtk-module \
    libfontconfig1 libfreetype6-dev libgtk2.0-0 libjpeg-dev libpng-dev libprotoc-dev libx11-6 libxext-dev \
    libxrender-dev libxtst-dev lldb llvm mesa-utils nano net-tools openssh-client openssh-server protobuf-compiler \
    rsync sl software-properties-common sudo tcpdump telnet \
    tmux traceroute tree valgrind vim wget xauth zsh && \
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
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Microsoft Azure CLI
RUN cd /tmp && wget https://aka.ms/InstallAzureCLIDeb && bash ./InstallAzureCLIDeb && rm ./InstallAzureCLIDeb &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*