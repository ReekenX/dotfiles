#!/bin/bash
# Copied from: https://tante.cc/2013/03/15/quickly-sharing-a-screenshot-from-linux/

# The file needs to be below the "Public" Dropbox folder
FILENAME=~/Dropbox/Public/Screenshot_`date +%Y%m%d%H%M`.png

# Select an area and save the screenshot
gnome-screenshot -a -f $FILENAME 

URL=`dropbox puburl $FILENAME`

echo $URL | xclip

# Pop up a small notification
notify-send "Copied $URL to clipboard"
