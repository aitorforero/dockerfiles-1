FROM linuxserver/nextcloud

# tesseract-ocr
RUN apk update && \
    apk add --no-cache --update \
    tesseract-ocr \
    tesseract-ocr-data-deu \
    tesseract-ocr-data-jpn

# nextcloud-inotifyscan
# https://github.com/Blaok/nextcloud-inotifyscan
RUN apk add --no-cache --update python inotify-tools && \
    /usr/bin/wget "https://raw.githubusercontent.com/Blaok/nextcloud-inotifyscan/master/nextcloud-inotifyscan" -O /usr/local/bin/nextcloud-inotifyscan && \
    /bin/chmod +x /usr/local/bin/nextcloud-inotifyscan && \
    mkdir -p /etc/services.d/inotifyscan && \
    ln -s /config/www/nextcloud/occ /occ
ADD ./inotifyscan /etc/services.d/inotifyscan/run
RUN chmod +x /etc/services.d/inotifyscan/run
