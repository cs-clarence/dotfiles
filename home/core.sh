# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

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

# pnpm
export PNPM_HOME="/home/rencedm112/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
