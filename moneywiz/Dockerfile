#
# moneywiz Dockerfile
#
# https://github.com/jlesage/docker-moneywiz
#

# Pull base image.
FROM jlesage/baseimage-gui:debian-9-v3.5.2

# Define software download URLs.
ARG MONEYWIZ_URL=https://windows.moneywizapp.com/free/setup.exe
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
WORKDIR /tmp

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "=> Preparing..." && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y --no-install-recommends install apt-utils && \
    echo "=> Installing basic tools..." && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install procps wget winbind gnupg2 software-properties-common cabextract apt-transport-https shared-mime-info && \
    echo "=> Installing Wine..." && \
    dpkg --add-architecture i386 && \
    wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
    apt-add-repository https://dl.winehq.org/wine-builds/debian/ && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install winehq-stable && \
    echo "=> Installing WineTricks..." && \
    wget -q "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks" -O /tmp/winetricks && \
    chmod +x /tmp/winetricks && \
    echo "Starting X server..." && \
    (/usr/bin/Xvfb :0 &) && \
    while ! xdpyinfo -display :0 > /dev/null 2>&1; do sleep 1; done && \
    echo "Creating Wine prefix..." && \
    env WINEPREFIX=/opt/moneywiz WINEARCH=win64 WINEDLLOVERRIDES="mscoree,mshtml=" wineboot --init && wineserver -w && \
    echo "Installing MoneyWiz dependencies..." && \
    env WINEPREFIX=/opt/moneywiz WINEARCH=win64 WINEDLLOVERRIDES="mscoree,mshtml=" sh /tmp/winetricks -q dotnet461 corefonts && \
    wget -q "http://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe" -O /tmp/vcredist_x64.exe && \
    env WINEPREFIX=/opt/moneywiz WINEARCH=win64 wine64 /tmp/vcredist_x64.exe /q /norestart && \
    while pgrep wineserver; do sleep 1; done && sleep 5 && while pgrep wineserver; do sleep 1; done && \
    echo "Downloading MoneyWiz setup..." && \
    wget -q "https://windows.moneywizapp.com/free/setup.exe" -O /opt/moneywiz/setup.exe && \
    # Rename Windows user.
    mv /opt/moneywiz/drive_c/users/root /opt/moneywiz/drive_c/users/app && \
    sed -i 's|\\root\\|\\app\\|g' /opt/moneywiz/user.reg  && \
    sed -i 's|\\root\\|\\app\\|g' /opt/moneywiz/userdef.reg && \
    # Save some stuff outside the container.
    ln -s /config/custom.ini /opt/moneywiz/custom.ini && \
    mkdir -p /defaults && \
    mv /opt/moneywiz/user.reg /defaults/ && \
    ln -s /config/user.reg /opt/moneywiz/user.reg && \
    mv /opt/moneywiz/system.reg /defaults/ && \
    ln -s /config/system.reg /opt/moneywiz/system.reg && \
    # Adjust the openbox config.
    # Maximize only the main/initial window.
    sed -i 's/<application type="normal">/<application type="normal" title="MoneyWiz *">/' \
        /etc/xdg/openbox/rc.xml && \
    # Make sure the main window is always in the background.
    sed -i '/<application type="normal" title="MoneyWiz \*">/a \    <layer>below</layer>' \
        /etc/xdg/openbox/rc.xml && \
    # Generate and install favicons.
    APP_ICON_URL=https://raw.githubusercontent.com/itsthejb/dockerfiles/master/moneywiz/images/MoneyWiz.png && \
    install_app_icon.sh "$APP_ICON_URL" && \
    # Permissions
    chown -R 1000:1000 /opt/moneywiz && \
    # Cleanup.
    DEBIAN_FRONTEND=noninteractive apt-get -y --purge remove apt-utils wget gnupg2 software-properties-common cabextract apt-transport-https shared-mime-info && \
    DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
    find "/opt/moneywiz/drive_c/windows/Microsoft.NET" -name "SetupCache" -type d -exec rm -rf {} \; 2> /dev/null || true && \
    rm -rf /root/.cache/winetricks/ && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* 

# Add files.
COPY rootfs/ /

# # Set environment variables.
ENV APP_NAME="MoneyWiz" \
    WINEPREFIX=/opt/moneywiz

# Define mountable directories.
VOLUME ["/moneywiz/app"]
VOLUME ["/moneywiz/data"]

# # Metadata.
LABEL \
    org.label-schema.name="moneywiz" \
    org.label-schema.description="Docker container for MoneyWiz" \
    org.label-schema.version="unknown" \
    org.label-schema.vcs-url="https://github.com/itsthejb/dockerfiles/moneywiz" \
    org.label-schema.schema-version="1.0"

