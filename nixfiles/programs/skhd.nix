{
  config,
  pkgs,
  lib,
  ...
}: {
  # See this blog here
  # Copied from https://cmacr.ae/post/2020-05-13-yabai-module-in-nix-darwin-now-generally-available/

  # See this config as well https://github.com/DanielCardonaRojas/dotfiles/blob/master/.config/yabai/yabairc

  # This guy seems to make it work
  # https://github.com/breuerfelix/dotfiles/blob/main/darwin/yabai.nix
  home.file.skhdrc = {
    executable = false;
    target = ".skhdrc";
    text = ''
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east

      alt - r : yabai -m space --rotate 90

      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float;\
      yabai -m window --grid 4:4:1:1:2:2
    '';
  };
}
