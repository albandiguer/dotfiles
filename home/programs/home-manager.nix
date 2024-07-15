{
  config,
  pkgs,
  lib,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # TODO: extract
  programs.alacritty = {
    enable = true;
    settings = {
      # Change font to monaco nerd font
      font = {
        family = "Monaco Nerd Font Mono";
        size = 15;
      };
    };
  };
}
