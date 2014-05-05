#!/bin/sh
# inspired by rrix' dotfiles

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

echo "INFO: Init submodules"
git submodule init

echo "INFO: Update submodules"
git submodule update

echo "INFO: Vundle Install"
vim +BundleInstall +qall
