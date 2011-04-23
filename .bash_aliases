# History file will be with date information on every entry (useful feature)
export HISTTIMEFORMAT="%Y-%m-%d %T "

# No colors for `ls` command
alias ls='ls --color=never'

# Move files to trash instead completely removing them with `rm`
alias rm='trash'

# Alert me if program in command line finished his job
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "Operation successfully completed."'

# Terminal command prompt improvement
PS1='\[\e[1;31m\]\u@\H on \D{%Y-%m-%d} \t in \w \n$ \[\e[0m\]'
