This repo is to keep track of my config, and as a memo for the future. 

# IAM & AWS

 `aws-boilerplate-tf` direcotry for the details

The tf state is stored in s3 and state lock in dynamodb, as described in  `/backend`

To modify the aws config, modify the badly named `/stack` directory

## `IAM` config as following

| IAM user | Role  |
| -------- | ----- |
| alban    | admin |
| dev      | dev   |

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

## LSPs

### Install an lsp

```
:LspInstall
```

then select in list, the server will start automatically when available

### Thoughts on Built-in LSP, ALE, Completion, linting, fixing ...

Neovim comes with Built-in LSP support. LSPs include linting and fixing
capabilities for some. Not all linters are LSP however, like prettier so we disable LSP
built-in linting and let ALE do the linting and fixing for now.

```nix
" Disable diagnostic from neovim built in lsp, ALE does the job
autocmd BufEnter * lua vim.diagnostic.disable()
```

and turned off ALE completion

```vim
let g:ale_completion_enabled = 0
```

Some filetypes should leverage completion from different LSPs depending on the
project. For example, typescript files can be using tsserver or denols.

Specific code added for that in `neovim.nix`, if the root has a `deno.json`
file we load denols

[denoland issue](https://github.com/denoland/deno/issues/13228)

```nix
-- (optional) Customize the options passed to the server
if server.name == "denols" then
    -- opts.root_dir = function() ... end
    -- NOTE: what is nvim_lsp
    opts.root_dir = nvim_lsp.util.root_pattern("deno.json")
end
```

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
