#!/bin/bash
if [ -n "$1" ]; then

  FIRSTFILE=$1
  #echo $!
  GITDIR=$(dirname ${FIRSTFILE})
  #echo $GITDIR
  cd $GITDIR
  DATETIME=`date +%Y%m%d\ %H:%M:%S`
  #echo $DATETIME
  #git pull
  RESULT=`git commit $* -m "Autosave at $DATETIME"`
  echo $RESULT
  #zenity --info --text=$RESULT
  #echo $?
  #echo "git commit $* -m 'Autosave at $DATETIME'"
  git push

else
  echo "Provide one or more file paths to autosave"
  zenity --error --text="Provide one or more file paths to autosave"
fi
