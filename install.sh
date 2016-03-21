#!/bin/bash
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

install_fish()
{
    touch ~/.dot/.dot_has_fish
    mkdir -p "${HOME}/.config/fish/completions"
    curl -sL get.fisherman.sh | fish
    ln -s "${HOME}/workspace/application_addons/cli/git-flow-completion/git.fish" "${HOME}/.config/fish/completions"
    ln -s "${HOME}/workspace/application_addons/cli/tmuxinator/completion/tmuxinator.fish" "${HOME}/.config/fish/completions"
}

# Get the directory the dotfiles have been cloned into
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Installing from $DIR"
DATETIME=$(date +%Y%m%d_%H%M)

# Go home
cd

# Symlink all the things
for TARGET in .bash_aliases .bashrc bin .gitconfig .gitmodules .hgauthors.txt .hgignore .hgrc .screenrc .terminfo .tmux.conf .vim .vimrc install.sh
do
  cd
  echo $TARGET
  if [ "$(readlink $TARGET)" = "$DIR/$TARGET" ]; then
      echo "  symlink exists and is fine, skipping"
      continue
  elif [ -e $TARGET ] || [ -L $TARGET ] && [ "$(readlink $TARGET)" != "$DIR/$TARGET" ]; then
      echo "  exists, moving out of the way"
      if [ ! -d "workspace/backup/dotfiles_$DATETIME" ]; then
          mkdir -p "workspace/backup/dotfiles_$DATETIME"
      fi
      DIRNAME=$(dirname ${TARGET})
      if [ "$DIRNAME" != "." ]; then
          mkdir "workspace/backup/dotfiles_$DATETIME/$DIRNAME"
          mv $TARGET "workspace/backup/dotfiles_$DATETIME/$DIRNAME"
          #echo "workspace/backup/privdotfiles_$DATETIME/$DIRNAME"
      else
          mv $TARGET "workspace/backup/dotfiles_$DATETIME/"
          #echo "workspace/backup/privdotfiles_$DATETIME/${TARGET}"
      fi
  fi

  # If link is in a subdir, go there
  DIRNAME=$(dirname ${TARGET})
  if [ "$DIRNAME" != "." ]; then
      cd "$DIRNAME"
  fi
  # Create the symlink
  ln -s "$DIR/$TARGET"
  #echo "ln -s $DIR/$TARGET"
done

echo "INFO: Init submodules"
git submodule init

echo "INFO: Update submodules"
git submodule update

if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then
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
