#!/bin/bash
# The most amazing script for developer!
# Say workon.bash www.example.org and you are ready to code
# It will scan for ~/Work/***/www.example.org and will launch tmux for that

PROGRAM=$(basename "$0")
SCAN_FOLDER="$HOME/Work"
SCAN_DEPTH=2

##########################################################
# Commands
##########################################################

cmd_usage() {
    cat <<_EOF
Usage:

    $PROGRAM
        Print usage help (this screen).
    $PROGRAM PROJECT-NAME
        Launch project in TMUX by finding first it
        in $SCAN_FOLDER.
_EOF
}

cmd_init() {
    local project_folder=$(find "$SCAN_FOLDER" -maxdepth $SCAN_DEPTH \( -type d -or -type l \) -iname "$1" 2> /dev/null)
    local project_name=$(basename "$project_folder" | sed -e 's/www//' -e 's/[^a-zA-Z0-9]/-/g' -e 's/^[^a-zA-Z]//')

    if [ -z "$project_folder" ]
    then
        echo "ERROR: Project with name $1 was not found on $SCAN_FOLDER"
        exit 1
    else
        cd "$project_folder"
        if find -maxdepth 3 -iname 'rails' | grep '.*'
        then
            tmuxinator start rails -n "$project_name"
        else
            tmuxinator start php -n "$project_name"
        fi
    fi
}

##########################################################
# Actual work
##########################################################

case "$1" in
    help) shift;        cmd_usage "$@" ;;
    *)                  cmd_init "$@" ;;
esac
exit 0
