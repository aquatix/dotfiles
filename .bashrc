# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Default editor is vim
export EDITOR='vim'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# http://stackoverflow.com/questions/4023830/bash-how-compare-two-strings-in-version-format
# returns 0 if =, 1 if >, 2 if <
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

# check version of git; it supports 'simple' from 1.7.11 up, fall back to 'matching'
vercomp "1.7.11" `git --version|awk '{ print $3 }'`
if [ $? -eq 1 ]; then
    git config --global push.default matching
    git config --global pull.default matching
fi

hg_ps1() {
    #hg prompt "{ on {branch}}{ at {bookmark}}{status}" 2> /dev/null
    hg prompt " \[\033[1;37m\]hg\[\033[0m\] {branch}{status}" 2> /dev/null
}

set_bash_prompt(){
    # Michiel's colour config
    BLACK="\[\033[0m\]"
    BLUE="\[\033[0;34m\]"
    YELLOW="\[\033[0;33m\]"
    GREEN="\[\033[0;32m\]"
    RED="\[\033[0;31m\]"
    PROMPT_SYMBOL='$'
    if [ $USER = 'root' ]; then
        #PS1="$YELLOW\t $RED\u$BLACK@\h:\W# "
        PS1="${debian_chroot:+($debian_chroot)}$(venvinfo)$YELLOW\t $RED\u$BLACK@\h:\W$(jobscount)# "
    elif [ -e ~/.dot_is_server ]; then
        #PS1="$YELLOW\t $GREEN\u$BLACK@\h:\W$ "
        PS1="${debian_chroot:+($debian_chroot)}$(venvinfo)$YELLOW\t $GREEN\u$BLACK@\h:\W$(jobscount)$ "
    else
        #PS1="$YELLOW\t $BLUE\u$BLACK@\h:\W$ "
        PS1="${debian_chroot:+($debian_chroot)}$(venvinfo)$YELLOW\t $BLUE\u$BLACK@\h:\W$(jobscount)$ "
    fi
    #PS1="$YELLOW\t $BLUE\u$BLACK@\h:\W$(hg_ps1)$ "
    #PS1="$YELLOW\t $BLUE\u$BLACK@\h:\W$(hg_ps1)$(__git_ps1)$ "
    # /Michiel's colour config
}

jobscount() {
    # Show amount of running and stopped (backgrounded) jobs
    local stopped=$(jobs -sp | wc -l)
    local running=$(jobs -rp | wc -l)
    ((running+stopped)) && echo -n "[${running}r/${stopped}s]"
}

venvinfo() {
    # Virtualenv information
    if [ "`basename \"$VIRTUAL_ENV\"`" = "__" ] ; then
        # special case for Aspen magic directories
        # see http://www.zetadev.com/software/aspen/
        echo "[`basename \`dirname \"$VIRTUAL_ENV\"\``] "
    elif [ "$VIRTUAL_ENV" != "" ]; then
        echo "(`basename \"$VIRTUAL_ENV\"`) "
    fi
}

# gitprompt configuration
# Set config variables first
#GIT_PROMPT_ONLY_IN_REPO=1

# as last entry source the gitprompt script
#source ~/workspace/application_addons/git/bash-git-prompt/gitprompt.sh

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PROMPT_COMMAND=set_bash_prompt
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/bin/tmuxinator.bash ]; then
    . ~/bin/tmuxinator.bash
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# If the private dotfiles repo is installed, we'd like to use its scripts too
if [ -x ~/.dot/privdotfiles/bin ]; then
    PATH=$PATH:~/.dot/privdotfiles/bin
fi

# Android-related binaries
PATH=$PATH:/usr/local/bin/android-sdk-linux/platform-tools:/usr/local/bin/android-sdk-linux/tools
