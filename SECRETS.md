# Secret Management

API tokens are stored in macOS Keychain and loaded into the shell environment at startup. No plaintext secrets on disk.

## Architecture

```
[1Password (work)]    ──┐
                        ├── secrets-refresh ──> [macOS Keychain] ──> [Fish env vars]
[Bitwarden (personal)]──┘
```

Keychain is local, so secrets are available **offline** (on the train, etc.).

## Managed secrets

| Variable | Source | Path / item name |
|---|---|---|
| `ANTHROPIC_API_KEY` | 1Password | `op://Work/Dev API Keys/ANTHROPIC_API_KEY` |
| `SNYK_TOKEN` | 1Password | `op://Work/Dev API Keys/SNYK_TOKEN` |
| `DEEPSEEK_API_KEY` | Bitwarden | `Deepseek API Key` (password field) |

> Adjust paths/item names in `home/programs/fish/default.nix` → `secrets-refresh` if your vault structure differs.

## Fish functions

Both functions are defined in `home/programs/fish/default.nix` and managed by Nix.

### `secrets-refresh`

Pulls keys from 1Password and Bitwarden and writes them into Keychain. Run this manually on first setup or after rotating a token.

```fish
secrets-refresh
```

- Requires `op` (1Password CLI) signed in for work keys
- Prompts for Bitwarden master password for personal keys
- Uses `security add-generic-password -U` — safe to re-run, updates existing entries
- Prints `✓` / `✗` per key so you can see what was fetched

### `secrets-load`

Reads keys from Keychain into env vars. Called automatically in `interactiveShellInit` — no manual action needed.

```fish
secrets-load   # normally runs automatically on shell start
```

## First-time setup on a new machine

```fish
# 1. Apply config
make apply

# 2. Pull secrets from password managers into local Keychain
secrets-refresh

# 3. Verify a key landed in Keychain
security find-generic-password -a $USER -s ANTHROPIC_API_KEY -w

# 4. Open a new shell and verify the env var is set
echo $ANTHROPIC_API_KEY
```

## After rotating a token

```fish
secrets-refresh   # updates Keychain; takes effect in the next shell
```

## Adding a new secret

1. Add a `security add-generic-password` call for the new key in the `secrets-refresh` function body in `home/programs/fish/default.nix`
2. Add the key name to the `keys` list in `secrets-load`
3. Run `make apply`, then `secrets-refresh`
