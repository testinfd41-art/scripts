#!/usr/bin/env bash
# Clipboard menu: select, copy, pin/unpin, delete, clear all

histfile="$HOME/.cache/cliphist"
pinnedfile="$HOME/.cache/cliphist_pinned"
placeholder="<NEWLINE>"

mkdir -p ~/.cache
touch "$histfile" "$pinnedfile"

# Combine pinned + history for menu
menu_items=$(cat "$pinnedfile" "$histfile" | sed "s/$placeholder/\n/g")

# Minimal dmenu popup
action=$(echo "$menu_items" | dmenu -i -l 10 -p "Clipboard History:" -fn "JetBrainsMono Nerd Font-12")
[ -z "$action" ] && exit

# Menu of actions
choice=$(echo -e "Copy\nPin/Unpin\nDelete\nClear All\nCancel" | dmenu -i -p "Action:" -fn "JetBrainsMono Nerd Font-12")
case "$choice" in
Copy)
    echo "$action" | sed "s/$placeholder/\n/g" | xclip -i -selection clipboard
    ;;
Pin/Unpin)
    multiline=$(echo "$action" | sed ':a;N;$!ba;s/\n/'"$placeholder"'/g')
    if grep -Fxq "$multiline" "$pinnedfile"; then
        grep -Fxv "$multiline" "$pinnedfile" > "$pinnedfile.tmp" && mv "$pinnedfile.tmp" "$pinnedfile"
    else
        echo "$multiline" >> "$pinnedfile"
    fi
    ;;
Delete)
    multiline=$(echo "$action" | sed ':a;N;$!ba;s/\n/'"$placeholder"'/g')
    grep -Fxv "$multiline" "$histfile" > "$histfile.tmp" && mv "$histfile.tmp" "$histfile"
    grep -Fxv "$multiline" "$pinnedfile" > "$pinnedfile.tmp" && mv "$pinnedfile.tmp" "$pinnedfile"
    ;;
Clear\ All)
    # Only clear unpinned history, keep pinned entries
    > "$histfile"
    ;;
Cancel)
    exit
    ;;
esac

