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

source ~/.zsh_aliases
