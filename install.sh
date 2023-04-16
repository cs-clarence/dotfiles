#!/usr/bin/env bash

dir=$(realpath "$(dirname "$0")")

declare -A files
home_dir=~
home_dir_replacements=(home/.* home/*.sh)
unset "home_dir_replacements[0]" # remove .
unset "home_dir_replacements[1]" # remove ..
files[$home_dir]=${home_dir_replacements[*]}

config_dir=~/.config
config_dir_replacements=(config/*)
files[$config_dir]=${config_dir_replacements[*]}

existing=()
for k in "${!files[@]}"; do
  for v in ${files[$k]}; do
    filename=$(basename "$v")
    loc="$k/$filename"

    if [[ -e "$loc" ]]; then
      existing+=("$loc")
    fi
  done
done

function replace() {
	for i in "$@"; do
		echo "Replacing \"$i\""
		rm -rf "$i"
	done
}

function rename_to_old() {
	for i in "$@"; do
		echo "Renaming \"$i\" to \"$i.old\""
		mv "$i" "$i.old"
	done
}

if [[ ${#existing[@]} -gt 0 ]]; then
  echo "These file(s) already exist: "
	for i in "${existing[@]}"; do
		echo "$i"
	done

	printf "\nWhat do you want to do?\n"
	echo "1) Prepend .old to the existing names"
	echo "2) Replace existing"
	echo "3) Exit"

	while true; do
		printf "Select (1, 2, or 3): "
		read -r answer

		case $answer in
		1)
			echo "Renaming files..."
			rename_to_old "${existing[@]}"
			break
			;;

		2)
			echo "Replacing files..."
			replace "${existing[@]}"
			break
			;;

		3)
			echo "Bye!"
			exit 1
			;;

		*) ;;

		esac
	done
fi

for k in "${!files[@]}"; do
  for v in ${files[$k]}; do
    source="$dir/$v"
    filename=$(basename "$v")
    loc="$k/$filename"

    ln -s "$source" "$loc"
    echo "Linked \"$source\" to \"$loc\""
  done
done

echo "Done! You are good to go."
