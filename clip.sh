#!/usr/bin/env bash
# Clipboard daemon: automatically store clipboard history

histfile="$HOME/.cache/cliphist"
pinnedfile="$HOME/.cache/cliphist_pinned"
placeholder="<NEWLINE>"
max_history=50

mkdir -p ~/.cache
touch "$histfile" "$pinnedfile"

last_clip=""

save_clipboard() {
    [ -z "$clip" ] && return
    # Replace all newlines with placeholder to store as single line
    multiline=$(echo "$clip" | sed ':a;N;$!ba;s/\n/'"$placeholder"'/g')
    # Avoid duplicates
    grep -Fxq "$multiline" "$histfile" || echo "$multiline" >> "$histfile"
    # Keep last $max_history entries
    tail -n $max_history "$histfile" > "$histfile.tmp" && mv "$histfile.tmp" "$histfile"
}

# Monitor clipboard continuously
while true; do
    clip=$(xclip -o -selection clipboard 2>/dev/null)
    if [[ "$clip" != "$last_clip" ]]; then
        last_clip="$clip"
        save_clipboard
    fi
    sleep 0.5
done

