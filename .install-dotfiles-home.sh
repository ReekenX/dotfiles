#!/bin/bash

# Go home!
cd ~

# These "just for fun"
echo "Checking operating system..."
sleep 0.3
echo "Checking file system..."
sleep 0.4
echo "Checking connected hardware..."
sleep 0.4
echo "Checking memory and disk space..."
sleep 0.2

# Real work here
echo "Downloading repository and required files..."
git clone --quiet --bare https://github.com/ReekenX/dotfiles-home ~/.git
echo "Performing required configuration for GIT..."
git config core.bare false
echo "Applying files to your home dir..."
git checkout --quiet -f master
echo "Downloading VIM plugins..."
git submodule --quiet init
git submodule --quiet update
echo "Done."
