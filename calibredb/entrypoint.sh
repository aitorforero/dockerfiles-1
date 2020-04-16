#!/usr/bin/env bash

PUID=${PUID:-911}
PGID=${PGID:-911}

addgroup -S abc
adduser -S abc -G abc
groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

su abc -s /bin/bash /usr/bin/run_auto_importer.sh 
