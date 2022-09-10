#!/usr/bin/env bash

dir=$(realpath "$(dirname "$0")")
files=("$dir"/home/.*)
unset "files[0]" # remove .
unset "files[1]" # remove ..

existing_files=()
for i in "${files[@]}"; do
	filename=$(basename "$i")
	loc="$HOME/$filename"

	if [[ -e "$loc" ]]; then
		existing_files+=("$loc")
	fi
done

function replace_files() {
	for i in "$@"; do
		echo "Replacing \"$i\""
		rm -rf "$i"
	done
}

function rename_files_to_old() {
	for i in "$@"; do
		echo "Renaming \"$i\" to \"$i.old\""
		mv "$i" "$i.old"
	done
}

if [[ ${#existing_files[@]} -gt 0 ]]; then
	echo "These files already exist: "
	for i in "${existing_files[@]}"; do
		echo "$i"
	done

	printf "\nWhat do you want to do?\n"
	echo "1) Prepend .old to the existing files' filenames"
	echo "2) Replace existing files"
	echo "3) Exit"

	while true; do
		printf "Select (1, 2, or 3): "
		read -r answer

		case $answer in
		1)
			echo "Renaming files..."
			rename_files_to_old "${existing_files[@]}"
			break
			;;

		2)
			echo "Replacing files..."
			replace_files "${existing_files[@]}"
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

for i in "${files[@]}"; do
	filename=$(basename "$i")
	source="$dir/home/$filename"
	loc="$HOME/$filename"

	ln -s "$source" "$loc"
	echo "Linked \"$source\" to \"$loc\""
done

echo "Done! You are good to go."
