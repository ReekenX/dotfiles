# Special key bindings
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
alias O=xdg-open
alias rm=trash

# No glob search when using special symbols
alias find="noglob find"
alias dpkg="noglob dpkg"

# Enable completion cache. Advantages of this can be seen using `apt` or `dpkg` commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ignore some files in ZSH autocompletion
zstyle ':completion:*:(all-|)files' ignored-patterns '*.pyc'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.mo'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.swp'
