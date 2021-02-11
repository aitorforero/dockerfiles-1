#!/usr/bin/env bash
set -euxo pipefail
WINEDEBUG=-all exec /usr/bin/wine64 /opt/moneywiz/setup.exe
