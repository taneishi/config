# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=$HOME/.histfile
HISTSIZE=100000
HISTFILESIZE=100000
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PS1='[\[\033[01;32m\]\h\[\033[00m\]]\$ '
PROMPT_COMMAND='if [ $TERM == "screen" ]; then printf "\ek${PWD/$HOME/~}\e\\"; fi'

if [ -f ~/config/alias ]; then
    . ~/config/alias
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# environment variables
PATH=/usr/sbin:/usr/bin:/usr/local/bin:/sbin:/bin
if [ -d $HOME/.local/bin ]; then PATH=$HOME/.local/bin:$PATH; fi
export PATH
export EDITOR="vim -u ~/config/vimrc"

export CUDA_ROOT=/usr/local/cuda
export LD_LIBRARY_PATH=$CUDA_ROOT/lib64
export CPATH=$CUDA_ROOT/include
export PATH=$CUDA_ROOT/bin:$PATH

if [ -d $HOME/miniconda3 ]; then 
    export PATH=$HOME/miniconda3/bin:$PATH
    export PYTHONSTARTUP=$HOME/config/startup.py
fi

if [ -e $HOME/intel/bin/compilervars.sh ]; then
    source $HOME/intel/bin/compilervars.sh intel64
fi

function _expand(){ return 0; }

unset command_not_found_handle
