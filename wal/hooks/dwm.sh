#!/usr/bin/env bash
# Hook for pywal16 to update dwm/dwmblocks colors
xrdb -merge ~/.cache/wal/colors.Xresources

# Generate custom dwm.* color keys
cat <<EOF | xrdb -merge -
dwm.col_gray1:  $(xrdb -query | awk '/\*\.color0:/ {print $2}')
dwm.col_gray2:  $(xrdb -query | awk '/\*\.color8:/ {print $2}')
dwm.col_gray3:  $(xrdb -query | awk '/\*\.color2:/ {print $2}')
dwm.col_gray4:  $(xrdb -query | awk '/\*\.color15:/ {print $2}')
dwm.col_cyan:   $(xrdb -query | awk '/\*\.color6:/ {print $2}')
dwm.col_fg:     $(xrdb -query | awk '/\*\.color7:/ {print $2}')
dwm.col_bg:     $(xrdb -query | awk '/\*\.color0:/ {print $2}')
dwm.col_border: $(xrdb -query | awk '/\*\.color1:/ {print $2}')
dwm.col_fade:   $(xrdb -query | awk '/\*\.color8:/ {print $2}')
dwm.col_tag:    $(xrdb -query | awk '/\*\.color3:/ {print $2}')
EOF

pkill dunst && setsid dunst &
xrdb -merge ~/.cache/wal/colors-wal-dmenu.Xresources
xdotool key 133+71 
# Restart dwmblocks so it reloads the new colors
notify-send "wallpaper and colorscheme changed"
