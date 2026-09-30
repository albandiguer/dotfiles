# AGENTS.md

Guidance for AI coding agents in this repo.

## What this is

Nix flake dotfiles: macOS system config (nix-darwin, `darwin/`) + user env (home-manager, `home/`). Homebrew deps in `homebrew/`.

## Commands

- `make` / `make apply` — apply changes (nix-darwin switch + `brew bundle`, incl. per-hostname `Brewfile.<hostname>`)
- `make up` — update flake inputs + apply
- `make rollback` — rollback nix-darwin generation
- `make cleanup` — GC old generations

## Layout (package layers in priority order)

| #   | Path                              | Contents                                                                    |
| --- | --------------------------------- | --------------------------------------------------------------------------- |
| 1   | `darwin/default.nix`              | system packages/settings (systemPackages)                                   |
| 2   | `homebrew/`                       | Brewfiles, all machines + `Brewfile.<hostname>` — things nix can't/won't do |
| 3   | `home/users/albandiguer/home.nix` | user env: CLI tools/fonts; imports `home/programs/` (one module per tool)   |
| 4   | `mise`                            | language runtimes; defaults in `home/dotfiles/.default-*`                   |

**Rule of thumb:** default to `home.packages` unless a package needs system-wide visibility (services, other users, boot context, root). Only container/VM/service tooling goes in systemPackages — currently just `lima` (VMs) and `cloudflared` (system service).

Neovim config lives at `home/programs/neovim/nvim/`, custom plugins in `lua/custom/plugins/`.

See `docs/` for how things are managed outside Nix: `brew-managed-vs-manual.md`, `uv-tool-installs.md`.

**Open question:** `mise.nix` has `uv = "latest"; # shall it be in nix instead?` — decide; if yes, move to home.packages and let mise manage only versioned tools.

## Machine-specific

Multiple machines (different git email, Obsidian vault path):

- `Albans-MacBook-Air` (personal)
- `Prettos-MacBook-Pro` (work)

## Adding a program

1. Create `home/programs/<name>.nix` (`{pkgs, ...}: { programs.<name> = {...}; }`)
2. Import it in `home/users/albandiguer/home.nix`
3. `make apply`
