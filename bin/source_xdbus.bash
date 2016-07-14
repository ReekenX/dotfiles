#!/bin/bash
# Source this script to use GUI programs from cron (like Skype launching on specific time)

export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep gnome-session)/environ|cut -d= -f2-)
