#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep gnome-session)/environ|cut -d= -f2-)
