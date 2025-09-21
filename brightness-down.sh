#!/bin/sh

BRIGHT="/sys/class/backlight/amdgpu_bl0/brightness"
MAX=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)
CUR=$(cat $BRIGHT)
STEP=$((MAX / 20))
NEW=$((CUR - STEP))
[ $NEW -lt 0 ] && NEW=0
echo $NEW | sudo -n tee $BRIGHT > /dev/null

