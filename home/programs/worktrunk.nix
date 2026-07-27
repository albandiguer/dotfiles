{ pkgs, ... }:
{
  # Worktrunk user configuration
  home.file.".config/worktrunk/config.toml".text = ''
    skip-commit-generation-prompt = false
  '';
}
