# 🖥️ dotfiles

macOS config via Nix flakes (nix-darwin + home-manager).

## Install

1. Install [Nix](https://github.com/DeterminateSystems/nix-installer):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
2. Clone this repo
3. `make`

## Uninstall

```bash
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
/nix/nix-installer uninstall
```

> May need to delete the Nix partition manually via Disk Utility.

## 🔧 Tips

**Patch a font with Nerd Fonts glyphs:**
```bash
docker run --rm -v ~/dev/dotfiles/fonts/in:/in -v ~/dev/dotfiles/fonts/out:/out nerdfonts/patcher
```

**Fix Neovim markdown preview:**
```bash
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app && ./install.sh
```

**Set up Molten (Jupyter in Neovim):**
```bash
uv task run create-molten-env
```
