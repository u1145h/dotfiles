zstyle ':z4h:' auto-update      'no'
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Autosuggestions accept behavior.
zstyle ':z4h:autosuggestions' forward-char 'accept'

# FZF completion options.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Direnv integration.
zstyle ':z4h:direnv'         enable 'no'
zstyle ':z4h:direnv:success' notify 'yes'

# SSH teleportation rules.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
zstyle ':z4h:ssh:*'                   enable 'no'
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories.
z4h install ohmyzsh/ohmyzsh || return

# Initialize zsh4humans.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Load extra zsh plugins.
z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh
z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock

# Key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace
z4h bindkey undo Ctrl+/ Shift+Tab
z4h bindkey redo Alt+/
z4h bindkey z4h-cd-back    Alt+Left
z4h bindkey z4h-cd-forward Alt+Right
z4h bindkey z4h-cd-up      Alt+Up
z4h bindkey z4h-cd-down    Alt+Down

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Named dirs: ~w <=> Windows home on WSL (if set).
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Aliases.
alias tree='tree -a -I .git'
alias ls="${aliases[ls]:-ls} -A"

# Shell options.
setopt glob_dots
setopt no_auto_menu

# -------------------------
# Flutter & Android SDK Setup
# -------------------------

# Flutter
export PATH="/opt/flutter/bin:$PATH"

# Android SDK (single consistent setup)
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_AVD_HOME=$HOME/.android/avd

# Add SDK tools to PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$PATH
