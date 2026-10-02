# beads (`bd`) — issue tracker chained by dependencies

Lightweight, git-friendly issue tracker with first-class dependency support, stored in a
per-repo `.beads/` Dolt database. Installed via Homebrew (see `brew-managed-vs-manual.md`).

```bash
bd init                 # create .beads/ (add --stealth to keep it out of git)
bd setup --list         # AI-editor integrations (bd setup codex / cursor / claude / ...)
bd create "Title"       # new issue; child: bd create "Child" --parent <id>
bd ready                # unblocked work you can start now
bd list                 # everything, filterable
bd update <id> --claim  # atomically take it (assignee=you, status=in_progress)
bd close <id>           # done
bd prime                # print the agent workflow cheat-sheet into a session
```

Existing clone: `bd bootstrap` (restores/clones, never deletes issues). `bd --help` is the
source of truth.

## Shell completion (fish)

`bd completion fish` runs from an autoload file — see `home/programs/fish/default.nix`.
