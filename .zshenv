# Special key bindings to allow shift+left/right
bindkey -e
bindkey "5C" forward-word
bindkey "5D" backward-word

# Autocomplete like in VIM
setopt MENU_COMPLETE

export AUTHOR="Remigijus Jarmalavičius <remigijus@jarmalavicius.lt>"
export EDITOR=vim
export PATH=$PATH:$HOME/Kodas/skriptai

# My aliases
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'
alias -g G='| grep -i'
alias -g L='| less'
alias -g C='| wc -l'
alias -g X='| xargs'
alias o='xdg-open'
alias ll='ls -Flh --group-directories-first --color=auto'
alias tmux="/usr/bin/tmux -2"
alias cp="/bin/cp -R"
alias scp="/usr/bin/scp -r"
alias :e="vim"
alias :q="exit"
alias bzr="LC_ALL=C /usr/bin/bzr"
alias todo="~/Kodas/asmeniniai/todo.txt/todo.sh -d ~/Kodas/asmeniniai/todo.txt/todo.cfg"

# Enable sorting of TODO's easily
export TODOTXT_DEFAULT_ACTION=ls

# Enable completion cache. Advantages of this can be seen using `apt` or `dpkg` commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ignore some files in ZSH autocompletion
zstyle ':completion:*:(all-|)files' ignored-patterns '*.pyc'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.mo'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.swp'

# Make simple backup with single command
function backup () {
    newname=$1.`date +%Y%m%d.%H%M.bak`
    mv $1 $newname
    echo "Backed up $1 to $newname."
    cp -p $newname $1
}

# Beeps
function success() {
    beep -f 2800
    sleep 0.2
    beep -f 2800
}

function notification() {
    beep -f 2800
    sleep 0.2
    beep -f 2800
    sleep 0.2
    beep -f 2800
    sleep 0.2
    beep -f 2800
    sleep 0.2
    beep -f 2800
}

function error() {
    beep -f 900
    sleep 0.2
    beep -f 900
    sleep 0.2
    beep -f 900
}

# "Smart" mplayer
function smplayer() {
    mplayer -fs $1 && rm $1
}

# Fix ssh-add for multiple sessions
SSH_ENV=$HOME/.ssh/environment

function start_agent {
     /usr/bin/ssh-agent -a /tmp/.current-ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     export SSH_AUTH_SOCK=/tmp/.current-ssh-agent
     chmod 600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV}
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi
