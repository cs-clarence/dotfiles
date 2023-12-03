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
export MITMPROXY_HOME="$HOME/.mitmproxy"
export PATH="$MITMPROXY_HOME/bin:$PATH"
# MITM PROXY END

. "$HOME/.cargo/env"

# GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
# END GVM

export SURREALDB_HOME="$HOME/.surrealdb"
export PATH="$SURREALDB_HOME:$PATH"

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# zellij
export ZELLIJ_HOME="$HOME/.zellij"
export PATH="$ZELLIJ_HOME:$PATH"
# zellij end

# fly install
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
# fly end

# DENO
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# DENO END

# PLEASE
export PATH="$HOME/.please/bin:$PATH"
# PLEASE END

# MOONREPO START
export PATH="$HOME/.moon/bin:$PATH"
# MOONREPO END
source "/home/rencedm112/.rover/env"

export PATH="$HOME/.zig:$PATH"

# PlatformIO
export PLATFORMIO_HOME="$HOME/.platformio"
export PATH="$PLATFORMIO_HOME/penv/bin:$PATH"
# PlatformIO end
