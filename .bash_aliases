# History file will be with date information on every entry (useful feature)
export HISTTIMEFORMAT="%Y-%m-%d %T "
export HISTFILE=~/.shell_history
export HISTSIZE=100000000
export HISTFILESIZE=999999999
export HISTIGNORE=""
export HISTCONTROL=""

# No colors for `ls` command
alias ls='ls --color=never'

# List files in "smart" way
alias ll='ls -Flh --color=never --group-directories-first'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias i="sudo apt-get install -y"
alias s="sudo apt-cache search"
alias u="sudo apt-get update"

alias mr="/etc/init.d/mysql restart"
alias pr="/etc/init.d/postgresql restart"
alias ar="/etc/init.d/apache2 restart"
