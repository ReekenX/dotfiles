# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="reekenx"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ssh-agent)

# We will share same history file under bash and zsh
HISTFILE=~/.shell_history

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# Make ~/bin executables called within zsh
path+=("$HOME/bin")
export PATH

# compsys initialization
autoload -U compinit
compinit

source $ZSH/oh-my-zsh.sh

# For partially muonted repositories to RAM
export GIT_DISCOVERY_ACROSS_FILESYSTEM=YES

# Start tmux on local computer when zsh turned on
[ -f "$HOME/.zsh-autolaunch-tmux" ] && [ -z "$TMUX" ] && (tmux attach -t base 2> /dev/null || tmuxinator start base)
