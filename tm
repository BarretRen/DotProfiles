#!/bin/sh
##
## name     : tm, tmux environment made easy
## author   : Barret Ren <barrret.ren@outlook.com>
## license  : GPL
## created  : 2012 Jul 01
## modified : 2020 Sep 02
##
if [ $# -ne 1 ]; then
    echo "you must input 1 tmux session name"
    exit 1
fi

# cmd=$(which tmux) # tmux path
alias cmd='~/.local/bin/tmux -u'
session=$1   # session name from input

if [ -z cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

# list all tmux session
if [ $session = "ls" ]; then
    cmd ls
    exit 0
fi

cmd has -t $session 2> /dev/null

if [ $? -ne 0 ]; then
    cmd new -s $session -d -n Vim
    cmd neww -t $session -d -n Build
    #cmd neww -t $session -d -n Lab
    cmd selectw -t $session:1
fi

stty sane
cmd att -t $session

exit 0
