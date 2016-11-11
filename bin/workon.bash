#!/bin/bash
# The most amazing script for developers! Seriously.
#
# Say `workon.bash www.example.org` and it will launch your projects
# development environment using tmux. See my tmux scripts in the same repo.

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
    local project_folder=$(find "$SCAN_FOLDER" -maxdepth $SCAN_DEPTH \( -type d -or -type l \) -iname "*$1*" 2> /dev/null)
    local project_name=$(basename "$project_folder" | sed -e 's/www//' -e 's/[^a-zA-Z0-9]/-/g' -e 's/^[^a-zA-Z]//')

    if [ -z "$project_folder" ]
    then
        echo "ERROR: Project with name $1 was not found on $SCAN_FOLDER"
        exit 1
    else
        cd "$project_folder"
        if find -maxdepth 2 -iname 'rails' | grep -q '.*'
        then
            tmuxinator start rails -n "$project_name"
        elif find -maxdepth 2 -iname '.virtualenv' -type d | grep -q '.*'
        then
            tmuxinator start django -n "$project_name"
        elif find -maxdepth 2 -iname 'virtual' -type d | grep -q '.*'
        then
            tmuxinator start django-ext -n "$project_name"
        elif find -maxdepth 2 -iname 'idcard' -type d | grep -q '.*'
        then
            tmuxinator start php-ext -n "$project_name"
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
