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
