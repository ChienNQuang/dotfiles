# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# WezTerm sometimes carries a stale NO_COLOR=true; ensure color CLIs (claude, etc.) keep color
unset NO_COLOR

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"
eval "$(~/.local/bin/mise activate)"

# Default editor
export EDITOR="nvim"
export VISUAL="nvim"

# pnpm
export PNPM_HOME="/Users/ezarp/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end


export DYLD_LIBRARY_PATH=~/Downloads/instantclient_23_26
export ORACLE_HOME=~/Downloads/instantclient_23_26
export OCI_DIR=~/Downloads/instantclient_23_26

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/Users/ezarp/.cargo/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# Initialize zsh completion system. Must be loaded before anything that calls
# `compdef` (fzf, `but completions`, etc.) — otherwise: "compdef: command not found".
autoload -Uz compinit
compinit

# fzf (Ctrl+R fuzzy history, Ctrl+T file picker, Alt+C cd)
source <(fzf --zsh)

# zsh-autosuggestions: inline gray ghost-text from history. Right-arrow to accept.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# OmniSharp/Zed: arm64 .NET location (install_location points to a missing x64 path)
export DOTNET_ROOT=/usr/local/share/dotnet

# Aliases
alias yolo='claude --dangerously-skip-permissions'

# Added by GitButler installer
eval "$(but completions zsh)"

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh auto-selects the vi keymap because $EDITOR is nvim. Force emacs
# keybindings instead — no more "mode" switch when Alt/Option sends ESC.
bindkey -e
bindkey '^[[1;3D' backward-word   # Option + Left
bindkey '^[[1;3C' forward-word    # Option + Right
# (Alt/Option + Backspace = backward-kill-word is already the emacs default.)
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# WezTerm: report cwd via OSC 7 so new splits/tabs inherit the directory.
# (p10k doesn't emit this on its own.) Only active inside WezTerm.
if [[ -n "$WEZTERM_PANE" ]]; then
  _wezterm_osc7() { printf '\033]7;file://%s%s\033\\' "$HOST" "$PWD"; }
  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _wezterm_osc7
  _wezterm_osc7   # emit once for the current dir
fi

# bun completions
[ -s "/Users/ezarp/.bun/_bun" ] && source "/Users/ezarp/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# kimi-code
export PATH="/Users/ezarp/.kimi-code/bin:$PATH"

# nix: the nix on this machine was installed by Flox, whose installer never
# created /nix/var/nix/profiles/default with nss-cacert and sets no
# ssl-cert-file. The daemon gets NIX_SSL_CERT_FILE from its launchd plist, but
# the *client* gets nothing — so client-side fetches (flake registry, flake
# inputs) fail with "unable to get local issuer certificate". Point it at
# macOS's system bundle, which Apple maintains and nix GC cannot remove.
# ssl-cert-file in nix.conf does NOT work here: it's a restricted setting that
# nix ignores from untrusted users. The env var is the only clean fix.
[ -r /etc/ssl/cert.pem ] && export NIX_SSL_CERT_FILE=/etc/ssl/cert.pem

# zoxide: aliases `cd` to frecency-based directory jumper. `cdi` for interactive picker.
# must stay at the end of this file
eval "$(zoxide init zsh --cmd cd)"

# Pi
export PATH="/Users/ezarp/.local/share/mise/installs/node/24.15.0/bin:$PATH"

# Local secrets / machine-specific overrides (not tracked in dotfiles)
[[ -f ~/.zshrc-local ]] && source ~/.zshrc-local
