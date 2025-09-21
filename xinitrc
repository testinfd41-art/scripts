#!/bin/sh

~/bin/clip.sh &

# Start D-Bus session if not already running
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Start PipeWire
pipewire &
pipewire-pulse &
wireplumber &

# Start polkit agent for authentication (required for mounting)
if [ -x /usr/libexec/polkit-gnome-authentication-agent-1 ]; then
    /usr/libexec/polkit-gnome-authentication-agent-1 &
fi

# Start gvfs daemons for Thunar integration
/usr/libexec/gvfsd &
/usr/libexec/gvfs-udisks2-volume-monitor &
/usr/libexec/gvfs-mtp-volume-monitor &
/usr/libexec/gvfs-gphoto2-volume-monitor &

# Add personal bin directories to PATH
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

dwmblocks &

# Finally, start your WM
exec dwm

