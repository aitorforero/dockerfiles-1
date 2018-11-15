FROM linuxserver/nextcloud

RUN apk update && \
    apk add --no-cache --update tesseract-ocr build-base php7-pear && \
    apk search -qe 'tesseract-ocr-data-*' | xargs apk add --no-cache --update && \
    pecl install inotify    
