{
  config,
  pkgs,
  lib,
  ...
}: {
  # enable direnv to autostart nix-shell in directories
  # Create a file called .envrc in your project directory.
  # echo use_nix > .envrc
  # OR use lorri init to start a new config file
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
