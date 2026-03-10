#!/bin/sh
pidof swaylock && exit
grim -t ppm - | \
magick - -scale 75% -blur 0x4 -fill black -colorize 25% -scale 133.33% -quality 90 /tmp/lockscreen.jpg && \
swaylock -f --config ~/.config/sway/lock_idle/swaylock.conf --image /tmp/lockscreen.jpg
