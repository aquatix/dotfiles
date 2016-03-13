set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

# Virtualenv support with virtualfish
eval (python -m virtualfish)

# Theme options
set -g theme_show_exit_status yes

# Aliases
# Listing
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'
alias lll 'ls --color=always -alF | less -R'

# Git
alias gu "git pull --all"
alias gp "git push --all; git push --tags"
alias gc "git commit"
alias gca "git commit -a"
alias gd "git diff"
alias gst "git status"
alias gl "git log"
alias gt 'git tag|less'
#alias gad 'git log --pretty='"'"'%at'"'"' | while read d; do date -d "@$d"; done | awk '"'"'{print $1}'"'"' | sort | uniq -c'

# Grepping
alias findfile 'find . | grep -v .svn | grep -v .hg | grep -v .git | grep'
alias findphp 'find . -name "*.php" | xargs grep --color=auto'
alias findjs 'find . -name "*.js" | xargs grep --color=auto'
alias findcss 'find . -name "*.css" | xargs grep --color=auto'
alias findpy 'find . -name "*.py" | xargs grep --color=auto'
alias findyaml 'find . -name "*.yaml" -o -name "*.yml" -o -name "*.eyaml" -o -name "*.eyml" | xargs grep --color=auto'

# Various
alias tmux 'tmux -2'
alias tmux_reload "tmux source-file ~/.tmux.conf"
alias tmux_takeover "tmux detach -a"

alias mkvirtualenv3 "mkvirtualenv --python=`which python3`"
alias pip_upgrade "pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

alias pypi_up 'python setup.py register sdist --formats=zip upload'

alias weather 'ansiweather'