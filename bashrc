# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


export PS1="\[\e[01;31m\]\u\[\e[m\]@\[\e[01;32m\]\h\[\e[m\]:\[\e[01;34m\]\W\[\e[m\]\[\e[36m\]\\$\[\e[m\] "

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias memuse='watch -t -n 1 free -mh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# User preference
function python-docker() {
                xhost +local:docker
                docker run -it --rm \
                           --runtime nvidia \
                           -v $(pwd):/workspace/workdir \
                           -v ~/Documents/Gamaya/DeepLearning:/workspace/code \
                           -v /media/NAS/:/media/NAS \
                           -v /media/satdata:/media/satdata \
                           -v /tmp/.X11-unix:/tmp/.X11-unix \
                           -e DISPLAY=$DISPLAY \
                           -e PYTHONPATH=/workspace/code \
                           -e ORB_ENV=$ORB_ENV \
                           --workdir=/workspace/workdir \
                           --user 1000:1000 \
                           gamayarepository.azurecr.io/core-cpu-dev python3 $@
                 xhost -local:docker
}

function ipython-docker() {
                 xhost +local:docker
                 docker run -it --rm \
                           --runtime nvidia \
                           -v $(pwd):/workspace/workdir \
                           -v ~/Documents/Gamaya/DeepLearning:/workspace/code \
                           -v /media/hyperdata:/media/hyperdata \
                           -v /media/DataScience:/media/DataScience \
                           -v /media/satdata:/media/satdata \
                           -v /tmp/.X11-unix:/tmp/.X11-unix \
                           -v ~/.ipython:/home/gamaya/.ipython \
                           -e DISPLAY=$DISPLAY \
                           -e PYTHONPATH=/workspace/code \
                           -e ORB_ENV=$ORB_ENV \
                           --workdir=/workspace/workdir \
                           --user 1000:1000 \
                           gamayarepository.azurecr.io/core-cpu-dev:with_planet ipython
                 xhost +local:docker
}

function pytest-docker() {
                xhost +local:docker
                docker run -it --rm \
                           -v $(pwd):/workspace/workdir \
                           -v ~/Documents/Gamaya/DeepLearning:/workspace/code \
                           -v /media/hyperdata:/media/hyperdata \
                           -v /media/DataScience:/media/DataScience \
                           -v $HOME/Documents/Gamaya/Dev/satdata:/media/satdata \
                           -v /media/soft/Testing/ds:/workspace/testingdata \
                           -v /tmp/.X11-unix:/tmp/.X11-unix \
                           -e DISPLAY=$DISPLAY \
                           --workdir=/workspace/workdir \
                           -e ORB_ENV=$ORB_ENV \
                           -e PYTHONPATH=/workspace/code \
                           -e ORB_ENV=pre-prod \
                           gamayarepository.azurecr.io/core-cpu-dev:latest pytest $@
                 xhost -local:docker
}

function jupyter-docker() {
                docker run -it --rm \
                           --hostname=localhost -p 127.0.0.1:8888:8888 \
                           -v $(pwd):/workspace/workdir \
                           -v ~/Documents/Gamaya/DeepLearning:/workspace/code \
                           -v /media/hyperdata:/media/hyperdata \
                           -v /media/DataScience:/media/DataScience \
                           -v $HOME/Documents/Gamaya/Dev/satdata:/media/satdata \
                           --workdir=/workspace/workdir \
                           -e ORB_ENV=$ORB_ENV \
                           -e PYTHONPATH=/workspace/code \
                           -e ORB_ENV=prod \
                           gamayarepository.azurecr.io/core-cpu-dev jupyter notebook \
                                --ip=0.0.0.0 --allow-root
}
function gamaya-docker() {
                xhost +local:docker
                docker run -it --rm --hostname=localhost -p 127.0.0.1:8888:8888 \
                           -v $(pwd):/workspace/workdir \
                           -v ~/Documents/Gamaya/DeepLearning:/workspace/code \
                           -v /media/hyperdata:/media/hyperdata \
                           -v /media/DataScience:/media/DataScience \
                           -v $HOME/Documents/Gamaya/Dev/satdata:/media/satdata \
                           -v /media/soft/Testing/ds:/workspace/testingdata \
                           -v /tmp/.X11-unix:/tmp/.X11-unix \
                           -e ORB_ENV='prod-local' \
                           -e PYTHONPATH=/workspace/code \
                           -e DISPLAY=$DISPLAY \
                           -e PL_API_KEY=$PL_API_KEY \
                           --workdir=/workspace/workdir \
                           --user 1000:1000 \
                           gamayarepository.azurecr.io/core-cpu-dev:latest
                xhost -local:docker
              }

alias vim=nvim

# correct colors for gruvbox theme
# /home/mkinet/.config/nvim/colors/gruvbox_256palette.sh

export NVIDIA_TOKEN=OWQ1ajQzcGczc3V1N285M2F0aTcxZGljN3E6MmQ0OGJhMGYtNjFlYy00Yzk5LWFlYTEtYmNjODBiNThiMTg2
# Activate vi mode
set -o vi


# start a tmux session in each terminal
# if [[ ! $TERM =~ screen ]]; then
#       exec tmux
# fi

# export PYTHONPATH=/home/mkinet/Documents/Gamaya/DeepLearning

# Activate python3 virtualenv
# export VIRTUAL_ENV_DISABLE_PROMPT=1
source ~/Developer/virtualenv/python3/bin/activate

