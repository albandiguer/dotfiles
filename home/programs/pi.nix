{ ... }:
{
  # Pi — multi-provider LLM agent CLI (https://github.com/earendil-works/pi)
  # Registers the DeepSeek V4 models (not in Pi's static catalog yet).
  # Pi auto-resolves the credential from the DEEPSEEK_API_KEY env var —
  # do NOT add an `apiKey` field here, Pi treats it as a literal string
  # (no $VAR expansion).
  home.file.".pi/agent/models.json".text = builtins.toJSON {
    providers.deepseek = {
      api = "openai-completions";
      baseUrl = "https://api.deepseek.com";
      models = [
        {
          id = "deepseek-v4-pro";
          name = "DeepSeek V4 Pro";
          contextWindow = 1000000;
          maxTokens = 384000;
          input = [ "text" ];
          reasoning = true;
          compat = {
            requiresReasoningContentOnAssistantMessages = true;
            thinkingFormat = "deepseek";
          };
        }
        {
          id = "deepseek-v4-flash";
          name = "DeepSeek V4 Flash";
          contextWindow = 1000000;
          maxTokens = 384000;
          input = [ "text" ];
          reasoning = true;
          compat = {
            requiresReasoningContentOnAssistantMessages = true;
            thinkingFormat = "deepseek";
          };
        }
      ];
    };
  };
}
