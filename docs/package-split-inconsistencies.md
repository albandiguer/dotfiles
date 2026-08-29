# Package Split Inconsistencies

Split of packages between `darwin/macbook.nix` (systemPackages) and
`home/users/albandiguer/home.nix` (home.packages).

**Rule of thumb:** default to `home.packages` unless a package needs
system-wide visibility (services, other users, boot context, root). Only the
container/VM/service tooling genuinely needs systemPackages.

## Justified in systemPackages (keep)

- `lima` — VMs
- `cloudflared` — can run as a system service

## Open items

| #  | Item                             | Issue                                                                                                                                                                                                                 | Fix                                                                                |
| -- | -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| 1  | `python`   | Fish abbr `interpret` = `mise x python@3.11`, abbr `prettyjson` = `python -m json.tool`, and `.default-python-packages` file — but python is not a mise tool (uv manages it now)                                | Drop `interpret`, use `uv run`, delete `.default-python-packages` if uv is the manager |
| 2  | Makefile `up`            | `up` calls `make apply` which already runs `brew bundle` (both Brewfiles), then `up` re-runs them — duplicated                           | `up` can just call `make apply` and drop the re-runs   |
| 3  | claude.nix permissions   | Every `rtk <cmd>` allow entry has a `rtk proxy <cmd>` twin (13 of 29 entries are proxied variants)                                          | Check if `rtk proxy` is still used; if not, halve list |

## Open questions

- `mise.nix` has `uv = "latest"; # shall it be in nix instead?` — decide; if yes, move to home.packages and let mise manage only versioned tools.
