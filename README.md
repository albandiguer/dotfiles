# 📺 Machines configurations

Using nix-darwin, home-manager, neovim and a few others tools

## Setup 
- Install [nix with installer](https://github.com/DeterminateSystems/nix-installer) 
```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
- Clone this repo and run `make` in it

## Neovim

### Languages 
- tree-sitter: syntax support for most languages
- cmp: completion plugin (tap into nvim-lsp, copilot, snippets engines etc.)
- nvim-lsp: support for language server protocol, install them individually
- null-ls: support for non-lsp tools to hook into the lsp client 
```mermaid
flowchart LR
  cmp["cmp"]
  copilot["copilot"]
  not-lsp["Non LSP tools"]
  null-ls["Null LS"]
  nvim-lsp["nvim-lsp plugin"]
  regular-lsp["Regular LSP"]
  not-lsp --> null-ls
  null-ls --> nvim-lsp
  regular-lsp --> nvim-lsp
  nvim-lsp --> cmp
  copilot --> cmp
  luasnip --> cmp
  friendly-snippets --> luasnip
```

## Gist

`!h gist-vim` for help, tldr add a `~/.gist-vim` with `token xxx` in it, token
from gh with gist scope

### Reminders/mappings
Search + Replace all and save
> Telescope Grep to find the string project wise, CTRL+Q to add them all to the Quickfix list and then ‘:cdo s/StringOne/StringTwo/g | update’

__Cmp__
```
ctrl+space -> complete
ctrl+b -> scroll docs up
ctrl+f -> scroll docs down
enter -> confirm
```

__LSP__
Default behaviour of Ctrl n comes from that, we overload it inside cmp settings
[Improve completion popup menu | Vim Tips Wiki | Fandom](https://vim.fandom.com/wiki/Improve_completion_popup_menu)
```
H -> Hover information
gt -> Type definition
gs -> Signature
gd -> Definition
gr -> References
```

## Condas
TODO flake all that

Python distro

### install opts

miniconda install for apple silicon (to be able to run tensorflow), not handled
by nix/dotfiles for now, easier is to install miniforge, see this article
https://caffeinedev.medium.com/how-to-install-tensorflow-on-m1-mac-8e9b91d93706

### commands

```
# update conda itself
conda update -n base conda
# create an env
conda create -n <env> python=3.10
# update all package
conda update --all
# select a conda env
conda activate <env>
# deactivate
conda deactivate
# Install package
conda install -n mlpy311 numpy --update-deps --force-reinstall
conda install -n <env> numpy --update-deps --force-reinstall
```

## IAM & AWS

TODO move to different repo


`aws-infra` directory for the dets

Bootstrap `terraform` backend to store states and lockfiles of tf resources.
The backend is in `s3` + `dynamodb`
[tf-backend](aws-infra/tf-backend/README.md)

Additional resources created in `/tf-misc`
[tf-misc](aws-infra/tf-misc/tfdocs.md)

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

- [x] Fix gist vim 
- [x] test mermerd https://github.com/KarnerTh/mermerd -> good, add it on pproject basis
- [x] Cleanup gists
- [x] Configure fish and switch to it, bug with sensible-on-top switching back to /bin/zsh
- [x] install nix-darwin & start services like skhd/yabai
- [x] Tweak lsp mappings (refactoring & code actions?)
- [x] ~~Use `niv` to check-in dependencies (home-manager & nixpkgs) versions [GitHub - ryantm/home-manager-template: A quick-start template for using home-manager in a more reproducible way.](https://github.com/ryantm/home-manager-template) [How I Nix](https://eevie.ro/posts/2022-01-24-how-i-nix.html)~~ -> flake
- [ ] [latexindent](https://tex.stackexchange.com/questions/390433/how-can-i-install-latexindent-on-macos)
- [x] configure friendly snippets (rails...)
- [ ] Look at latex editor config with preview (saved in Pocket)
- [ ] editorconfig xdg
- [ ] markdown formatter
- [ ] switch algo for rsa key to ed25519
- [ ] https://github.com/danymat/neogen vs chatgpt plugin
- [ ] ~~Lsp for protobuf https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bufls~~
- [ ] explore https://golangexample.com/command-line-tool-to-help-you-use-conventional-commit-messages/ if cz flaky
- [ ] Conventional commit tooling, look at nvim/after/ftplugin/gitcommit.lua and add a cli? Cocogitto? https://github.com/cocogitto/cocogitto seehttps://golangexample.com/command-line-tool-to-help-you-use-conventional-commit-messages/ if cz flaky
- [ ] https://rsapkf.netlify.app/weblog/vim-tmux-italics
- [x] evaluate vsnips vs luasnip
- [ ] SFMono [Gh](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized)
- [x] branch -> mutli platform flake

