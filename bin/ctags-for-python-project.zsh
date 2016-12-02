#!/bin/zsh

# Check for `ctags` package
if ! $(command -v ctags >/dev/null 2>&1)
then
    echo "Install ctags first"
    echo
    echo -e "\tsudo apt-get install exuberant-ctags"
    echo
    echo "Once installed, run this script again."
    exit 1
fi

# Remove already generated tags file (if exists)
rm -f $(git rev-parse --show-toplevel)/.git/tags

# Generate tags file and store it in .git/tags
ctags -f $(git rev-parse --show-toplevel)/.git/tags \
    -h ".inc" \
    -R \
    --exclude="*\.js" \
    --exclude="\.git" \
    --exclude=".virtualenv" \
    --exclude="virtual" \
    --totals=yes \
    --tag-relative=yes \
    .
