=================================
Linux Desktop configuration files
=================================

:Author: Remigijus Jarmalavicius <remigijus(a)jarmalavicius(dot)lt>

Short history
-------------

Two years on Ubuntu. Half year on Kubuntu. Half year on Debian. Only operating
system has changed, nothing more. There was a reasons why I was switching to
other operating systems, but this section not about that.

Since it is hard to change software like VIM, GIT or SCREEN and move to better
alternatives. You know, that there is no better alternatives.

I am using this folder everywhere I can:

* On my single work/home laptop.
* On Debian server.
* On Centos server.
* On Ubuntu server.

Since most of these configuration files are for console programs, so they will
work fine anywhere. More about programs and they configurations read below.

All my configurations comes under GPL, so use it free, modify as you like.

VIM as greatest editor ever!
----------------------------

Yep, this is not secret. I haven't tried Emacs, sorry.

Vim configuration, like other ones, includes many helping functions for development:
showing numbers, folding, smart search, history, backups, word wrapping. But there
is one very very special thing: when you install this config you will be unable to
move in file with left/right and up/down buttons. Use hjkl instead!

VIM Bundle holds plugins::

    pyfales        # Useful for Python/Django development
    vim-rename2    # Useful for renaming current file with :Rename new_file_name.txt
    BufExplorer    # Full lis of currently editing files with <F3> button
    nerdcommenter  # Easily comment/uncomment code or text blocks
    snipmate       # Hundreds of snippets. Try fixme<tab>
    surround       # Surround code with HTML tags or simple quotes (or other symbol)
    vimoutliner    # Greatest TODO list ever created

As you may see in my .vim/bundle folder there are more than these plugins. Well,
if they are there and they are not listed above - that means I am just testing
these plugins and you might not need them.

GIT and Mercurial
-----------------

We all know, that GIT is better than... Every other versioning system.

GIT configuration includes improved GIT DIFF with ``git df`` and GIT LOG
with ``git lg``. Try them, I think you will be thankful for me.

Mercurial has also hundreds of installed extensions. I like HG LOG I have improved.
Plugins like COLORS or PAGER are the best Mercurial plugins ever created, in my
opinion.

Screen
------

I don't like Gnome-terminal or Konsole tab's. They are heavy. Screen is fast,
but it's too hard to configure it. So this configuration file is really simple.

It includes 256 colors support. And of course I love that I can turn off my
terminal and return later to Screen window I have left before.

ZSH
---

ZSH without OH MY ZSH is not ZSH.

There are two things developed by me: ReekenX theme I like a lot and backup function,
which works like that::

    backup file_name

It will rename file to filename.20111204.bak.

Buildout
--------

Well, I don't really like Buildout system, but I am using it. So be careful to
find out that this hidden directory contains my hardcoded path's. You should be
thankful to buildout bug's for that.
