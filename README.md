# Nix based dotfiles

Apply changes

```shell
home-manager switch
```

Update environment with

```shell
nix-channel --update
home-manager switch
```

Prefetch a package

```shell
nix-prefetch-github owner repo
```

Fix latexindent
https://tex.stackexchange.com/questions/390433/how-can-i-install-latexindent-on-macos

## Memo

### Install an lsp

```
:LspInstall
```

then select in list, the server will start automatically when available

### Completion

Coq shortcut to display completions is Ctrl-space. Once in the panel, tab goes to next item
Use :Copilot for AI generation
