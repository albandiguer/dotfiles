{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;
  };
}
