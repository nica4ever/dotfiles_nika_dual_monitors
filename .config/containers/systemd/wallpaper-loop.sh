#!/bin/sh

# Reads output names from mounted sway config.
# First output = landscape (crop), second output = portrait (fit).
# One output = crop. Beyond two outputs, good luck.
# ImageMagick sharpens and boosts saturation before passing to swww.
# Portrait monitor gets upscaled for cleaner fit scaling.
OUTPUT1=$(grep '^output ' /config/sway-config | awk '{print $2}' | sort -u | sed -n '1p')
OUTPUT2=$(grep '^output ' /config/sway-config | awk '{print $2}' | sort -u | sed -n '2p')

until [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; do
  sleep 1
done
swww-daemon &
sleep 1

while true; do
  if ! pidof swaylock > /dev/null 2>&1; then
    WALL="$(find /wallpapers -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp' \) | shuf -n 1)"
    PROCESSED="/tmp/wall.png"
    magick "$WALL" -sharpen 0x0.5 -modulate 100,110,100 -quality 95 "$PROCESSED"
    swww img -o "$OUTPUT1" "$PROCESSED" \
      --resize crop \
      --filter Lanczos3 \
      --transition-type fade \
      --transition-duration 3 \
      --transition-fps 60 \
      --transition-bezier .42,0,.58,1
    if [ -n "$OUTPUT2" ]; then
      PORTRAIT="/tmp/wall_portrait.png"
      magick "$PROCESSED" -resize 200% -filter Lanczos "$PORTRAIT"
      swww img -o "$OUTPUT2" "$PORTRAIT" \
        --resize fit \
        --filter Lanczos3 \
        --transition-type fade \
        --transition-duration 3 \
        --transition-fps 60 \
        --transition-bezier .42,0,.58,1
    fi
  fi
  sleep 600
done
