#!/bin/bash
#
# Setup 4 monitors (two on top, two on bottom)
#

# Make to left monitor primary so it will receive menus
xrandr --output HDMI-1-1 --pos 0x0
xrandr --output HDMI-1-1 --primary

# Top right
# xrandr --output HDMI-0 --auto
xrandr --output HDMI-0 --pos 1920x0

# Bottom left
# xrandr --output VGA-0 --auto
xrandr --output VGA-0 --pos 0x1080

# Bottom right
# xrandr --output DVI-1-0 --auto
xrandr --output DVI-1-0 --pos 1920x1080
