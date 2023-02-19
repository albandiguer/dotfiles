{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      # https://starship.rs/fr-FR/config/#invite

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
}
