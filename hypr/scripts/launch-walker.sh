#!/usr/bin/env bash

pgrep -x elephant >/dev/null || elephant &

# give elephant a moment on first run (cheap and cheerful)
sleep 0.05

# toggle if already open
if pgrep -x walker >/dev/null; then
  pkill -x walker
else
  walker
fi
