#!/bin/sh
set -e
xset dpms 5 5 5
i3lock --blur 5 --nofork --ignore-empty-password
xset s off -dpms
