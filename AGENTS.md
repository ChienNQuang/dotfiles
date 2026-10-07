# dotfiles

Personal dotfiles managed with GNU Stow. Each top-level directory is a Stow
package that mirrors paths under `$HOME`.

`agents/` is a git submodule pointing at `ChienNQuang/agent-dotfiles`. It is a
nested Stow directory with its own packages (`shared`, `pi`, `claude`). Read
`agents/AGENTS.md` before editing anything inside it.

## Committing changes under agents/

The parent repository records a submodule commit, so that commit must exist on
the submodule remote before the parent is committed.

1. Commit and push inside the submodule:

   ```sh
   cd agents
   git add -A
   git commit -m "<summary>"
   git push origin main
   ```

2. Update the pointer in the parent:

   ```sh
   cd ..
   git add agents
   git commit -m "agents: <summary>"
   git push origin main
   ```

Do not commit the parent while `git -C agents status` shows uncommitted
changes or commits not yet pushed. Changes outside `agents/` commit normally.

## Installing and verifying

- `stow <pkg>` from this directory installs a top-level package.
- The agent packages are installed with
  `stow --dir="$HOME/dotfiles/agents" --target="$HOME" --no-folding <packages>`.
- After changing files that are stowed, nothing needs re-running; the links
  point at the working tree. After adding or removing files, run the same stow
  command with `--restow`.

See `README.md` for the full setup.
