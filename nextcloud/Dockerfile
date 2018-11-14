FROM linuxserver/nextcloud

RUN apk update && \
    apk add inotify-tools && \
    apk add --no-cache --update tesseract-ocr && \
    apk search -qe 'tesseract-ocr-data-*' | xargs apk add --no-cache --update
    
