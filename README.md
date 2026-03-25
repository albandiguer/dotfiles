# 🖥️ Config

## Install

1. Install [nix with installer](https://github.com/DeterminateSystems/nix-installer)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Clone this repo
3. Run `make`

## Uninstall 

```bash
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
/nix/nix-installer uninstall
```

> [!NOTE]
> might need to del manually the partition via disk util

## Fixes & tips 

- Fonts
    - [Patch glyph ](https://github.com/ryanoasis/nerd-fonts#option-9-patch-your-own-font)
        ```bash
        docker run --rm -v ~/dev/dotfiles/fonts/in:/in \
        -v  ~/dev/dotfiles/fonts/out:/out \
        nerdfonts/patcher
        ```

- Markdown
    - Fix markdown preview
        ```bash
        cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
        ./install.sh
        ```

- Molten
    - add [molten](https://github.com/benlubas/molten-nvim) venv and add deps (see mise file) 
    ```bash
        uv task run create-molten-env


