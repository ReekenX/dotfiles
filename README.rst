Personal dotfiles
=================

Reusable configuration files for geeks like me.

Already tested on Gentoo, Ubuntu and Debian servers. Works out of the box or inside the box.

Does not have dependencies!

Install
-------

Put all files to your home directory.

For g33ks this should sound better::

    git clone --bare https://github.com/ReekenX/dotfiles-home ~/.git
    git config core.bare false
    git checkout -f master

What you can find here
----------------------

Fixed history for `bpython`.

Properly structured `git` configs without any fancy 3rdparty tools.

Python `pip` tool will cache stuff so repeated installs will go much faster.

Some very basic `rst2pdf` config with improved readability.

Automatic envs creating templates with `tmuxinator` for various projects.

Tons of configuration for `vim` including themes, plugins and etc. Be sure to install plugins with `:PlugInstall`.

Shared history between `bash` and `zsh`.

Nice theme for `dreampie`.

Support for `nvim` with symlinks. Yes, `nvim` is very nice!

Simple `tmux` configuration with nice theme.

GIT tool called `tig` for nice browsing of repos in terminal.

Hardcoded stuff
---------------

I was unable to make bootstrap from this, but it will be easy enough to fix it. Just check two files `.gitconfig` for name and e-mail and the same for `.hgrc`.

License
-------

You are free to `fork`, modify and do amazing stuff. Please keep me in touch me with your improvements, I am always interested to see how this can be improved. Thanks.

Bugs
----

This project has no bugs. But you can file requests or to discuss something.

You can leave a comment in: https://github.com/ReekenX/dotfiles-home/issues/new
