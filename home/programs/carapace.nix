{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
  };
}
