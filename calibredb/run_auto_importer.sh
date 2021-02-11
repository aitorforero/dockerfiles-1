#!/usr/bin/env bash

set -euxo pipefail

PUID=${PUID:-911}
PGID=${PGID:-911}

groupadd -f abc
id -u abc &>/dev/null || adduser -S abc -G abc
groupmod -o -g "$PGID" abc || true
usermod -o -u "$PUID" abc || true

printf "=> Running as user: "
su abc -s /usr/bin/id

# Perform a software update, if requested
my_version=$(/opt/calibre/calibre --version | awk -F'[() ]' '{print $4}')
if [ ! "$AUTO_UPDATE" = "1" ]; then
  echo "AUTO_UPDATE not requested, keeping installed version of $my_version."
else
  echo "AUTO_UPDATE requested, checking for latest version..."
  latest_version=$(wget -q -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/Changelog.yaml | grep -m 1 "^- version:" | awk '{print $3}')
  if [ "$my_version" != "$latest_version" ]
  then
    echo "Updating from $my_version to $latest_version."
    wget -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | python3 -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)"
    rm -rf /tmp/calibre-installer-cache
  else
    echo "Installed version of $my_version is the latest."
  fi
fi

# Make sure our environment variables are in place, just in case.
if [ -z "$CALIBRE_LIBRARY_DIRECTORY" ]; then
  CALIBRE_LIBRARY_DIRECTORY=/opt/calibredb/library
fi
if [ -z "$CALIBRE_CONFIG_DIRECTORY" ]; then
  CALIBRE_CONFIG_DIRECTORY=/opt/calibredb/config
fi
if [ -z "$CALIBREDB_IMPORT_DIRECTORY" ]; then
  CALIBREDB_IMPORT_DIRECTORY=/opt/calibredb/import
fi

echo "Starting auto-importer process."
# Continuously watch for new content in the defined import directory.
while true
do
    count=$(find $CALIBREDB_IMPORT_DIRECTORY -mindepth 1 -maxdepth 1 | wc -l)
    if [ "$count" -gt 0 ]; then
      echo "Attempting import of $count new files/directories."
# Use the calibredb commandline api to import the new file or directory, which also copies it to the library,
# then remove it from the import directory.
# For more detail, see https://manual.calibre-ebook.com/generated/en/calibredb.html
      su abc -s /bin/bash -c \
        "/opt/calibre/calibredb \
        add $CALIBREDB_IMPORT_DIRECTORY \
        -r --with-library $CALIBRE_LIBRARY_DIRECTORY && \
        rm -rf $CALIBREDB_IMPORT_DIRECTORY/*"
    fi
#TODO: Make this a configurable variable
    sleep 1m
done