#!/bin/zsh

rm -f $(git rev-parse --show-toplevel)/.git/tags
ctags-exuberant -f $(git rev-parse --show-toplevel)/.git/tags \
    -h ".inc" \
    -R \
    --exclude="*\.js" \
    --exclude="\.git" \
    --exclude=".virtualenv" \
    --exclude="virtual" \
    --totals=yes \
    --tag-relative=yes \
    .
