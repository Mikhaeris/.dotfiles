#!/usr/bin/env bash

profiles=("power-saver" "balanced" "performance")

current=$(powerprofilesctl get 2>/dev/null || echo "balanced")
current=${current,,}

idx=-1
for i in "${!profiles[@]}"; do
  if [[ "${profiles[i]}" == "$current" ]]; then
    idx=$i
    break
  fi
done

if [[ $idx -lt 0 ]]; then
  next="balanced"
else
  next_index=$(( (idx + 1) % ${#profiles[@]} ))
  next="${profiles[$next_index]}"
fi

if powerprofilesctl set "$next"; then
  new=$(powerprofilesctl get 2>/dev/null || echo "$next")
  new=${new,,}

  case "$new" in
    "power-saver") pretty="Power saver" ;;
    "balanced")    pretty="Balanced" ;;
    "performance") pretty="Performance" ;;
    *)             pretty="$new" ;;
  esac

  eww update powermode_pretty="$pretty" 2>/dev/null || true
  eww open powermode-notify 2>/dev/null || true
  ( sleep 2.5; eww close powermode-notify 2>/dev/null || true ) &

else
  if eww windows >/dev/null 2>&1; then
    eww update powermode_pretty="Failed to set profile" 2>/dev/null || true
    eww open powermode-notify 2>/dev/null || true
    ( sleep 2.5; eww close powermode-notify 2>/dev/null || true ) &
  fi
  exit 1
fi

