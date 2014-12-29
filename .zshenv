# Special key bindings to allow shift+left/right
bindkey -e
bindkey "5C" forward-word
bindkey "5D" backward-word

# Autocomplete like in VIM
setopt menu_complete

export LC_ALL="en_US.UTF-8"

# Development stuff
export EDITOR=vim

# Enable completion cache. Advantages of this can be seen using `apt` or `dpkg` commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ignore some files in ZSH autocompletion
zstyle ':completion:*:(all-|)files' ignored-patterns '*.pyc'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.mo'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.swp'

# Fix ssh-add for multiple sessions
SSH_ENV=$HOME/.ssh/environment

source ~/.zsh_aliases
