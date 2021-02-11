# hadolint disable=DL3007
FROM nextcloud:latest

RUN apt-get update && \
    apt-get -y --no-install-recommends install smbclient && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g 1000 share && \
    usermod -a -G share root
