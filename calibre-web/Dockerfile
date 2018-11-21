FROM linuxserver/calibre-web

ARG KINDLEGEN="kindlegen_linux_2.6_i386_v2_9"
RUN wget "http://kindlegen.s3.amazonaws.com/${KINDLEGEN}.tar.gz" -O "/tmp/${KINDLEGEN}.tar.gz" && \
    mkdir -p "/usr/local/src/${KINDLEGEN}" && \
    tar xzvf "/tmp/${KINDLEGEN}.tar.gz" -C "/usr/local/src/${KINDLEGEN}" && \
    rm "/tmp/${KINDLEGEN}.tar.gz" && \
    chown -R root:root "/usr/local/src/${KINDLEGEN}" && \
    ln -s "/usr/local/src/${KINDLEGEN}/kindlegen" "/usr/local/bin/kindlegen"
    
