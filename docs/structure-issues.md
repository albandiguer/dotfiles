# Folder Structure Issues

Findings from a review of the repo layout. The skeleton (darwin/ + home/programs/ + homebrew/ + specifics/) is the standard nix-darwin flake pattern and is fine. The issues below are concrete dead-ends and stale duplicates, not structural redesign.

## Fix

| # | Issue | Fix |
| - | ----- | --- |
| 1 | `fonts/` is a stale duplicate of `misc/fonts/` — gitignored, empty `out/`, and README's docker patcher command points at `~/dev/dotfiles/fonts/in` (wrong path) | Delete `fonts/`, update README to `misc/fonts` |
| 2 | `result` symlink (nix build artifact → `/nix/store`) is committed | Add to `.gitignore`, `git rm --cached result` |
| 3 | `home/programs/sops/` — zero references anywhere, not imported | Delete |
| 4 | `home/programs/zsh/` — import commented out in home.nix (stale path `../../zsh`) | Delete or re-enable |
| 5 | `home/dotfiles/.agents/hooks/` + `.agents/plugins/` — `.keep` placeholders, nothing loads them | Delete |

## Cosmetic

- `darwin/macbook.nix` is the *shared* module for both machines — "macbook" misleads. Rename to `darwin/default.nix` (update `flake.nix` reference).

## Keep as-is

- `misc/` grab-bag (iterm2/raycast/scripts/fonts) — legitimate "no nix integration" bucket.
- `specifics/*.nix` + `Brewfile.<hostname>` dual machine split — different layers, both correct.
- `home/programs/` mixed single-file vs dir modules — organic, fine.
- System-vs-user package split — content problem, tracked separately in `docs/package-split-inconsistencies.md`.
