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

Languages are being supported via few tools, `tree-sitter`, `native lsp` or `null-ls`. To configure them, change `config.vim` and `neovim.nix` + in `vim` use

- `:TSConfig` for `tree-sitter`

- `:Lsp<tab>`

- `:Null<tab>`

### Install an lsp

```
:LspInstall
```

then select in list, the server will start automatically when available

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
- Rewrite `config.vim` in `lua`
- [latexindent](https://tex.stackexchange.com/questions/390433/how-can-i-install-latexindent-on-macos)

## Condas

conda installed for apple silicon, not handled by nix/dotfiles for now
https://caffeinedev.medium.com/how-to-install-tensorflow-on-m1-mac-8e9b91d93706

# IAM & AWS

`aws-infra` directory for the dets

Bootstrap `terraform` backend to store states and lockfiles of tf resources.
The backend is in `s3` + `dynamodb`
[tf-backend](aws-infra/tf-backend/tfdocs.md)

Additional resources created in `/tf-misc`
[tf-misc](aws-infra/tf-misc/tfdocs.md)
