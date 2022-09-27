# Nix based dotfiles

## Setup

Install `nix` and `home-manager`

symlink `nixfiles` directory to `~/.config/nixpkgs`

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

## Languages

### Languages

Languages are being supported in NeoVim with few tools, `tree-sitter`, `cmp` and `nvim_lsp`



![diag1](./docs/images/Untitled-2022-09-25-1426.svg)



### Nix flakes config

Added a config file in ~/.config/nix/nix.conf

```nix
experimental-features = nix-command flakes
```

## Todos

- Use `niv` to check-in dependencies (home-manager & nixpkgs) versions
  https://github.com/ryantm/home-manager-template
  https://eevie.ro/posts/2022-01-24-how-i-nix.html
- Remove ack-vim and related config in `config.vim` remap grrep built-in to ag command
- Switch from `NERDTree` to `Nvim Tree` https://github.com/kyazdani42/nvim-tree.lua (nixpkgs nvim-tree-lua)
- Rewrite `config.vim` in `lua` https://github.com/nanotee/nvim-lua-guide, look at this dotfiles https://github.com/elianiva/dotfiles
- [latexindent](https://tex.stackexchange.com/questions/390433/how-can-i-install-latexindent-on-macos)

## Condas

conda installed for apple silicon (to be able to run tensorflow), not handled
by nix/dotfiles for now
https://caffeinedev.medium.com/how-to-install-tensorflow-on-m1-mac-8e9b91d93706

# IAM & AWS

`aws-infra` directory for the dets

Bootstrap `terraform` backend to store states and lockfiles of tf resources.
The backend is in `s3` + `dynamodb`
[tf-backend](aws-infra/tf-backend/tfdocs.md)

Additional resources created in `/tf-misc`
[tf-misc](aws-infra/tf-misc/tfdocs.md)

# Tmux key mapping

to select sessions named such as `<M-a>` in tmux sessions list selection.
We change the profile in iterm2 keys> keys config

```
Right option key : Esc+
```

# TODOs

- XXX urgent singleton precondition in after/ftplugin -- in lua
- XXX evaluate devcontainers vs lspcontainers.nvim https://github.com/lspcontainers/lspcontainers.nvim
- TODO lsp for dockerfiles
- TODO Conventional commit tooling, look at nvim/after/ftplugin/gitcommit.lua and add a cli? Cocogitto? https://github.com/cocogitto/cocogitto
- TODO Re-enable github copilot
- TODO Tweak lsp suggestions, start with Ruby
- TODO Convert to init.vim to lua.vim https://www.youtube.com/watch?v=rUvjkBuKua4
- TODO Remove ack and do everything with grep/ag, https://www.google.com/search?client=firefox-b-d&q=vim+grep+open+quickfix+automatically, interesting read here https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
- TODO Switch tmux session with fzf or Telescope https://github.com/camgraff/telescope-tmux.nvim
- TODO Add conventional commits
- TODO Fix gist vim & remove gists
- NOTE explore https://golangexample.com/command-line-tool-to-help-you-use-conventional-commit-messages/ if cz flaky
