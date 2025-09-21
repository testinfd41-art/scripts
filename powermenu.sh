#!/bin/sh

# Options for the menu
OPTIONS=" Suspend\n Hibernate\n Reboot\n Shutdown"

# Show dmenu and get choice (bigger font, vertical list)
CHOICE=$(echo -e "$OPTIONS" | dmenu -i -p "Power Menu:" \
    -fn 'JetBrainsMono Nerd Font:size=20' \
    -l 4 \
    -nb '#222222' -nf '#eeeeee' -sb '#f5ea22' -sf '#222222'
)

case "$CHOICE" in
    " Suspend")
        loginctl suspend
        ;;
    " Hibernate")
        loginctl hibernate
        ;;
    " Reboot")
        loginctl reboot
        ;;
    " Shutdown")
        loginctl poweroff
        ;;
    *)
        exit 0
        ;;
esac



