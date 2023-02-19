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

declare -A snap_packages
snap_packages["flutter"]="flutter --classic"

declare -A post_install_commands

post_install["snap"]="sudo ln -s /var/lib/snapd/snap /snap"

install_commands=()
post_install_commands=()

# Add dnf packages install commands
for executable in "${!dnf_packages[@]}"; do
	package="${dnf_packages[${executable}]}"
	if ! which "${executable}" &>/dev/null; then
		install_commands+=("sudo dnf install ${package}")
		post_install_commands+=("${post_install[${executable}]}")

		echo "${package} will be installed"
	else
		echo "${package} is already installed"
	fi
done
