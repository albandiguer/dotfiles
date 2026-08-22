# Package Split Inconsistencies

Split of packages between `darwin/macbook.nix` (systemPackages) and
`home/users/albandiguer/home.nix` (home.packages).

**Rule of thumb:** default to `home.packages` unless a package needs
system-wide visibility (services, other users, boot context, root). Only the
container/VM/service tooling genuinely needs systemPackages.

## Findings

| #   | Package                                | Issue                                                                 | Fix                                                         |
| --- | -------------------------------------- | --------------------------------------------------------------------- | ----------------------------------------------------------- |
| 1   | `gitmux`                               | Binary in systemPackages, but `.gitmux.conf` lives in home files      | Move binary to home.packages                                |
| 2   | `lazydocker` (system) vs `dive` (home) | Same job (docker inspection), different layers                        | Move `lazydocker` to home.packages                          |
| 3   | `bitwarden-desktop`                    | Still listed in systemPackages, comment says "moved to homebrew cask" | Delete dead entry                                           |
| 5   | `sshed`                                | Pure CLI tool, no system need                                         | Move to home.packages                                       |
| 6   | `bitwarden-cli`                        | Pure CLI tool, no system need                                         | Move to home.packages                                       |
| 7   | `marp-cli`                             | Pure CLI tool, no system need                                         | Move to home.packages                                       |
| 8   | `sox`                                  | User-level (whisper-dictation dep)                                    | Move to home.packages                                       |
| 9   | `rtk`                                  | User-level                                                            | Move to home.packages                                       |
| 10  | `awslogs`                              | User-level                                                            | Move to home.packages                                       |

## Justified in systemPackages (keep)

- `lima` — VMs
- `cloudflared` — can run as a system service
- `butane` — infra tooling

Moved to personal (`specifics/alban.nix`): `podman-compose`,
`podlet`, `k3d`, `quadlet-lsp`.
Moved to work (`specifics/pretto.nix`): `ssm-session-manager-plugin`.

## Cross-layer & doc inconsistencies

| #   | Item                             | Issue                                                                                                                                                                                                                 | Fix                                                                                |
| --- | -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| 14  | `bruno`                          | Declared in both `specifics/alban.nix` and `specifics/pretto.nix` — identical, machine-agnostic                                                                                                                       | Move to `darwin/macbook.nix` (or home.packages) since it's on every machine        |
| 17  | `misc/fonts/` (BlexMono)         | Hand-patched nerd font installed manually, while every other font is `nerd-fonts.*` in home.packages. Root `fonts/` dir is empty leftover (in/out)                                                                    | Move BlexMono to home.packages if it's still used, delete `fonts/` dir             |
| 18  | `docs/brew-managed-vs-manual.md` | Table lists `httpie` (GUI, personal cask) and `qrencode` (personal brew) — neither is in any Brewfile; qrencode is now in nix home.packages (contradicts the doc's own "one source" rule)                             | Update doc: drop httpie/qrencode rows, note qrencode moved to nix                  |

## Dangling references & dead config

| #   | Item                   | Issue                                                                                                                                                                                                           | Fix                                                                                    |
| --- | ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| 19  | `diffity`              | Referenced by fish abbr `dt = "diffity"` and claude.nix permission `Bash(diffity *)`, but installed nowhere (no nix/brew/mise entry)                                                                            | Install it or drop the abbr + permission                                               |
| 20  | `docker`               | Fish abbrs `dk`/`dkc`/`dkcd`/`dkcud` target `docker`/`docker compose`, but docker is declared nowhere — the stack is podman                                                                                     | Point at `podman` or confirm the podman docker shim is active                          |
| 21  | `python`               | Fish abbr `interpret` = `mise x python@3.11`, abbr `prettyjson` = `python -m json.tool`, and `.default-python-packages` file — but python is not a mise tool (uv manages it now)                                | Drop `interpret`, use `uv run`, delete `.default-python-packages` if uv is the manager |
| 22  | `direnv`               | `programs.direnv.enable = false` but `nix-direnv.enable = true` (no-op without direnv); flake overlay patches direnv that's disabled; macbook.nix comment "in home-manager" but home-manager direnv is also off | Enable direnv everywhere, or delete direnv.nix + overlay                               |
| 23  | `zsh`                  | `home/programs/zsh/default.nix` is not imported (home.nix has `# ../../zsh`) and has `enable = false` — dead file; macbook.nix enables system zsh but sets fish as the user shell                               | Delete the zsh module, or import and enable it                                         |
| 24  | `vscode`               | `programs.vscode.enable = false` but module is imported with a full extension list — dead config                                                                                                                | Delete vscode.nix or enable it                                                         |
| 26  | Makefile `rollback`    | `nix-env --rollback` does nothing for nix-darwin/home-manager (no nix-env profile in use); AGENTS.md advertises `make rollback` as the rollback path                                                            | Use `darwin-rebuild --rollback` / `home-manager switch --rollback`                     |

## Open questions

- `mise.nix` has `uv = "latest"; # shall it be in nix instead?` — decide; if yes, move to home.packages and let mise manage only versioned tools.
