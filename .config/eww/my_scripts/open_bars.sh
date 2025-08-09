#!/usr/bin/env zsh

EWW_BIN=$(command -v eww || echo "/usr/bin/eww")

i=0
while read -r mon; do
  id="bar-${i}"
  "$EWW_BIN" open bar --screen "$mon" --id "$id" --arg ns="bar-$i"
  ((i++))
done < <(hyprctl monitors -j | jq -r '.[].name')
