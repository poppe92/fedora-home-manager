#!/bin/bash
pkill waybar

if [[ $USER = "jesper" ]]; then
	waybar -c /home/jesper/git/.dotfiles/modules/waybar/config & -s /home/jesper/git/.dotfiles/modules/waybar/style.css &
else
	waybar &
fi

