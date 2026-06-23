#!/bin/bash
wallpaper_dir="$HOME/wallpaper/"
state_file="$HOME/.config/hypr/.last_wallpaper_index"

mapfile -t wallpapers < <(find "$wallpaper_dir" -type f -not -name "dark.png" -not -name "light.png" | sort)

total=${#wallpapers[@]}

if [[ -f "$state_file" ]]; then
  last_index=$(<"$state_file")
else
  last_index=-1
fi

next_index=$(((last_index + 1) % total))

next_wallpaper="${wallpapers[$next_index]}"

awww img "$next_wallpaper" --transition-step 80 --transition-fps 150 --transition-type any --transition-duration 3

wal -i "$next_wallpaper"

echo "$next_index" >"$state_file"
