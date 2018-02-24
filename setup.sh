#!/bin/bash -x
current=$(cd $(dirname "$0") && pwd)
ln -s "$current/.tmux.conf" ~/.tmux.conf
