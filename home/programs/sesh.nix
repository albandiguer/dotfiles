{ pkgs, ... }:
{
  programs.sesh = {
    enable = true;
    enableAlias = true;
    enableTmuxIntegration = true;
    tmuxKey = "s";
    icons = true;

    settings = {
      # Default session configuration (table format)
      default_session = {
        windows = [
          "editor"
          "ai"
          "term"
        ];
      };

      # Window layouts that can be reused across sessions
      window = [
        {
          name = "editor";
          startup_command = "nvim -c :Telescope find_files";
        }
        {
          name = "ai";
          startup_command = ''
            exec ${"\${DEFAULT_AI_AGENT:-opencode}"}
          '';
        }
        {
          name = "term";
          startup_command = "ls";
          # No startup command - just a terminal
        }
      ];

      # Wildcard config for projects
      wildcard = [
        {
          pattern = "~/dev/**/*";
          windows = [
            "editor"
            "ai"
            "term"
          ];
        }
      ];

      # Session root directories to scan
      root = [
        "~/dev"
      ];

      # Exclude patterns
      exclude = [
        ".git"
        "node_modules"
        ".Trash"
      ];
    };
  };

  # Generate Fish completion for sesh
  home.file.".config/fish/completions/sesh.fish".source =
    pkgs.runCommand "sesh-fish-completion" { }
      ''
        ${pkgs.sesh}/bin/sesh completion fish > $out
      '';
}
