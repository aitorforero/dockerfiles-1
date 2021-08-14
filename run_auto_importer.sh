#!/usr/bin/env bash

set -euo pipefail

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
su abc -l
while true
do
   shopt -s nullglob
   for filename in *.epub
   do
      echo "Importing \"$filename\"..."

      /opt/calibre/calibredb add \"$filename\" --with-library $CALIBRE_LIBRARY_DIRECTORY 
      
      rm -f \"$filename\"

   done
   shopt -s nullglob  
   echo "Otra vuelta"
   sleep 1m
done
