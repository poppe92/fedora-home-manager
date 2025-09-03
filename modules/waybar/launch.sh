#!/bin/bash
pkill waybar

if [[ $USER = "jesper" ]]; then
	waybar -c /home/jesper/git/fedora-home-manager/modules/waybar/config & -s /home/jesper/git/fedora-home-manager/modules/waybar/style.css &
else
	waybar &
fi

