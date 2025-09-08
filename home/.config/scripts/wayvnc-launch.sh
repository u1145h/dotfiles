#!/bin/bash

# Wait until the Wayland socket exists
while [ ! -S "$XDG_RUNTIME_DIR/wayland-1" ]; do
  sleep 1
done

exec /usr/bin/wayvnc 0.0.0.0 --render-cursor --password '84938715'
