PATH=$PATH:~/bin

alias ls='ls --color=auto'
alias ll='ls -la'

# append history instead of overwriting:
shopt -s histappend

alias findphp='find . -name "*.php" | xargs grep'
alias findjs='find . -name "*.js" | xargs grep'
alias findcss='find . -name "*.css" | xargs grep'
alias findpy='find . -name "*.py" | xargs grep'

alias findfile='find . | grep -v .svn | grep -v .hg | grep -v .git | grep'

alias notes='vim ~/mydocs/notes/notes.txt'

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

# 20140521 force 256 colours in tmux
alias tmux='tmux -2'

# 20140715 you can connect to your session normally, and if you are bothered by
# another session that forced down your tmux window size you can simply call
alias takeover="tmux detach -a"

# 20140825 as there is no `pip upgrade`, this has to do
alias pip_upgrade="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

# 20140908 reload tmux config
alias tmux_reload="tmux source-file ~/.tmux.conf"

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
