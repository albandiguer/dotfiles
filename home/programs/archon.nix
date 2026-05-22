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
      '';
  };
}
