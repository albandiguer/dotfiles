# Brew/Nix: managed packages by machine

Everything on this machine is now declared in the config — nothing manual remains.

**Config layout:** `darwin/macbook.nix` = all machines · `specifics/alban.nix` = personal (Alban's MacBook Air) · `specifics/pretto.nix` = work (Prettos-MacBook-Pro)

**Rule:** if a package comes from Nix, it's not also installed via Brew.

## Packages

| Package | Config | Manager |
|---|---|---|
| archon | personal | Brew |
| httpie (CLI) | personal | Nix |
| httpie-desktop (GUI) | personal | Brew |
| podman | personal | Brew |
| qrencode | personal | Brew |
| sandvault | personal | Brew |
| bitwarden-cli | both | Nix |
| dash | both | Brew |
| font-sf-mono-nerd-font-ligaturized | both | Brew |
| gnupg (`gpg`) | both | Brew¹ |
| libpq | both | Brew |
| licecap | both | Brew |
| monitorcontrol | both | Brew |
| nixfmt | both | Brew |
| obsidian | both | Brew |
| podman-compose | both | Nix |
| podman-tui | both | Nix |
| quien | both | Brew |
| raycast | both | Brew |
| slack | both | Brew |
| tectonic | both | Brew |
| vips | both | Brew |
| 1password | work | Nix + Brew |
| bruno | work | Nix + Brew |
| claude | work | Nix + Brew |
| notion | work | Brew |

¹ gnupg stays in Brew even though Nix has a copy — brew `vips` depends on the brew gnupg (via gpgme/poppler); the Nix copy can't serve brew binaries.

## Removed

| Package | Why |
|---|---|
| postgresql@15 | stray direct install, nothing depended on it |
| open-mpi | stray direct install, nothing depended on it |
| bitwarden-cli (brew) | redundant — already a Nix package |
| bruno (this machine) | work-only app, kept only via `pretto.nix` |
| libyaml (brew) | Nix closure already has it (transitive dep), nothing in Brew depended on it |
| httpie (brew cask alias) | `httpie` cask was an alias of `httpie-desktop` — duplicate declaration |

## Taps

| Tap | Source |
|---|---|
| `coleam00/archon` | `specifics/alban.nix` `homebrew.taps`; pinned via nix-homebrew in `flake.nix` (all machines) |
| `retlehs/tap` | nix flake input (via nix-homebrew) |
| `shaunsingh/sfmono-nerd-font-ligaturized` | nix flake input (via nix-homebrew) |
| `homebrew/core`, `homebrew/cask`, `homebrew/bundle` | built-in — always kept |

## Policy

Manual installs are fine and expected — no auto-cleanup. `homebrew.onActivation.cleanup` stays at the default `"none"`.
