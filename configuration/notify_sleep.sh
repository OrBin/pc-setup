#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS:-"unix:path=/run/user/$(id -u)/bus"}

if [[ "$(gnome-screensaver-command --query)" = "The screensaver is active" ]]; then
  echo "Screen is locked, exiting"
  exit
fi

notify-send -t 300000 'Go to sleep!' 'Screen will be locked in 2 minutes'
sleep 120
gnome-screensaver-command --activate
