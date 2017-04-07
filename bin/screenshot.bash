#!/bin/bash
# Poor man screenshotting
#
# Here is what it does:
#
# - Makes screenshot (with mouse selected goemetry)
# - Uploads to server
# - Sends public link to clipboard, console output and notify-send alert

FILENAME=Screenshot_`date +%Y%m%d%H%M`.png
CRYPTNAME=$(echo -n $FILENAME | md5sum |  cut -c 1-6).png
PATHNAME=~/Dropbox/Public/Screenshot_`date +%Y%m%d%H%M%S`.png
SERVER=jarmalavicius.lt:jarmalavicius.lt/tmp
URL=https://www.jarmalavicius.lt/tmp

# Select screen area and save the screenshot to given filename
gnome-screenshot -a -f $PATHNAME

# Upload screenshot to the server
scp -q $PATHNAME "$SERVER/$CRYPTNAME"

# Expose public link to clipboard, console and `notify-send` alert
echo "$URL/$CRYPTNAME" | xclip -selection c
echo "Public link: $URL/$CRYPTNAME"
notify-send "Copied $URL/$CRYPTNAME to clipboard"
