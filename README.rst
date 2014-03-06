Dotfiles for Linux software
===========================

Linux software configuration files for geeks who are using (could be any of them): vim, git, hg, screen, tmux, buildout, oh-my-zsh, rst. Home edition.

Already tested on Gentoo, Ubuntu and Debian servers. Works out of the box.

For server dotfiles see other repository called dotfiles-server.

License
-------

You are free to `fork`, modify and do amazing stuff. Please keep me in touch me with your improvements, I am always interested to see how this can be improved. Thanks.

Install
-------

Open your home directory, extract to .git folder, update source code and update GIT submodules. They are used to receive latest VIM plugins.

For g33ks this should sound better::

    git clone --bare https://github.com/ReekenX/dotfiles-home ~/.git
    git config core.bare false
    git checkout -f master
    git submodule init
    git submodule update

Hardcoded stuff
---------------

Because `buildout` is buggy, and '~' doesn't expand to home directory, .buildout folder contains my hardcoded path. Make sure you change it if you are going to use it.

GIT configuration (.gitconfig) has my name, surname and e-mail information. Be sure to change it. Same with Mercurial (.hgrc).

Bugs
----

This project has no bugs. But you can fill feature requests, discuss some configuration or use it for learning purposes.

You can leave a comment in: https://github.com/ReekenX/dotfiles-home/issues/new
