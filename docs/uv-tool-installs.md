# uv tools: installed imperatively (not declared in Nix)

Some CLIs are installed by hand with `uv tool install`. They live in
`~/.local/share/uv/tools/<pkg>` and are symlinked into `~/.local/bin` (on `PATH` via
`home/users/albandiguer/home.nix`). Intentionally not in any `.nix` file — see the comment next
to `uv` in `home/programs/mise.nix`.

| Command | Package | Install |
|---|---|---|
| `graphify`, `graphify-mcp` | `graphifyy` | `uv tool install graphifyy` |
| `planecli` | `plane-cli` | `uv tool install git+https://github.com/cpatrickalves/plane-cli.git` |

`uv tool list` is the source of truth. Each tool gets its own venv on uv's managed CPython;
Nix's and Homebrew's Python are irrelevant to them.

## Failure mode: `bad interpreter`

A venv built against a Homebrew Python breaks when that Python is upgraded/removed — every
entry point dies with `.../graphifyy/bin/python: bad interpreter: No such file or directory`
(and `uv tool list` warns "environment not found"). Rebuild it on uv's Python:

```bash
uv tool install graphifyy --reinstall   # --upgrade also moves to the latest release
```

`--reinstall` only rebuilds the venv; `--upgrade` may jump major versions, so re-check
`--help` afterwards.

## Policy

Declare in Nix when it fits the layers in `AGENTS.md`, otherwise install by hand and note it
here. Remove with `uv tool uninstall <pkg>`.
