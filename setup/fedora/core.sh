# stores package to executable map
declare -A core_dnf_packages

core_dnf_packages["neovim"]="nvim"
core_dnf_packages["git"]="git"
core_dnf_packages["clang"]="clang"
core_dnf_packages["cmake"]="cmake"
core_dnf_packages["snapd"]="snap" 


declare -A post_install_commands

post_install_commands["snapd"]="sudo ln -s /var/lib/snapd/snap /snap"

to_be_installed=()
to_be_run=()

# The list which constains packages to install

for package in "${!core_dnf_packages[@]}"; do
  if ! which "${core_dnf_packages[${package}]}" &> /dev/null; then
    to_be_installed+=("${package}")
    to_be_run+=("${post_install_commands[${package}]}")

    echo "${package} will be installed"
  else 
    echo "${package} is already installed"
  fi
done
