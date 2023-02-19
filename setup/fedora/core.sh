# stores executable to package map
declare -A dnf_packages

dnf_packages["nvim"]="neovim"
dnf_packages["git"]="git"
dnf_packages["clang"]="clang"
dnf_packages["cmake"]="cmake"
dnf_packages["snap"]="snapd"
dnf_packages["shmft"]="shfmt"

declare -A external_binaries

declare -A flatpak_packages

declare -A post_install_commands

post_install_commands["snap"]="sudo ln -s /var/lib/snapd/snap /snap"

to_be_installed=()
to_be_run=()

# The list which constains packages to install

for executable in "${!dnf_packages[@]}"; do
	package="${dnf_packages[${executable}]}"
	if ! which "${executable}" &>/dev/null; then
		to_be_installed+=("${package}")
		to_be_run+=("${post_install_commands[${executable}]}")

		echo "${package} will be installed"
	else
		echo "${package} is already installed"
	fi
done
