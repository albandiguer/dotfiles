{ config, ... }:
let
  # Inferred from home-manager profile where claude-code is installed
  claudeBinPath = "${config.home.profileDirectory}/bin/claude";
in
{
  # Archon — AI agent orchestration tool
  # https://github.com/coleam00/Archon
  home.file = {
    ".archon/config.yaml".text = # yaml
      ''
        assistants:
          claude:
            claudeBinaryPath: ${claudeBinPath}
          pi:
            model: deepseek/deepseek-v4-pro

        # Model tiers — remap bundled workflows' small/medium/large refs (tier
        # provider wins over the workflow's pinned provider, per Archon docs).
        # Pro = architecture/planning, Flash = implementation and cheap tasks.
        tiers:
          large: { provider: pi, model: deepseek/deepseek-v4-pro }
          medium: { provider: pi, model: deepseek/deepseek-v4-flash }
          small: { provider: pi, model: deepseek/deepseek-v4-flash }
      '';
  };
}
