PATH=$PATH:~/bin

# http://stackoverflow.com/questions/4023830/bash-how-compare-two-strings-in-version-format
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

# check version of git
vercomp "1.7.11" `git --version|awk '{ print $3 }'`
case $? in
    0) op='=';;
    1) git config --global push.default matching; git config --global pull.default matching ;; # op='>';;
    2) op='<';;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lll='ls --color=always -alF | less -R'

# append history instead of overwriting:
shopt -s histappend

alias findphp='find . -name "*.php" | xargs grep'
alias findjs='find . -name "*.js" | xargs grep'
alias findcss='find . -name "*.css" | xargs grep'
alias findpy='find . -name "*.py" | xargs grep'

alias findfile='find . | grep -v .svn | grep -v .hg | grep -v .git | grep'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias notes='vim ~/mydocs/notes/notes.txt'

# 20141202
alias captainslog='vim ~/mydocs/notes/captains_log.md'

# Some hosts
alias higgs='ssh higgs'
alias medusa='ssh medusa'

# 20120714
alias gm='gnome-mplayer'

# 20131124
alias fucking='sudo'

# 20140110
alias such=git
alias very=git
alias wow='git status'
alias so=git
# wow
# such commit
# very push
# so rebase
# so diff

alias hgd='hg diff | colordiff -y | less -R'

# 20140521 force 256 colours in tmux
alias tmux='tmux -2'

# 20140715 you can connect to your session normally, and if you are bothered by
# another session that forced down your tmux window size you can simply call
alias takeover="tmux detach -a"

# 20140825 as there is no `pip upgrade`, this has to do
alias pip_upgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

# 20140908 reload tmux config
alias tmux_reload="tmux source-file ~/.tmux.conf"

# project-oriented aliases
alias dcpvag='workon dcp; cd ~/workspace/sanoma/content-library/; vagrant ssh'
alias dcpsrc='cd development/current/content-library/src/content_library/; . ~/development/env/bin/activate'

function fuck() {
  if killall -9 "$2"; then
    echo ; echo " (╯°□°）╯︵$(echo "$2"|toilet -f term -F rotate)"; echo
  fi
}

# 20140614 wrapper around bpython to load the virtualenv's python path
bpython() {
  if test -n "$VIRTUAL_ENV"
  then
    PYTHONPATH="$(python -c 'import sys; print ":".join(sys.path)')" \
    command bpython "$@"
  else
    command bpython "$@"
  fi
}
