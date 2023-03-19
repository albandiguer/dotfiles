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
      shift + alt - h : yabai -m window --warp west
      shift + alt - j : yabai -m window --warp south
      shift + alt - k : yabai -m window --warp north
      shift + alt - l : yabai -m window --warp east

      # maximize a window
      shift + alt - m : yabai -m window --toggle zoom-fullscreen

      # balance out tree of windows (resize to occupy equal space)
      shift + alt - b : yabai -m space --balance

      # rotate layout
      shift + alt - r : yabai -m space --rotate 90

      # move windows prev/next space
      alt - h : yabai -m window --space prev; yabai -m window --focus west
      alt - l : yabai -m window --space next; yabai -m display --focus east

      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float;\
      yabai -m window --grid 4:4:1:1:2:2
    '';
  };
}
