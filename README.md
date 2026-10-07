# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```sh
git clone --recurse-submodules https://github.com/ChienNQuang/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow git ghostty zed
stow --dir="$HOME/dotfiles/agents" --target="$HOME" --no-folding shared pi claude
```

Each top-level directory is a "package". `stow <pkg>` symlinks the contents into `$HOME`.

The `agents/` submodule is itself a Stow directory with one package per agent harness (`shared`, `pi`, `claude`). Name only the packages for the harnesses you use. It is stowed with `--no-folding` so credentials, sessions, caches, and other runtime state remain outside the repository. See [agents/README.md](agents/README.md) for details.

## Packages

- `git/` — `.gitconfig` (with delta), `.gitignore_global`
- `ghostty/` — `~/.config/ghostty/config`
- `zed/` — `~/.config/zed/settings.json`
- `agents/` — Agent configuration submodule: `shared` skills plus `pi` and `claude` harness packages

## Add a new package

1. Create `<pkg>/` mirroring the path under `$HOME` (e.g. `<pkg>/.config/foo/bar`).
2. `stow <pkg>` from `~/dotfiles`.
3. To remove: `stow -D <pkg>`.
