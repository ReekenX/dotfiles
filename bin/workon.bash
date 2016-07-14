#!/bin/bash
# The most amazing script for developer!
# Say workon.bash load www.example.org and you are ready to code
# It will scan for ~/Work/***/www.example.org and will launch tmux for that


SCAN_FOLDER="$HOME/Work"

PROJECTS_FOLDER="$HOME/.desk"
SCAN_DEPTH=2

##########################################################
# Commands
##########################################################

cmd_usage() {
    cat <<_EOF
Usage:

    $PROGRAM
        Print current script defined helper methods
    $PROGRAM help
        Print usage help (this screen).
    $PROGRAM load PROJECT-NAME
        Launch project in TMUX by finding first it
        in $SCAN_FOLDER.
_EOF
}

cmd_current() {
    local project_file="$PROJECTS_FOLDER/$(basename $(pwd)).bash"
    if [ ! -f "$project_file" ]
    then
        echo "ERROR: Project file $(basename $project_file) was not found."
        echo
        cmd_usage
        exit 1
    fi
    local callables=$(get_callables "$project_file")

    [ -z "$callables" ] || echo ""

    for NAME in $callables; do
        # Last clause in the grep regexp accounts for fish functions.
        local DOCLINE=$(
            grep -B 1 -E \
                "^(alias ${NAME}=|(function )?${NAME}( )?\()|function $NAME" "$project_file" \
                | grep "#")

        if [ -z "$DOCLINE" ]; then
            echo "  ${NAME}"
        else
            echo "  ${NAME} -" "${DOCLINE##\# }"
        fi
    done
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
        tmuxinator start php -n "$project_name"
    fi
}

##########################################################
# Utilities
##########################################################
FNAME_CHARS='[a-zA-Z0-9_-]'

# Echo a list of aliases and functions for a given desk
# Thanks: https://github.com/jamesob/desk/blob/master/desk
get_callables() {
    local DESKPATH=$1
    grep -E "^(alias |(function )?${FNAME_CHARS}+ ?\()|function $NAME" "$DESKPATH" \
        | sed 's/alias \([^= ]*\)=.*/\1/' \
        | sed -E "s/(function )?(${FNAME_CHARS}+) ?\(\).*/\2/" \
        | sed -E "s/function (${FNAME_CHARS}+).*/\1/"
}

PROGRAM=$(basename "$0")

case "$1" in
    help) shift;        cmd_usage "$@" ;;
    load) shift;        cmd_init "$@" ;;
    *)                  cmd_current "$@" ;;
esac
exit 0
