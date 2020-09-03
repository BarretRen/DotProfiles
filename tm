#!/bin/zsh
##
## name     : tmuxen, tmux environment made easy
## author   : Xu Xiaodong <xxdlhy@gmail.com>
##            Barret Ren <barrret.ren@outlook.com>
## license  : GPL
## created  : 2012 Jul 01
## modified : 2020 Sep 02
##

if [ $# -ne 1 ]; then
    echo "you must input 1 tmux session name"
    exit 1
fi
#cmd=$(which tmux) # tmux path
cmd='/home/barretr/tools/Tmux/bin/tmux'
session=$1   # session name from input

if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

$cmd has -t $session 2> /dev/null

if [ $? -ne 0 ]; then
    stty sane
    $cmd new -s $session -d -n Code
    $cmd neww -t $session -d -n Build
    $cmd neww -t $session -d -n Lab
    # $cmd neww -t $session -d -n Octopus
    $cmd selectw -t $session:1
fi

stty sane
$cmd att -t $session

exit 0
