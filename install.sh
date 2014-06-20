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

# Mercurial extensions
mkdir -p ~/workspace/application_addons/mercurial
cd ~/workspace/application_addons/mercurial
hg clone http://bitbucket.org/Mekk/mercurial_keyring
hg clone http://bitbucket.org/sjl/hg-prompt
hg clone hg clone http://bitbucket.org/durin42/hg-git
hg clone http://bitbucket.org/yujiewu/hgflow
