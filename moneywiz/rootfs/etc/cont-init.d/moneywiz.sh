#!/usr/bin/with-contenv sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Make sure mandatory directories exist.
mkdir -p /config/temp

# Copy default configuration if needed.
[ -f /config/custom.ini ] || cp /defaults/custom.ini /config/
[ -f /config/user.reg ] || cp /defaults/user.reg /config/
[ -f /config/system.reg ] || cp /defaults/system.reg /config/

# Prepare home dir
usermod -m -d /home/app app 2> /dev/null || true
mkdir -p /home/app
chown app:app /home/app

# Take ownership of the config directory content.
find /config -mindepth 1 -exec chown $USER_ID:$GROUP_ID {} \;

# vim: set ft=sh :
