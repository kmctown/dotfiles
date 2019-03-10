#!/bin/sh

if test $(which brew)
then
    brew install tmux
    brew install reattach-to-user-namespace
fi
