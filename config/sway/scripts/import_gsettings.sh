#!/usr/bin/sh

GNOME_SCHEMA="org.gnome.desktop.interface"
gsettings set $GNOME_SCHEMA gtk-theme "Dracula"
gsettings set $GNOME_SCHEMA icon-theme "Adwaita"
gsettings set $GNOME_SCHEMA cursor-theme "Adwaita"
gsettings set $GNOME_SCHEMA font-name "Noto Sans 10"
gsettings set $GNOME_SCHEMA document-font-name "NotoSansM Nerd Font 10"
gsettings set $GNOME_SCHEMA monospace-font-name "NotoSansM Nerd Font 10"
