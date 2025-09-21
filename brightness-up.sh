#!/bin/sh

BRIGHT="/sys/class/backlight/amdgpu_bl0/brightness"
MAX=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)
CUR=$(cat "$BRIGHT")
STEP=$((MAX / 20))
NEW=$((CUR + STEP))
[ $NEW -gt $MAX ] && NEW=$MAX
echo $NEW > "$BRIGHT"

