#!/bin/sh

# if no file specified default to lolcat reading on stdin
if [ $# -eq 0 ]; then
    cat
else
    TYPE=$(pygmentize -N $1)

    if [ $TYPE = "text" ]; then
        cat $1
    else
        pygmentize $1
    fi
fi
