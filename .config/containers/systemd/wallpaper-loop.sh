#!/bin/sh
OUTPUT1=$(grep '^output ' /config/sway-config | awk '{print $2}' | sort -u | sed -n '1p')
OUTPUT2=$(grep '^output ' /config/sway-config | awk '{print $2}' | sort -u | sed -n '2p')

until [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; do
  sleep 1
done

swww-daemon &
until swww query > /dev/null 2>&1; do sleep 0.1; done

if [ -f "$HOME/.cache/swww/wall.png" ]; then
  swww img -o "$OUTPUT1" "$HOME/.cache/swww/wall.png" --resize crop --filter Lanczos3 --transition-type none
  [ -n "$OUTPUT2" ] && swww img -o "$OUTPUT2" "$HOME/.cache/swww/wall_portrait.png" --resize fit --filter Lanczos3 --transition-type none
fi

while true; do
  if ! pidof swaylock > /dev/null 2>&1; then
    WALL="$(find /wallpapers -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp' \) | shuf -n 1)"
    PROCESSED="$HOME/.cache/swww/wall.png"
    magick "$WALL" -sharpen 0x0.5 -modulate 100,110,100 -quality 95 "$PROCESSED"

    swww img -o "$OUTPUT1" "$PROCESSED" \
      --resize crop \
      --filter Lanczos3 \
      --transition-type fade \
      --transition-duration 3 \
      --transition-fps 60 \
      --transition-bezier .42,0,.58,1

    if [ -n "$OUTPUT2" ]; then
      PORTRAIT="$HOME/.cache/swww/wall_portrait.png"
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
