#!/bin/sh
# inspired by rrix' dotfiles

install_hg()
{
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

# Get the directory the dotfiles have been cloned into
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Installing from $DIR"
DATETIME=`date +%Y%m%d_%H%M`

# Go home
cd

# Symlink all the things
for TARGET
  in .bash_aliases .bashrc bin .gitconfig .gitmodules .hgauthors.txt .hgignore .hgrc .screenrc .terminfo .tmux.conf .vim .vimrc
do
  echo $TARGET
  if [ -L $TARGET ]; then
      echo "symlink exists, skipping"
  elif [ -e $TARGET ]; then
	  echo "exists, moving"
      if [ ! -d "workspace/backup/$DATETIME" ]; then
          mkdir -p "workspace/backup/$DATETIME"
      fi
	  #mv $TARGET "workspace/backup/$DATETIME/${TARGET}"
	  echo "workspace/backup/$DATETIME/${TARGET}"
  fi
  #ln -s
  #ln -s $DIR/$TARGET
  echo "ln -s $DIR/$TARGET"
done
# Test
exit 1

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

if [ -e ~/.dot_has_hg ]; then
    install_hg
elif [ ! -e ~/.dot_no_hg ]; then
    echo
    echo "Do you wish to install mercurial stuff?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) install_hg; break;;
            No ) touch ~/.dot_no_hg; break;;
        esac
    done
fi

if [ ! -e ~/.dot_is_server ] && [ ! -e ~/.dot_no_server ]; then
    echo
    echo "Is this machine a server?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) touch ~/.dot_is_server; break;;
            No ) touch ~/.dot_no_server; break;;
        esac
    done
fi
