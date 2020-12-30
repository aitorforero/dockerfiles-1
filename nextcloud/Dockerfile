FROM nextcloud

RUN apt-get update && \
    apt-get -y --no-install-recommends install smbclient && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*
