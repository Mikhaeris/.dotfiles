#!/usr/bin/env bash

dir="${1:-$HOME}"

selected="$(yazi "$dir" --chooser-file=/dev/stdout)"

echo "$selected"
