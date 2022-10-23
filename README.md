# 📺 Nix based dotfiles

## Setup

Install `nix` and `home-manager`

Symlink `nixfiles` to `~/.config/nixpkgs`

```
 ln -s ~/dev/dotfiles/nixfiles ~/.config/nixpkgs
```

## BAU commands

Update environment and deps with

```shell
make update
```

Apply changes to home-manager config

```shell
make
```

Prefetch a package

```shell
nix-prefetch-git url
```

**protip**: to figure sha256, can also run `make` with a wrong sha and it will give the right one

## Neovim

### Languages Support

Languages are being supported in NeoVim with few tools, `tree-sitter`, `cmp` and `nvim_lsp`

![diag1](./docs/images/Untitled-2022-09-25-1426.svg)

### Shortcuts

#### Completion - CMP

```
ctrl+space -> complete
ctrl+b -> scroll docs up
ctrl+f -> scroll docs down
enter -> confirm
```

#### LSP

Default behaviour of Ctrl n comes from that, we overload it inside cmp settings

[Improve completion popup menu | Vim Tips Wiki | Fandom](https://vim.fandom.com/wiki/Improve_completion_popup_menu)

```
H -> Hover information
gt -> Type definition
gs -> Signature
gd -> Definition
gr -> References

```

## Nix flakes config

Added a config file in ~/.config/nix/nix.conf

```nix
experimental-features = nix-command flakes
```

## Condas

conda installed for apple silicon (to be able to run tensorflow), not handled
by nix/dotfiles for now
https://caffeinedev.medium.com/how-to-install-tensorflow-on-m1-mac-8e9b91d93706

## IAM & AWS

`aws-infra` directory for the dets

Bootstrap `terraform` backend to store states and lockfiles of tf resources.
The backend is in `s3` + `dynamodb`
[tf-backend](aws-infra/tf-backend/tfdocs.md)

Additional resources created in `/tf-misc`
[tf-misc](aws-infra/tf-misc/tfdocs.md)

## Tmux

### Keys

Select sessions named such as `<M-a>` in tmux sessions list selection.
We change the profile in iterm2 keys> keys config

```
Right option key : Esc+
```

## Todos

-  Fix gist vim & remove gists
-  Re-enable github copilot
-  Tweak lsp mappings (refactoring & code actions?)
-  Conventional commit tooling, look at nvim/after/ftplugin/gitcommit.lua and add a cli? Cocogitto? https://github.com/cocogitto/cocogitto seehttps://golangexample.com/command-line-tool-to-help-you-use-conventional-commit-messages/ if cz flaky
- Use `niv` to check-in dependencies (home-manager & nixpkgs) versions [GitHub - ryantm/home-manager-template: A quick-start template for using home-manager in a more reproducible way.](https://github.com/ryantm/home-manager-template) [How I Nix](https://eevie.ro/posts/2022-01-24-how-i-nix.html)
- [latexindent](https://tex.stackexchange.com/questions/390433/how-can-i-install-latexindent-on-macos)
- configure friendly snip (rails...)
- Look at latex editor config with preview (saved in Pocket)
