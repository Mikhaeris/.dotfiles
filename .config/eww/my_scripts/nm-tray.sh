#!/usr/bin/env zsh

if pgrep -x "nm-applet" > /dev/null; then
    pkill -x "nm-applet"
else
    nm-applet &
fi
