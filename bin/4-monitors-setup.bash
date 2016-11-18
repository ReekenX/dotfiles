#!/bin/bash
# Script to setup 4 monitors I have home with single command

# Turn off monitors to prevent floating point errors
for monitor in "HDMI-1-1" "HDMI-0" "VGA-0" "DVI-1-0"
do
    xrandr --output $monitor --off
done

xrandr --output HDMI-1-1 --auto --pos 0x0
xrandr --output HDMI-0 --auto --pos 1920x0
xrandr --output VGA-0 --auto --pos 0x1080
xrandr --output DVI-1-0 --auto --pos 1920x1080
