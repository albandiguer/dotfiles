{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.mise = {
    enable = true;
  };
}
