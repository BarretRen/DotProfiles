#!/bin/zsh
#
# name     : tmuxen， tmux environment made easy
# author   : Xu Xiaodong xxdlhy@gmail.com
# license  : GPL
# created  : 2012 Jul 01
# modified : 2012 Jul 02
#

#cmd=$(which tmux) # tmux path
cmd='/home/barretr/tools/tmuxN/bin/tmux'
session=fuckinglife   # session name

if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

$cmd has -t $session

if [ $? != 0 ]; then
    stty sane
    $cmd new -s $session -d -n Build
    $cmd neww -t $session -d -n Fdt
    $cmd neww -t $session -d -n Lab
    $cmd selectw -t $session:1
fi

$cmd att -t $session

exit 0
