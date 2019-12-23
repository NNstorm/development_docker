ARG from
FROM $from

RUN apt update && apt install sudo mesa-utils -y && apt clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh