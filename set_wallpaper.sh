#!/usr/bin/env bash

wallpaper=$(ls ~/walls | dmenu -i -l 15)
[ -z "$wallpaper" ] || feh --bg-fill "/home/krish/walls/$wallpaper"

