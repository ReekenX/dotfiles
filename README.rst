=========================
Linux configuration files
=========================

:Author: Remigijus Jarmalavicius <remigijus(a)jarmalavicius(dot)lt>

Short history
-------------

I love Linux!

I am using Linux operating systems for years. Tried Ubuntu, Kubuntu, Mint,
Debian and currently working on Gentoo. I am web/software developer, so
for me it huge advantage to have platform I can quickly install and start
working on. This is why this repository is born.

I am using this folder everywhere I can:

* On my single work/home laptop.
* On Debian servers.
* On Centos servers.
* On Ubuntu servers.

Since most of these configuration files are for console programs, so they will
work fine anywhere. More about programs and they configurations - below.

All my configurations comes under GPL, so use it free, modify as you like.

VIM as greatest editor ever!
----------------------------

Yep, this is not secret. I haven't tried Emacs/Textmate, sorry.

Vim configuration, like other ones, includes many helping functions for development:
showing numbers, folding, smart search, history, backups, word wrapping. But there
is one very very special thing: when you install this config you will be unable to
move in file with left/right and up/down buttons. Use hjkl instead!

VIM Bundle holds plugins::

    pyflakes       # Useful for Python/Django development
    vim-rename2    # Useful for renaming current file with :Rename new_file_name.txt
    BufExplorer    # Full list of currently editing files with <F3> button
    snipmate       # Hundreds of snippets
    surround       # Surround code with HTML tags or simple quotes (or other symbol)
    vimoutliner    # Greatest TODO list ever created

As you may see in my .vim/bundle folder there are more than these plugins. Well,
if they are there and they are not listed above - that means I am just testing
these plugins and you might not need them.

GIT and Mercurial
-----------------

We all know, that GIT is better than... Every other versioning systems.

GIT configuration includes improved GIT DIFF with ``git df`` and GIT LOG
with ``git lg``. Try them, I think you will be thankful for me.

Mercurial has also hundreds of installed extensions. I like HG LOG I have improved.
Plugins like COLORS or PAGER are the best Mercurial plugins ever created, in my
opinion.

Screen/Tmux
-----------

I don't like Gnome-terminal or Konsole tab's. They are heavy. Screen is fast,
but it's too hard to configure it. So this configuration file is really simple.

On my personal computer I am working with `tmux` of course, but in servers, when
I don't have ability to install my own software - `screen` is always there.

Buildout
--------

Well, I don't really like Buildout system, but I am using it. So be careful to
find out that this hidden directory contains my hardcoded path's. You should be
thankful to buildout bug's for that. buildout--
