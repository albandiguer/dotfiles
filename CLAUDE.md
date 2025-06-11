# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Nix Flake-based dotfiles configuration** that manages both macOS system configurations (via nix-darwin) and user environments (via home-manager). The architecture separates system-level settings in `darwin/` from user-specific configurations in `home/`.

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
- **Mise** is the primary tool version manager (replaces asdf)
- **Fish shell** with extensive abbreviations: `cc` (claude), `lg` (lazygit), `g` (git)
- **Tmux** sessions for development with vi-mode bindings

## Architecture

### Flake Structure
- `flake.nix` - Main configuration with inputs/outputs
- `darwin/macbook.nix` - macOS system-level packages and settings
- `home/users/albandiguer/home.nix` - User environment via home-manager
- `home/programs/` - Modular program configurations (one file per tool)

### Machine-Specific Configurations
The flake supports multiple machines with different git emails and Obsidian vault paths:
- `Albans-MacBook-Air` (personal)
- `Prettos-MacBook-Pro` (work)

### Package Management Layers
1. **System packages** - Core tools in darwin/macbook.nix (including claude-code)
2. **Homebrew** - Tools requiring special installation (bitwarden-cli, git-crypt, puma-dev)
3. **User packages** - CLI utilities in home.nix
4. **Language tools** - Managed by mise with version files

## Development Environment

### Key Tools
- **Claude Code CLI** - Installed system-wide, aliased as `cc`
- **Aider** - AI coding assistant with custom dark theme configuration
- **Neovim** - Based on kickstart.nvim with AI integrations (Avante, Claude Code plugin)
- **Lazygit** - Visual git interface

### Neovim Configuration
Located at `home/programs/neovim/nvim/`:
- Custom plugins in `lua/custom/plugins/`
- AI tools: aider.lua, avante.lua, claude-code.lua
- Development: rails.lua, dadbod.lua, jupyter.lua

### Language/Runtime Management
Mise handles versions for: AWS CLI, Node.js, PostgreSQL, Ruby, Rust, Terraform, Python (UV)
- Configuration in `home/programs/mise.nix`
- Default packages defined in `home/dotfiles/.default-*` files

## Configuration Patterns

### Adding New Programs
1. Create `home/programs/program-name.nix` following the pattern:
```nix
{pkgs, ...}: {
  programs.programName = {
    enable = true;
    # configuration
  };
}
```
2. Import in `home/users/albandiguer/home.nix`
3. Run `make apply` to activate

### System vs User Packages
- **System packages** (darwin/macbook.nix): Core system tools, AI development tools
- **User packages** (home.nix): CLI utilities, fonts, development tools that don't require system integration

## AI Development Focus

This configuration is optimized for AI-assisted development with Claude Code, Aider, and Neovim integrations. The Fish shell includes shortcuts for common AI tools, and the terminal environment is configured for efficient code interaction.