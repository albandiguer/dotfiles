{ pkgs, lib, ... }:
# Pi — multi-provider LLM agent CLI (https://github.com/earendil-works/pi)
let
  # DeepSeek V4 models (absent from Pi's static catalog), without the apiKey:
  # Pi resolves the key itself (auth.json / env), and omitting it keeps the
  # secret out of the /nix/store and git.
  modelsTemplate = pkgs.writeText "pi-models.template.json" (
    builtins.toJSON {
      providers.deepseek = {
        api = "openai-completions";
        # baseUrl = "http://headroom.lab/v1";
        models = [
          {
            id = "deepseek-v4-pro";
            name = "DeepSeek V4 Pro";
            # Per-million-token USD rates (peak): cacheRead = cache-hit, cacheWrite = cache-miss.
            # ponytail: pi has no time-of-day pricing; off-peak is 50% cheaper, use peak here.
            cost = {
              input = 1.32;
              output = 3.96;
              cacheRead = 0.044;
              cacheWrite = 1.32;
            };

            contextWindow = 1000000;
            maxTokens = 384000;
            input = [ "text" ];
            reasoning = true;
            compat = {
              requiresReasoningContentOnAssistantMessages = true;
              thinkingFormat = "deepseek";
              # DeepSeek rejects the `developer` role; Pi otherwise sends it for
              # reasoning models on openai-completions endpoints (defaults true).
              supportsDeveloperRole = false;
            };
          }
          {
            id = "deepseek-v4-flash";
            name = "DeepSeek V4 Flash";
            # Per-million-token USD rates (peak): cacheRead = cache-hit, cacheWrite = cache-miss.
            # ponytail: pi has no time-of-day pricing; off-peak is 50% cheaper, use peak here.
            cost = {
              input = 0.44;
              output = 1.32;
              cacheRead = 0.014;
              cacheWrite = 0.44;
            };

            contextWindow = 1000000;
            maxTokens = 384000;
            input = [ "text" ];
            reasoning = true;
            compat = {
              requiresReasoningContentOnAssistantMessages = true;
              thinkingFormat = "deepseek";
              # DeepSeek rejects the `developer` role; Pi otherwise sends it for
              # reasoning models on openai-completions endpoints (defaults true).
              supportsDeveloperRole = false;
            };
          }
        ];
      };
    }
  );
in
{
  # Only for Archon: its bundled Pi SDK (unlike standalone Pi) requires a literal
  # inline apiKey for custom providers — no auth.json fallback, no $VAR expansion.
  # So inject the key from auth.json into models.json at activation.
  home.activation.piModelsJson = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    authFile="$HOME/.pi/agent/auth.json"
    out="$HOME/.pi/agent/models.json"
    if [ -f "$authFile" ]; then
      key="$(${pkgs.jq}/bin/jq -r '.deepseek.key // empty' "$authFile")"
      if [ -n "$key" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/.pi/agent"
        $DRY_RUN_CMD ${pkgs.jq}/bin/jq --arg k "$key" \
          '.providers.deepseek.apiKey = $k' \
          ${modelsTemplate} > "$out"
      else
        echo "pi.nix: warning: no .deepseek.key in $authFile — models.json not written" >&2
      fi
    else
      echo "pi.nix: warning: $authFile not found — models.json not written" >&2
    fi
  '';
}
