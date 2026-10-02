# Brew: managed via Brewfile (homebrew-bundle)

Homebrew deps are declared in `Brewfile` files, not in Nix. `make apply` runs `brew bundle` for
the common `Brewfile` plus the machine-specific `Brewfile.<hostname>`.

**Layout:** `homebrew/`
- `homebrew/Brewfile` — all machines
- `homebrew/Brewfile.Albans-MacBook-Air` — personal
- `homebrew/Brewfile.Prettos-MacBook-Pro` — work

**Rule:** if a package comes from Nix, it's not also installed via Brew. The Brewfiles are the
source of truth for what's installed — don't mirror the list here.

**Exception:** `gpg` stays in Brew even though Nix has a copy: brew `vips` links against brew
`gpgme`/`poppler`, which can't use the Nix gnupg.

## Policy

Manual installs are fine and expected — no auto-cleanup (`brew bundle cleanup` is never run;
remove the entry from the Brewfile and `brew uninstall` manually to drop something).
