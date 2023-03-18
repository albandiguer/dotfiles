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
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # global settings
      yabai -m config mouse_follows_focus          off
      yabai -m config focus_follows_mouse          off
      yabai -m config window_placement             second_child
      yabai -m config window_topmost               off
      yabai -m config window_opacity               off
      yabai -m config window_opacity_duration      0.0
      yabai -m config window_shadow                off
      yabai -m config window_border                on
      yabai -m config window_border_width          0
      yabai -m config active_window_border_color 0xFF40FF00
      yabai -m config normal_window_border_color 0x00FFFFFF


      yabai -m config active_window_opacity        1.0
      yabai -m config normal_window_opacity        0.90
      yabai -m config split_ratio                  0.50
      yabai -m config auto_balance                 off
      yabai -m config mouse_modifier               fn
      yabai -m config mouse_action1                move
      yabai -m config mouse_action2                resize

      # general space settings
      yabai -m config layout                       bsp
      yabai -m config top_padding                  3
      yabai -m config bottom_padding               3
      yabai -m config left_padding                 3
      yabai -m config right_padding                3
      yabai -m config window_gap                   3

      echo "yabai configuration loaded.."
    '';
  };
}