# Set editor to vim
set EDITOR vim

# Virtualenv support with virtualfish
eval (python -m virtualfish compat_aliases)

# Theme options for bobthefish
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_date_format "+%a %Y-%m-%d %H:%M:%S"
set -g theme_avoid_ambiguous_glyphs yes
#set -g theme_color_scheme "zenburn"

# If you use virtualenv, you will probably need to disable the default virtualenv prompt, since it doesn't play nice with fish
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# grc colouriser
set -U grcplugin_ls --color

# PATH
if test -x ~/.dot/dotfiles/bin
    set PATH $PATH ~/.dot/dotfiles/bin
end
## If the private dotfiles repo is installed, we'd like to use its scripts too
if test -x ~/.dot/privdotfiles/bin
    set PATH $PATH ~/.dot/privdotfiles/bin
end

# If nvm is installed
if test -x ~/.nvm
    set -gx NVM_DIR ~/.nvm
end

## Android-related binaries
if test -x /usr/local/bin/android-sdk-linux/platform-tools
    set PATH $PATH /usr/local/bin/android-sdk-linux/platform-tools /usr/local/bin/android-sdk-linux/tools
end

# QT autoscaling, helpful for hidpi systems
set -x QT_AUTO_SCREEN_SCALE_FACTOR 1

# SilverSearcher 'ag' ('ack' and 'grep' replacement)
#set -gx FZF_DEFAULT_COMMAND 'ag -g ""'
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "$FZF_DEFAULT_COMMAND"

# Aliases
## Listing
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'
alias lll 'ls --color=always -alF | less -R'

## Git
alias gu "git pull --all"
alias gp "git push; git push --tags"
alias gpa "git push --all; git push --tags"
alias gc "git commit"
alias gca "git commit -a"
alias gd "git diff"
alias gst "git status"
alias ga "git add -A"
alias gl "git log"
alias gt 'git tag|less'
#alias gad 'git log --pretty='"'"'%at'"'"' | while read d; do date -d "@$d"; done | awk '"'"'{print $1}'"'"' | sort | uniq -c'

alias ffnightly 'env MOZ_USE_XINPUT2=1 /usr/local/bin/firefoxnightly/firefox'

## SSH, for compatibility, as our terminfo now is non-standard 'tmux-256color-italic' in tmux
alias ssh 'env TERM=xterm-256color ssh'

## Grepping
alias findfile 'find . | grep -v .svn | grep -v .hg | grep -v .git | grep'
alias findphp 'find . -name "*.php" | xargs grep --color=auto'
alias findjs 'find . -name "*.js" | xargs grep --color=auto'
alias findcss 'find . -name "*.css" | xargs grep --color=auto'
alias findhtml 'find . -name "*.html" | xargs grep --color=auto'
alias findpy 'find . -name "*.py" | xargs grep --color=auto'
alias findyaml 'find . -name "*.yaml" -o -name "*.yml" -o -name "*.eyaml" -o -name "*.eyml" | xargs grep --color=auto'
function grepl
    grep --color=always -ir $argv | less -R
end

## Various
alias tmux 'tmux -2'
alias tmux_reload "tmux source-file ~/.tmux.conf"
alias tmux_takeover "tmux detach -a"

alias mkvirtualenv3 "mkvirtualenv --python=`which python3`"
alias pip_upgrade "pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

alias pyloc 'find . -name "*.py" | xargs wc -l'

alias pypi_up 'python setup.py sdist --formats=zip upload -r pypi'
alias pypi_sanoma 'python setup.py sdist --formats=zip upload -r sanoma'

alias youtube-dl 'youtube-dl -t -f bestvideo+bestaudio/best --merge-output-format mp4'

alias weather 'ansiweather'
