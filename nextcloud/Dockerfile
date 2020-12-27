FROM nextcloud

RUN apt-get update && \
    apt-get -y --no-install-recommends install inotify-tools python unzip && \
    curl -o /tmp/master.zip https://codeload.github.com/Blaok/nextcloud-inotifyscan/zip/master && \
    unzip /tmp/master.zip -d /usr/local/src && \
    rm /tmp/master.zip && \
    /bin/chmod +x /usr/local/src/nextcloud-inotifyscan-master/nextcloud-inotifyscan && \
    ln -s /usr/local/src/nextcloud-inotifyscan-master/nextcloud-inotifyscan /usr/local/bin/nextcloud-inotifyscan && \
    mkdir -p /etc/inotifyscan && \
    cp /usr/local/src/nextcloud-inotifyscan-master/sample.ini /etc/inotifyscan/config.ini && \
    apt-get -y remove unzip && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

ADD ./etc/init.d/inotifyscan /etc/init.d
RUN chmod +x /etc/init.d/inotifyscan
