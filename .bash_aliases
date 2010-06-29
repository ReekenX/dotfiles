# History file will be with date information
export HISTTIMEFORMAT="%Y-%m-%d %T "

# Make prompt line hightlighted
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\][\t] \w\[\033[00m\]: '

# Common aliases to update OS software
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get autoremove;sudo apt-get autoclean;'
alias install='sudo apt-get install'
alias clean='sudo apt-get autoremove;sudo apt-get autoclean;'

# Move files to trash instead completely removing them
alias rm='trash'

# Show `svn diff` with meld
alias sd 'svn diff --diff-cmd svn-diff'

