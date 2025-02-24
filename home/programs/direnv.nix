{
  config,
  pkgs,
  lib,
  ...
}: {
  # INFO: to enable direnv to autostart nix-shell in directories
  # Create a file called .envrc in your project directory.
  # echo use_nix > .envrc
  # Then run:
  # direnv allow .
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      # optional for nix flakes support
    };
  };
}
