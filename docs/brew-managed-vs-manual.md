# Brew: managed via Brewfile (homebrew-bundle)

Homebrew dependencies are declared in `Brewfile` files, not in Nix. `make apply` runs `brew bundle` for the common `Brewfile` plus the machine-specific `Brewfile.<hostname>` if present.

**Layout:** `homebrew/` directory at repo root:
- `homebrew/Brewfile` — all machines (`darwin/default.nix` equivalent)
- `homebrew/Brewfile.Albans-MacBook-Air` — personal (`specifics/alban.nix` equivalent)
- `homebrew/Brewfile.Prettos-MacBook-Pro` — work (`specifics/pretto.nix` equivalent)

**Rule:** if a package comes from Nix, it's not also installed via Brew.

## Packages

| Package | File | Type |
|---|---|---|
| archon | personal | brew |
| podman | personal | brew |
| sandvault | personal | brew |
| dash | both | cask |
| font-sf-mono-nerd-font-ligaturized | both | cask |
| gnupg (`gpg`) | both | brew¹ |
| libpq | both | brew |
| licecap | both | cask |
| monitorcontrol | both | cask |
| nixfmt | both | brew |
| obsidian | both | cask |
| quien | both | brew |
| raycast | both | cask |
| slack | both | cask |
| tectonic | both | brew |
| vips | both | brew |
| 1password | work | cask |
| notion | work | cask |

¹ gnupg stays in Brew even though Nix has a copy — brew `vips` depends on the brew gnupg (via gpgme/poppler); the Nix copy can't serve brew binaries.

## Taps

| Tap | Where |
|---|---|
| `coleam00/homebrew-archon` | `homebrew/Brewfile.Albans-MacBook-Air` |
| `homebrew/core`, `homebrew/cask`, `homebrew/bundle` | built-in — always kept |

> `retlehs/tap` (quien) and the sfmono-nerd-font tap were dropped — quien migrated to homebrew/core and the font cask to homebrew/cask.

## Policy

Manual installs are fine and expected — no auto-cleanup (`brew bundle cleanup` is never run; remove an entry from the Brewfile and `brew uninstall` manually if you want it gone).
