#!/usr/bin/env bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Customizing shell prompts
parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export OLD_PS1=$PS1
export PS1="\e[0;34m\W\e[0;32m\$(parse_git_branch) \e[0;31m$ \e[m"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# Android Home
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools:$ANDROID_HOME/emulator:$PATH"

# Setting chrome dev tool for flutter
if [ -x "$(command -v chrome-browser)" ]; then
	ce="$(which chrome-browser)"
	export CHROME_EXECUTABLE=$ce
elif [ -x "$(command -v chromium-browser)" ]; then
	ce="$(which chromium-browser)"
	export CHROME_EXECUTABLE=$ce
fi

unset rc

# BUN
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# BUN end

# NGROK
export NGROK_HOME="$HOME/.ngrok"
export PATH="$NGROK_HOME/bin:$PATH"
# NGROK end

# MITM PROXY START
export MITM_HOME="$HOME/.mitmproxy"
export PATH="$MITM_HOME/bin:$PATH"
# MITM PROXY END

. "$HOME/.cargo/env"

# GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
# END GVM

export PATH="$HOME/.surrealdb:$PATH"

# fnm
export PATH="/home/rencedm112/.local/share/fnm:$PATH"
eval "$(fnm env)"
