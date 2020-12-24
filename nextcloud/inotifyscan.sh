#!/usr/bin/env bash

CONFIG="/config/nextcloud-inotifyscan.ini"

if [ -f "$CONFIG" ]; then
  printf "[inotifyscan]: Config:\n===\n$%s\n===\n" "$(cat $CONFIG)"
  printf "[inotifyscan]: Starting... "
  runuser -l www-data -- /usr/bin/python3 /usr/local/bin/nextcloud-inotifyscan --config "$CONFIG" &
  printf "\n[inotifyscan]: Started"
else
  echo "[inotifyscan]: No config found at $CONFIG. Exiting"
fi

/entrypoint-nextcloud.sh "$@"
