# Special key bindings to allow shift+left/right
bindkey -e
bindkey "5C" forward-word
bindkey "5D" backward-word

# Autocomplete like in VIM
setopt MENU_COMPLETE

export AUTHOR="Remigijus Jarmalavičius <remigijus@jarmalavicius.lt>"
export EDITOR=vim

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
alias ins='sudo apt-get install'
alias pur='sudo apt-get purge'
alias ser='sudo apt-cache search'

# No glob search when using special symbols
alias find="noglob find"
alias dpkg="noglob dpkg" # Why this doesn't work???

# Enable completion cache. Advantages of this can be seen using `apt` or `dpkg` commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ignore some files in ZSH autocompletion
zstyle ':completion:*:(all-|)files' ignored-patterns '*.pyc'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.mo'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.swp'

# Make simple backup with single command
function backup () {
    newname=$1.`date +%Y%m%d.%H%M.bak`;
    mv $1 $newname;
    echo "Backed up $1 to $newname.";
    cp -p $newname $1;
}
