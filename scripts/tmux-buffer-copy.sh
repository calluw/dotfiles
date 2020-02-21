#!/bin/bash
set -e
set -x

SERVER=$1

if [[ -n $SERVER ]]; then
    scp $SERVER:~/.tmux-buffer ~/.tmux-buffer
    cat ~/.tmux-buffer | xsel -i
else
    echo "Failed: didn't specify server to copy from"
fi

