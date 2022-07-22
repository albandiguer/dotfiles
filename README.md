my config in case the computer burns

# IAM & AWS

`aws-infra` directory for the details

We bootstrap a `terraform` backend to store the state and lock of tf resources. The backend is currently in `s3` and `dynamodb`
[tf-backend](aws-infra/tf-backend/tfdocs.md)

Additional resources created in `/tf-misc`
[tf-misc](aws-infra/tf-misc/tfdocs.md)

# Nix based dotfiles

## Setup

symlink `nixfiles` directory to `~/.config/nixpkgs`

```
 ln -s ~/dev/dotfiles/nixfiles ~/.config/nixpkgs
```

## BAU commands

Apply changes to home-manager config

```shell
make
```

Update environment and deps with

```shell
make update
```

Prefetch a package

```shell
nix-prefetch-git url
```

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

- [ ] [latexindent](https://tex.stackexchange.com/questions/390433/how-can-i-install-latexindent-on-macos)

- [x] Consider remonving ALE and do everything with Built-in LSP client

## Condas

conda installed for apple silicon, not handled by nix/dotfiles for now
https://caffeinedev.medium.com/how-to-install-tensorflow-on-m1-mac-8e9b91d93706
