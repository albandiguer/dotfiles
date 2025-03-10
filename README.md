# 🖥️ Config
## Install 
1. Install [nix with installer](https://github.com/DeterminateSystems/nix-installer) 
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
2. Clone this repo 
3. Run `make` 
## Tools setup & memos
> [!TIP] [ Patch fonts for glyph ](https://github.com/ryanoasis/nerd-fonts#option-9-patch-your-own-font) with
`docker run --rm -v ~/dev/dotfiles/fonts/in:/in -v  ~/dev/dotfiles/fonts/out:/out nerdfonts/patcher`
### [Neovim](./home/programs/kickstart-nvim/README.md)
1. Fix markdown preview
```bash
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
./install.sh
```
2. [ Disable C-Space binding ](https://apple.stackexchange.com/questions/423971/disable-controlspace-keyboard-shortcut) on MacOS so it's usable in nvim
3. **Gist:**
`!h gist-vim` for help, tldr add a `~/.gist-vim` with `token xxx` in it, token
from gh with gist scope
> [!TIP]
> - Use `gc` flag for interactive replace: `:cdo s/StringOne/StringTwo/gc | update`
### [Mise(-en-place)](https://mise.jdx.dev/dev-tools/shims.html)
- `mise ls` to list currently installed language
- add shims directory to path so lsp etc are not lost `mise activate --shims`
- use `.tools-versions` in projects to pinpoint specific versions, for example
```#.tools-versions
postgres 14
gcloud   latest
ruby   3.4.1
```
- for postgres, visit [asdf plugin page](https://github.com/smashedtoatoms/asdf-postgres) 
this is important
`export PKG_CONFIG_PATH="/opt/homebrew/bin/pkg-config:$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix curl)/lib/pkgconfig:$(brew --prefix zlib)/lib/pkgconfig"`
#### uv
##### molten
create molten venv and add deps (see mise file) `uv task run create-molten-env`

##### [aider](https://aider.chat/docs/install.html)
`uv tool install --force --python python3.12 aider-chat@latest` 

To upgrade `uv tool upgrade aider-chat`

## Uninstall
```bash
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
/nix/nix-installer uninstall
```
> [!NOTE]
> for some reason i had to del manually the partition via disk util
> after that step, reinstall following above 
