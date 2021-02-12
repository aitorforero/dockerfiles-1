#!/usr/bin/env bash
set -euo pipefail
WINEDEBUG=-all exec /usr/bin/wine64 /opt/moneywiz/setup.exe
