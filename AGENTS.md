# AGENTS.md

Guidance for AI coding agents in this repo.

## What this is

Nix flake dotfiles: macOS system config (nix-darwin, `darwin/`) + user env (home-manager, `home/`). Homebrew deps in `homebrew/`.

## Commands

- `make` / `make apply` — apply changes (nix-darwin switch + `brew bundle`, incl. per-hostname `Brewfile.<hostname>`)
- `make up` — update flake inputs + apply
- `make rollback` — rollback nix-darwin generation
- `make cleanup` — GC old generations

## Layout

- `darwin/macbook.nix` — system packages/settings
- `home/users/albandiguer/home.nix` — user env, imports the modules below
- `home/programs/` — one module per tool (incl. `neovim/`, config at `home/programs/neovim/nvim/`, custom plugins in `lua/custom/plugins/`)
- `homebrew/` — Brewfiles (all machines + per-hostname)

## Package layers (order)

1. `darwin/macbook.nix` — system packages
2. `homebrew/` — things nix can't/won't do
3. `home.nix` — user CLI tools/fonts
4. `mise` — language runtimes; defaults in `home/dotfiles/.default-*`

## Machine-specific

Multiple machines (different git email, Obsidian vault path):

- `Albans-MacBook-Air` (personal)
- `Prettos-MacBook-Pro` (work)

## Adding a program

1. Create `home/programs/<name>.nix` (`{pkgs, ...}: { programs.<name> = {...}; }`)
2. Import it in `home/users/albandiguer/home.nix`
3. `make apply`
