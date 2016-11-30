#!/bin/bash
#
# Reset 4 monitors (two on top, two on bottom)
#

# Turn off monitors to prevent floating point errors
for monitor in  "HDMI-0" "VGA-0" "DVI-1-0"
do
    xrandr --output $monitor --off
    xrandr --output $monitor --auto
    sleep 0.5
done

xrandr --output HDMI-1-1 --pos 0x0
xrandr --output HDMI-1-1 --primary
