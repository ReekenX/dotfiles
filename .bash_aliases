# History file will be with date information
export HISTTIMEFORMAT="%Y-%m-%d %T "

# Common aliases to update OS software
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get autoremove;sudo apt-get autoclean;'
alias install='sudo apt-get install'
alias clean='sudo apt-get autoremove;sudo apt-get autoclean;'

# No colors for `ls` command
alias ls='ls --color=never'

# Move files to trash instead completely removing them
alias rm='trash'

# This useful for commands that takes time
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "Operation successfully completed."'
