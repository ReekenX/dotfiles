#!/bin/bash
# Script to setup 4 monitors I have home with single command

# Turn off monitors to prevent floating point errors
xrandr --output HDMI-0 --off
xrandr --output VGA-0 --off
xrandr --output DVI-1-0 --off
xrandr --output DVI-1-1 --off

xrandr --output HDMI-1-1 --auto --pos 0x0
xrandr --output HDMI-0 --auto --pos 1920x0
xrandr --output VGA-0 --auto --pos 0x1080
xrandr --output DVI-1-0 --auto --pos 1920x1080
xrandr --output DVI-1-1 --auto --pos 1920x1080
