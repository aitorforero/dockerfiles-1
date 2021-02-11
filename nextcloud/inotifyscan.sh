#!/usr/bin/env bash

if [ -f "$INOTIFY_CONFIG" ]; then
  print "===\n"
  printf "[inotifyscan]: Config:\n===\n$%s\n===\n" "$(cat $INOTIFY_CONFIG)"
  printf "[inotifyscan]: Starting...\n"
  gosu www-data /usr/bin/python /usr/local/bin/nextcloud-inotifyscan --config "$INOTIFY_CONFIG" &
  printf "\n[inotifyscan]: Started\n"
  printf "===\n"
else
  echo "[inotifyscan]: No config found at $INOTIFY_CONFIG. Exiting"
fi

/entrypoint-nextcloud.sh "$@"
