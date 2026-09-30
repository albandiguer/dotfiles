# uv tools: installed imperatively (not declared in Nix)

Some CLIs are installed by hand with `uv tool install` instead of being declared in Nix. They live in `~/.local/share/uv/tools/<pkg>` and are symlinked into `~/.local/bin`, which is on `PATH` via `home/users/albandiguer/home.nix`.

They are **not** in any `.nix` file — intentionally. See the comment in `home/programs/mise.nix` next to `uv = "latest"`.

## Installed tools

| Command | Package | Install |
|---|---|---|
| `graphify`, `graphify-mcp` | `graphifyy` | `uv tool install graphifyy` |
| `planecli` | `plane-cli` | `uv tool install git+https://github.com/cpatrickalves/plane-cli.git` |

`uv tool list` is the source of truth.

## Which Python they run

Each tool gets its own venv under uv's managed CPython store, e.g.:

```
~/.local/share/uv/tools/graphifyy/bin/python
  → ~/.local/share/uv/python/cpython-3.14-macos-aarch64-none/bin/python3.14
```

`pyvenv.cfg` pins it (`include-system-site-packages = false`). Nix's Python and Homebrew's Python are irrelevant to these tools.

## Failure mode: `bad interpreter`

If a venv was created against a Homebrew Python (`/opt/homebrew/opt/python@X.Y/bin/python3.Y`), a Homebrew upgrade/removal deletes that interpreter and every entry point breaks:

```
~/.local/bin/graphify: .../graphifyy/bin/python: bad interpreter: No such file or directory
```

Symptoms: the command fails instantly, and `uv tool list` prints
`warning: Tool 'graphifyy' environment not found`.

Fix — rebuild the venv on uv's own Python:

```bash
uv tool install graphifyy --reinstall   # or --upgrade to move to the latest release
```

This is the general fix for any `uv tool` CLI that dies this way; `--reinstall` only rebuilds the venv, whereas rebuilding may also jump major versions (graphify 0.5.x → 0.9.x on one such rebuild), so re-check `--help` afterwards.

## Policy

Same spirit as `docs/brew-managed-vs-manual.md`: declare it in Nix when it fits the layers in `AGENTS.md`, otherwise install by hand and note it here. No cleanup automation — remove with `uv tool uninstall <pkg>`.
