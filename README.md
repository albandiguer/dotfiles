# 💾

---

Using nix-darwin, home-manager, neovim and a few others tools

## Setup 
- Install [nix with installer](https://github.com/DeterminateSystems/nix-installer) 
```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
- Clone this repo and run `make` in it

## [Neovim](./home/programs/kickstart-nvim/README.md)

### Fix markdown preview

```
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/
./install.sh
```


## Uninstall

```
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
/nix/nix-installer uninstall
```
> [!NOTE]
> for some reason i had to del manually the partition via disk util
> after that step, reinstall following above 




## Mise(-en-place)

[mise-en-place](https://mise.jdx.dev/dev-tools/shims.html)
use `mise ls` to list currently installed language

add shims directory to path so lsp etc are not lost
`mise activate --shims`


## Gist

`!h gist-vim` for help, tldr add a `~/.gist-vim` with `token xxx` in it, token
from gh with gist scope

### Reminders/mappings
Search + Replace all and save
> Telescope Grep to find the string project wise, CTRL+Q to add them all to the Quickfix list and then ‘:cdo s/StringOne/StringTwo/g | update’

__LSP__
Default behaviour of Ctrl n comes from that, we overload it inside cmp settings
[Improve completion popup menu | Vim Tips Wiki | Fandom](https://vim.fandom.com/wiki/Improve_completion_popup_menu)
```
H -> Hover information
gt -> Type definition
gs -> Signature
gd -> Definition
gr -> References
ca -> Code action
```


## Tmux

### Keys

Select sessions named such as `<M-a>` in tmux sessions list selection.
We change the profile in iterm2 keys> keys config

```
Right option key : Esc+
```

## Fonts

[Github](https://github.com/ryanoasis/nerd-fonts#option-9-patch-your-own-font)
Patch fonts for glyph like so
```
docker run --rm -v ~/dev/dotfiles/fonts/in:/in -v  ~/dev/dotfiles/fonts/out:/out nerdfonts/patcher
```

## Todos

- [ ] Switch tooling for python to Ruff? (lsp, formatting code acsh etc) - compare w/ mise
- [ ] editorconfig xdg https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
- [ ] switch algo for rsa key to ed25519
- [x] SFMono [Gh](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized)

</details>
