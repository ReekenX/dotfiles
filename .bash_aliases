# History file will be with date information on every entry (useful feature)
export HISTTIMEFORMAT="%Y-%m-%d %T "
export HISTFILE=~/.bash_history
export HISTSIZE=100000000
export HISTFILESIZE=100000000
export HISTCONTROL=""

# Colorize some commands by default
alias ll='ls -FlhG'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Docker helpers (used on servers only)
alias down="docker-compose down"
alias up="docker-compose up -d"
alias status="docker ps -a | awk -F\ \ \ \* '{printf(\"%-15s %-40s%s\n\", \$1, \$7 == \"\" ? \$6 : \$7, \$5)}'"
alias logs="docker logs --since 3h -f \$(status | awk 'NR != 1 {print \$2}' | fzy)"
alias restart="docker restart \$(status | awk 'NR != 1 {print \$2}' | fzy)"
alias stop="docker stop \$(status | awk 'NR != 1 {print \$2}' | fzy)"
alias start="docker start \$(status | awk 'NR != 1 {print \$2}' | fzy)"
alias go='cd "$(find ~ -not -path '"'"'*/\.*'"'"' -not -path '"'"'*/media/*'"'"' -not -path '"'"'*/assets/*'"'"' -not -path '"'"'*/static/*'"'"' -type d -maxdepth 2 | fzy)"'
