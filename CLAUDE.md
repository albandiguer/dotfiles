Here's the compressed version:

# CLAUDE.md

Guidance for Claude Code (claude.ai/code) in this repo.

## Repository Overview

**Nix Flake-based dotfiles config** — macOS system configs (nix-darwin) + user environments (home-manager). System settings in `darwin/`, user configs in `home/`.

## Common Commands

### Configuration Management
```bash
# Apply configuration changes
make apply  # or just `make`

# Update flake inputs and apply changes  
make up

# Rollback to previous generation if something breaks
make rollback

# Clean up old system generations
make cleanup
```

### Development Tools
- **Mise** — primary tool version manager (replaces asdf)
- **Fish shell** — abbreviations: `cc` (claude), `lg` (lazygit), `g` (git)
- **Tmux** — vi-mode bindings

## Architecture

### Flake Structure
- `flake.nix` — main config, inputs/outputs
- `darwin/macbook.nix` — macOS system packages/settings
- `home/users/albandiguer/home.nix` — user env via home-manager
- `home/programs/` — modular per-tool configs

### Machine-Specific Configurations
Flake supports multiple machines (different git emails, Obsidian vault paths):
- `Albans-MacBook-Air` (personal)
- `Prettos-MacBook-Pro` (work)

### Package Management Layers
1. **System packages** — core tools in darwin/macbook.nix (incl claude-code)
2. **Homebrew** — special install needs (bitwarden-cli, git-crypt, puma-dev)
3. **User packages** — CLI utils in home.nix
4. **Language tools** — mise with version files

## Development Environment

### Key Tools
- **Claude Code CLI** — system-wide, aliased `cc`
- **Aider** — AI coding assistant, custom dark theme
- **Neovim** — kickstart.nvim base, AI integrations (Claude Code plugin)
- **Lazygit** — visual git interface

### Neovim Configuration
Located `home/programs/neovim/nvim/`:
- Custom plugins: `lua/custom/plugins/`
- AI: claude-code.lua
- Dev: rails.lua, dadbod.lua, jupyter.lua

### Language/Runtime Management
Mise handles: AWS CLI, Node.js, PostgreSQL, Ruby, Rust, Terraform, Python (UV)
- Config: `home/programs/mise.nix`
- Defaults: `home/dotfiles/.default-*` files

## Configuration Patterns

### Adding New Programs
1. Create `home/programs/program-name.nix`:
```nix
{pkgs, ...}: {
  programs.programName = {
    enable = true;
    # configuration
  };
}
```
2. Import in `home/users/albandiguer/home.nix`
3. `make apply` to activate

### System vs User Packages
- **System packages** (darwin/macbook.nix): core system tools, AI dev tools
- **User packages** (home.nix): CLI utils, fonts, dev tools not needing system integration

## AI Development Focus

Config optimized for AI-assisted dev — Claude Code, Aider, Neovim integrations. Fish shell has AI tool shortcuts, terminal env tuned for code interaction.