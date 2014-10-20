Dotfiles for Linux software
===========================

Linux software configuration files for geeks who are using (could be any of them): vim, git, hg, screen, tmux, buildout, oh-my-zsh, rst. Home edition.

Already tested on Gentoo, Ubuntu and Debian servers. Works out of the box.

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
    git submodule update --init

Automatic installer
-------------------

Run only, if you trust me::

    curl -s -L https://raw.github.com/ReekenX/dotfiles-home/master/.install-dotfiles-home.sh | bash

It has the same commands I wrote above in `Install` section.

Hardcoded stuff
---------------

GIT configuration (.gitconfig) has my name, surname and e-mail information. Be sure to change it. Same with Mercurial (.hgrc).

Bugs
----

This project has no bugs. But you can fill feature requests, discuss some configuration or use it for learning purposes.

You can leave a comment in: https://github.com/ReekenX/dotfiles-home/issues/new
