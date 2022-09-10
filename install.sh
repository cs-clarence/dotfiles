#!/usr/bin/env bash
dir=$(realpath "$(dirname "$0")") 

for i in "$dir"/home/.*; do
  filename=$(basename "$i")
  if [[  $filename == "." || $filename == ".." ]]; then
    continue
  fi

  ln -s "$dir/home/$filename" "$HOME/$filename"
done
