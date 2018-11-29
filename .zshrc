# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="reekenx"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ssh-agent-multiuser)

# We will share same history file under bash and zsh
HISTFILE=~/.shell_history

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# compsys initialization
autoload -U compinit
compinit

# Enable completion cache. Advantages of this can be seen using `apt` or `dpkg` commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ignore some files in ZSH autocompletion
zstyle ':completion:*:(all-|)files' ignored-patterns '*.pyc'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.mo'
zstyle ':completion:*:(all-|)files' ignored-patterns '*.swp'

# Oh my zsh configuration
source $ZSH/oh-my-zsh.sh

# Add RVM to PATH for scripting
if [ -d $HOME/.rvm/bin ]
then
    export PATH="$PATH:$HOME/.rvm/bin"
    source $HOME/.rvm/scripts/rvm
fi

# Always start work session with tmux so that no work is lost when closing apps
[ -z "$TMUX" ] && { tmux attach -u || tmuxinator start base }

# Force UTF8 (a must for MacOS)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
