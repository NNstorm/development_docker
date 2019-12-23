ARG from
FROM $from

RUN dpkg --add-architecture i386 && apt update && apt install sudo mesa-utils \
    wget gdebi-core libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 pciutils steam:i386 libnvidia-gl-418:i386 -y && \
    apt clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh