FROM linuxserver/nextcloud

# https://github.com/linuxserver/docker-nextcloud/pull/166
RUN apk del php7-iconv

# tesseract-ocr
RUN apk update && \
    apk add --no-cache --update \
    tesseract-ocr \
    tesseract-ocr-data-deu \
    tesseract-ocr-data-jpn \
    php7-soap \
# nextcloud-inotifyscan
# https://github.com/Blaok/nextcloud-inotifyscan
    python3 \
    inotify-tools && \
    mkdir -p /usr/local/src/nextcloud-inotifyscan && \
    git clone https://github.com/Blaok/nextcloud-inotifyscan.git /usr/local/src/nextcloud-inotifyscan && \
    /bin/chmod +x /usr/local/src/nextcloud-inotifyscan/nextcloud-inotifyscan && \
    ln -s /usr/local/src/nextcloud-inotifyscan/nextcloud-inotifyscan /usr/local/bin/nextcloud-inotifyscan && \
    cp /usr/local/src/nextcloud-inotifyscan/sample.ini /config/nextcloud-inotifyscan.ini && \
    mkdir -p /etc/services.d/inotifyscan && \
    ln -s /config/www/nextcloud/occ /occ && \
# https://github.com/linuxserver/docker-nextcloud/pull/166
    echo "**** Install iconv extension ****" && \
    apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
	gnu-libiconv \
	php7-iconv
# Preload iconv extension
ENV LD_PRELOAD=/usr/lib/preloadable_libiconv.so

ADD ./inotifyscan /etc/services.d/inotifyscan/run
RUN chmod +x /etc/services.d/inotifyscan/run
