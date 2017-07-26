# Special key bindings to allow shift+left/right
bindkey -e
bindkey "5C" forward-word
bindkey "5D" backward-word

# Autocomplete like in VIM
setopt menu_complete

# Development stuff
export EDITOR=vim

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Disable colors in ls
export DISABLE_LS_COLORS="true"

# Disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# For partially mounted repositories to RAM
export GIT_DISCOVERY_ACROSS_FILESYSTEM=YES

# Make ~/bin executables called within zsh
path+=("$HOME/bin")
export PATH

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
