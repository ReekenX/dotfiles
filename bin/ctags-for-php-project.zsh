#!/bin/zsh

rm -f $(git rev-parse --show-toplevel)/.git/tags
ctags-exuberant -f $(git rev-parse --show-toplevel)/.git/tags \
    -h ".inc" \
    -R \
    --exclude="*\.js" \
    --exclude="\.git" \
    --exclude="vendor" \
    --exclude="vendors" \
    --totals=yes \
    --tag-relative=yes \
    --PHP-kinds=cidf \
    --langmap=PHP:+.inc \
    --regex-PHP="/define[ \t]*\\([ \t]*['\"]?([a-zA-Z_][a-zA-Z0-9_]*)/\1/d/" \
    --regex-PHP='/(abstract)?\s+class\s+([^ ]+)/\2/c/' \
    --regex-PHP='/(static|abstract|public|protected|private)\s+(final\s+)?function\s+(\&\s+)?([^ (]+)/\4/f/' \
    --regex-PHP='/function\s+(\&\s+)?([^ (]+)/\2/f/' \
    --regex-PHP='/interface\s+([^ ]+)/\1/i/' \
    .
