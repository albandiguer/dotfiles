{
  pkgs,
  lib,
  config,
  ...
}:
# Pi CLI (https://github.com/earendil-works/pi). Models live in ./pi/models.json
# without the apiKey — Pi resolves it from auth.json/env, keeping it out of the
# store and git. Costs there are peak USD/M tokens (pi has no off-peak pricing).
{
  # Symlinked into the repo so pi's writes (Ctrl+S, lastChangelogVersion) land
  # in the dotfiles working tree.
  home.file.".pi/agent/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/albandiguer/dev/dotfiles/home/programs/pi/settings.json";

  # Tool permissions: deny git commit/push so commits are made by hand.
  home.file.".pi/agent/permissions.json".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/albandiguer/dev/dotfiles/home/programs/pi/permissions.json";

  # Archon's bundled Pi SDK needs a literal inline apiKey (no auth.json/env
  # fallback), so inject it from auth.json at activation.
  home.activation.piModelsJson = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    authFile="$HOME/.pi/agent/auth.json"
    out="$HOME/.pi/agent/models.json"
    if [ -f "$authFile" ]; then
      key="$(${pkgs.jq}/bin/jq -r '.deepseek.key // empty' "$authFile")"
      if [ -n "$key" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/.pi/agent"
        $DRY_RUN_CMD ${pkgs.jq}/bin/jq --arg k "$key" \
          '.providers.deepseek.apiKey = $k' \
          ${./pi/models.json} > "$out"
      else
        echo "pi.nix: warning: no .deepseek.key in $authFile — models.json not written" >&2
      fi
    else
      echo "pi.nix: warning: $authFile not found — models.json not written" >&2
    fi
  '';
}
