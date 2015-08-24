PATH=$PATH:~/bin

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
#alias medusa='ssh medusa -o LocalCommand="tmux attach"'
alias medusa='ssh medusa -t "tmux attach"'

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

alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gl='git log'
alias gst='git status'
alias gt='git tag|less'
alias gp='git push --all --follow-tags'
alias gu='git pull --all'
# git activity per week day:
# git log --pretty='%at' | while read d; do date -d "@$d"; done | awk '{print $1}' | sort | uniq -c
alias gad='git log --pretty='"'"'%at'"'"' | while read d; do date -d "@$d"; done | awk '"'"'{print $1}'"'"' | sort | uniq -c'
# git activity per hour of the day:
# git log --pretty='%at'  | while read d; do date +%H -d "@$d"; done | sort | uniq -c
alias gah='git log --pretty='"'"'%at'"'"'  | while read d; do date +%H -d "@$d"; done | sort | uniq -c'

# mercurial coloured diff
alias hgd='hg diff | colordiff -y | less -R'
# some more shorthands
alias hgl='hg log | less'
alias hgb='hg branch'
alias hgt='hg tags | less'
alias hgu='hg pull -u'
alias hgp='hg push'

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
alias dcpsrc='cd ~/development/current/content-library/src/content_library/; . ~/development/env/bin/activate'
alias dcpcelery='python manage.py celery worker -Q celery -l info'

# update/install Calibre ebook manager
alias updatecalibre='sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('"'"'Download failed\n'"'"'); exec(sys.stdin.read()); main()"'

# Watch a DNS entry, see when it changes to a new value for example
alias checkdns='watch -n1 dig '

#weather(){ curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<YOURZIPORLOCATION>}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';}
weather(){ curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-Amsterdam}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';}

# if you're really annoyed with a runaway process
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
