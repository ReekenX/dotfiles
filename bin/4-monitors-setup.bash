#!/bin/bash
# Script to setup 4 monitors I have home with single command

# Turn off monitors to prevent floating point errors
xrandr --output HDMI-1 --off
xrandr --output VGA-1 --off
xrandr --output VGA-1-1 --off

# Restore monitors
xrandr --output HDMI-1-1 --auto --pos 0x0
xrandr --output HDMI-1 --auto --pos 1920x0
xrandr --output VGA-1 --auto --pos 0x1080
xrandr --output VGA-1-1 --auto --pos 1920x1080
