# 🖥️ dotfiles

macOS config via Nix flakes (nix-darwin + home-manager).

## Install

1. Install [Nix](https://github.com/DeterminateSystems/nix-installer):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
2. Install [Homebrew](https://brew.sh):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Clone this repo
4. `make` (runs `nix-darwin` switch + `brew bundle`)

## Uninstall

```bash
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
/nix/nix-installer uninstall
```

> May need to delete the Nix partition manually via Disk Utility.

## 🔧 Tips

**Patch a font with Nerd Fonts glyphs:**

```bash
docker run --rm -v ~/dev/dotfiles/misc/fonts/in:/in -v ~/dev/dotfiles/misc/fonts/out:/out nerdfonts/patcher
```

**Set up Molten (Jupyter in Neovim):**

```bash
uv task run create-molten-env
```
