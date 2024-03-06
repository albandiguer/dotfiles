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
      alt + cmd - h : yabai -m window --warp west
      alt + cmd - l : yabai -m window --warp east
      alt + cmd - k : yabai -m window --warp north
      alt + cmd - j : yabai -m window --warp south

      # maximize a window
      alt + cmd - f : yabai -m window --toggle zoom-fullscreen

      # balance out tree of windows (resize to occupy equal space)
      alt + cmd - b : yabai -m space --balance

      # rotate layout
      alt + cmd - r : yabai -m space --rotate 90

      # move windows prev/next space
      alt + cmd - left : yabai -m window --space prev; yabai -m window --focus west
      alt + cmd - right : yabai -m window --space next; yabai -m display --focus east


      # float / unfloat window and center on screen
      alt + cmd - t : yabai -m window --toggle float;\
      yabai -m window --grid 4:4:1:1:2:2
    '';
  };
}
