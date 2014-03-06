#!/bin/bash

cd
git clone --bare https://github.com/ReekenX/dotfiles-home ~/.git
git config core.bare false
git checkout -f master
git submodule init
git submodule update
cd -
echo "Done."
