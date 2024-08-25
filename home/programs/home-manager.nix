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

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Tomorrow Night",
        font = wezterm.font("JetBrains Mono"),
        font_size = 15.0,
        window_background_gradient = {
          colors = { '#EEBD89', '#D13ABD' },
          interpolation = 'Linear',
          orientation = { Linear = { angle = -45.0 } },
        }
      };
    '';
  };
}
