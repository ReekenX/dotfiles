#!/bin/bash
# Poor man screensharing
#
# - Make screenshot
# - Upload to server
# - Send link to clipboard
# - Share with friends (well, this is manual step)

# The file needs to be below the "Public" Dropbox folder
FILENAME=Screenshot_`date +%Y%m%d%H%M`.png
PATHNAME=~/Dropbox/Public/Screenshot_`date +%Y%m%d%H%M`.png
SERVER=jarmalavicius.lt:jarmalavicius.lt/tmp
URL=https://www.jarmalavicius.lt/tmp

# Select an area and save the screenshot
gnome-screenshot -a -f $PATHNAME

scp -q $PATHNAME "$SERVER/$FILENAME"
echo "$URL/$FILENAME" | xclip -selection c
echo "Public link: $URL/$FILENAME"

# Pop up a small notification
notify-send "Copied $URL/$FILENAME to clipboard"
