# Use an Alpine linux base image with GNU libc (aka glibc) pre-installed, courtesy of Vlad Frolov
FROM frolvlad/alpine-glibc:alpine-3.11_glibc-2.31

LABEL maintainer="jakbutler"

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Calibre environment variables
ENV CALIBRE_LIBRARY_DIRECTORY=/opt/calibredb/library
ENV CALIBRE_CONFIG_DIRECTORY=/opt/calibredb/config

# User
ENV PUID=0
ENV PGID=0

# Auto-import directory
ENV CALIBREDB_IMPORT_DIRECTORY=/opt/calibredb/import

# Auto-import directory
ENV CALIBREDB_ERROR_DIRECTORY=/opt/calibredb/error

# Flag for automatically updating to the latest version on startup
ENV AUTO_UPDATE=0

#########################################
##         DEPENDENCY INSTALL          ##
#########################################
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk update && \
    apk add --no-cache --upgrade \
    bash \
    ca-certificates \
    gcc \
    imagemagick \
    libstdc++6 \
    mesa-gl \
    nss-dev \
    python3 \
    qt5-qtbase-x11 \
    shadow \
    wget \
    xdg-utils \
    xz && \
#########################################
##            APP INSTALL              ##
#########################################
    wget -q -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | python3 -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" && \
    rm -rf /tmp/calibre-installer-cache

#########################################
##            Script Setup             ##
#########################################
COPY run_auto_importer.sh /usr/bin/run_auto_importer.sh
RUN chmod a+x /usr/bin/run_auto_importer.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
VOLUME /opt/calibredb/config
VOLUME /opt/calibredb/import
VOLUME /opt/calibredb/library
VOLUME /opt/calibredb/error

#########################################
##           Startup Command           ##
#########################################
CMD ["/usr/bin/run_auto_importer.sh"]