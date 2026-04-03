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
        startup_command = "nvim";
      };

      # Window layouts that can be reused across sessions
      window = [
        {
          name = "editor";
          startup_command = "nvim";
        }
        {
          name = "ai";
          startup_command = "opencode";
        }
        {
          name = "term";
          # No startup command - just a terminal
        }
      ];

      # Session configurations
      session = [
        {
          name = "dotfiles";
          path = "~/dev/dotfiles";
          startup_command = "nvim";
          windows = [
            "editor"
            "ai"
            "term"
          ];
        }
      ];

      # Wildcard config for projects under ~/dev only
      wildcard = [
        {
          pattern = "~/dev/*";
          startup_command = "nvim";
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
        "~/projects"
        "~/work"
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
