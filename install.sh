#!/bin/sh
# inspired by rrix' dotfiles

install_hg()
{
break
    # Mercurial extensions
    touch ~/.dot_has_hg
    HGDIR=~/workspace/application_addons/mercurial
    mkdir -p $HGDIR
    cd $HGDIR

    for REPO in Mekk/mercurial_keyring sjl/hg-prompt durin42/hg-git yujiewu/hgflow
    do
        REPODIR="${REPO##*/}"
        echo $REPODIR
        if [ ! -d "$HGDIR/$REPODIR" ]; then
            hg clone http://bitbucket.org/$REPO
            #echo  http://bitbucket.org/$REPO
        else
            cd $HGDIR/$REPODIR
            #echo $HGDIR/$REPODIR
            hg pull -u
        fi
    done
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

echo "INFO: Init submodules"
git submodule init

echo "INFO: Update submodules"
git submodule update

if [ ! -d "~/.vim/bundle/Vundle.vim" ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    cd ~/.vim/bundle/Vundle.vim
    git pull
    cd
fi

echo "INFO: Vundle Install"
vim +BundleInstall +qall

echo "Do you wish to install mercurial stuff?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_hg; break;;
        No ) break;;
    esac
done

echo "Is this machine a server?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) touch ~/.dot_is_server; break;;
        No ) break;;
    esac
done
