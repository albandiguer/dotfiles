# Package Split Inconsistencies

Split of packages between `darwin/macbook.nix` (systemPackages) and
`home/users/albandiguer/home.nix` (home.packages).

**Rule of thumb:** default to `home.packages` unless a package needs
system-wide visibility (services, other users, boot context, root). Only the
container/VM/service tooling genuinely needs systemPackages.

## Justified in systemPackages (keep)

- `lima` — VMs
- `cloudflared` — can run as a system service

Moved to personal (`specifics/alban.nix`): `podman-compose`,
`podlet`, `k3d`, `quadlet-lsp`, podman `dk*` abbrs.
Moved to work (`specifics/pretto.nix`): `ssm-session-manager-plugin`,
docker `dk*` abbrs.
Moved to home.packages: `sshed`, `bitwarden-cli`, `bitwarden-desktop`,
`sox`, `rtk`, `awslogs`, `butane`
(`gitmux`, `marp-cli`, `lazydocker` deleted).

## Cross-layer & doc inconsistencies

| #   | Item                             | Issue                                                                                                                                                                                                                 | Fix                                                                                |
| --- | -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| 14  | `bruno`                          | Declared in both `specifics/alban.nix` and `specifics/pretto.nix` — identical, machine-agnostic                                                                                                                       | Move to `darwin/macbook.nix` (or home.packages) since it's on every machine        |
| 17  | `misc/fonts/` (BlexMono)         | Hand-patched nerd font installed manually, while every other font is `nerd-fonts.*` in home.packages. Root `fonts/` dir is empty leftover (in/out)                                                                    | Move BlexMono to home.packages if it's still used, delete `fonts/` dir             |
| 18  | `docs/brew-managed-vs-manual.md` | Table lists `httpie` (GUI, personal cask) and `qrencode` (personal brew) — neither is in any Brewfile; qrencode is now in nix home.packages (contradicts the doc's own "one source" rule)                             | Update doc: drop httpie/qrencode rows, note qrencode moved to nix                  |

## Dangling references & dead config

| #   | Item       | Issue                                                                                                                                                                                                           | Fix                                                                                    |
| --- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| 19  | `diffity`  | Referenced by fish abbr `dt = "diffity"` and claude.nix permission `Bash(diffity *)`, but installed nowhere (no nix/brew/mise entry)                                                                            | Install it or drop the abbr + permission                                               |
| 21  | `python`   | Fish abbr `interpret` = `mise x python@3.11`, abbr `prettyjson` = `python -m json.tool`, and `.default-python-packages` file — but python is not a mise tool (uv manages it now)                                | Drop `interpret`, use `uv run`, delete `.default-python-packages` if uv is the manager |
| 22  | `direnv`   | `programs.direnv.enable = false` but `nix-direnv.enable = true` (no-op without direnv); flake overlay patches direnv that's disabled; macbook.nix comment "in home-manager" but home-manager direnv is also off | Enable direnv everywhere, or delete direnv.nix + overlay                               |

## Open questions

- `mise.nix` has `uv = "latest"; # shall it be in nix instead?` — decide; if yes, move to home.packages and let mise manage only versioned tools.
