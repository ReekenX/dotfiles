#!/bin/bash
# Make screenshot, upload to Dropbox and to clipboard get public URL for sharing
# Copied from: https://tante.cc/2013/03/15/quickly-sharing-a-screenshot-from-linux/

# The file needs to be below the "Public" Dropbox folder
FILENAME=~/Dropbox/Public/Screenshot_`date +%Y%m%d%H%M`.png

# Select an area and save the screenshot
gnome-screenshot -a -f $FILENAME 

URL=`python ~/bin/dropbox.py sharelink $FILENAME`

echo $URL | xclip

# Pop up a small notification
notify-send "Copied $URL to clipboard"
