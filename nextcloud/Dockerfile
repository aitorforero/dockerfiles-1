FROM linuxserver/nextcloud

RUN apk update && \
    apk add --no-cache --update tesseract-ocr php7-dev php7-pear build-base && \
    apk search -qe 'tesseract-ocr-data-*' | xargs apk add --no-cache --update && \
    pecl install inotify && \
    printf "extension=inotify.so\n" > /etc/php7/conf.d/inotify.ini
    
