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

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# fzf (Ctrl+R fuzzy history, Ctrl+T file picker, Alt+C cd)
source <(fzf --zsh)
