# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```sh
git clone --recurse-submodules https://github.com/ChienNQuang/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow git ghostty zed
stow --no-folding agents
```

Each top-level directory is a "package". `stow <pkg>` symlinks the contents into `$HOME`. The agent package uses `--no-folding` so credentials, sessions, caches, and other runtime state remain outside the repository.

## Packages

- `git/` — `.gitconfig` (with delta), `.gitignore_global`
- `ghostty/` — `~/.config/ghostty/config`
- `zed/` — `~/.config/zed/settings.json`
- `agents/` — Agent configuration submodule with shared skills and Pi-specific settings

## Add a new package

1. Create `<pkg>/` mirroring the path under `$HOME` (e.g. `<pkg>/.config/foo/bar`).
2. `stow <pkg>` from `~/dotfiles`.
3. To remove: `stow -D <pkg>`.
