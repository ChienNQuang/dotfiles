eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"
eval "$(~/.local/bin/mise activate)"

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

# zoxide: aliases `cd` to frecency-based directory jumper. `cdi` for interactive picker.
eval "$(zoxide init zsh --cmd cd)"

# zsh-autosuggestions: inline gray ghost-text from history. Right-arrow to accept.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# OmniSharp/Zed: arm64 .NET location (install_location points to a missing x64 path)
export DOTNET_ROOT=/usr/local/share/dotnet

# Added by GitButler installer
eval "$(but completions zsh)"
