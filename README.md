# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```sh
git clone git@github.com:<you>/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow git ghostty zed
```

Each top-level directory is a "package". `stow <pkg>` symlinks the contents into `$HOME`.

## Packages

- `git/` — `.gitconfig` (with delta), `.gitignore_global`
- `ghostty/` — `~/.config/ghostty/config`
- `zed/` — `~/.config/zed/settings.json`

## Add a new package

1. Create `<pkg>/` mirroring the path under `$HOME` (e.g. `<pkg>/.config/foo/bar`).
2. `stow <pkg>` from `~/dotfiles`.
3. To remove: `stow -D <pkg>`.
