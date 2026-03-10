#!/bin/sh
pidof swaylock && exit

IMAGES=""
for output in $(swaymsg -t get_outputs -r | grep -o '"name": "[^"]*"' | cut -d'"' -f4); do
  grim -t ppm -o "$output" - | \
    magick - -scale 75% -blur 0x4 -fill black -colorize 25% -scale 133.33% -quality 90 "/tmp/lock_${output}.jpg"
  IMAGES="$IMAGES -i ${output}:/tmp/lock_${output}.jpg"
done

swaylock -f --config ~/.config/sway/lock_idle/swaylock.conf $IMAGES
