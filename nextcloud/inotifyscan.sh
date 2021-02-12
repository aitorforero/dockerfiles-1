#!/usr/bin/env bash

set -euo pipefail

function prefix {
  printf "[%s] [inotifyscan]" "$(date)"
}

if [ -f "$INOTIFY_CONFIG" ]; then
  printf "===\n"
  printf "%s config:\n===\n$%s\n===\n" "$(prefix)" "$(cat "$INOTIFY_CONFIG")"
  printf "%s starting...\n" "$(prefix)"
  gosu www-data /usr/bin/python /usr/local/bin/nextcloud-inotifyscan --config "$INOTIFY_CONFIG" 2>&1 | sed -e "s/^/$(prefix) /" &
  printf "\n%s started\n" "$(prefix)"
  printf "===\n"
else
  printf "%s No config found at %s\n" "$(prefix)" "$INOTIFY_CONFIG" 
fi

/entrypoint-nextcloud.sh "$@"
