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

      # load scripting addition
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      # bar configuration
      yabai -m config external_bar all:39:0
      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"

      # borders
      yabai -m config window_border on
      yabai -m config window_border_width 2
      yabai -m config window_border_radius 0
      yabai -m config window_border_blur off
      yabai -m config active_window_border_color 0xFF40FF00
      yabai -m config normal_window_border_color 0x00FFFFFF
      yabai -m config insert_feedback_color 0xffd75f5f

      yabai -m config window_shadow off

      # layout
      yabai -m config layout bsp
      yabai -m config auto_balance off
      yabai -m config window_topmost on

      # gaps
      # yabai -m config top_padding    0
      # yabai -m config bottom_padding 0
      # yabai -m config left_padding   0
      # yabai -m config right_padding  0
      # yabai -m config window_gap     0

      # rules
      yabai -m rule --add app="^System Preferences$" manage=off

      # workspace management
      yabai -m space 1 --label term
      yabai -m space 2 --label code
      yabai -m space 3 --label www
      yabai -m space 4 --label chat
      yabai -m space 5 --label todo
      yabai -m space 6 --label music
      yabai -m space 7 --label seven
      yabai -m space 8 --label eight
      yabai -m space 9 --label nine
      yabai -m space 10 --label ten

      # assign apps to spaces
      yabai -m rule --add app="Tmux" space=term
      yabai-m rule --add app="Visual Studio Code" space=code
      yabai -m rule --add app="Vivaldi" space=www
      yabai -m rule --add app="Google Chrome" space=seven
      yabai -m rule --add app="Microsoft Teams" space=chat
      yabai -m rule --add app="Slack" space=chat
      yabai -m rule --add app="Signal" space=chat
      yabai -m rule --add app="Spotify" space=music
      yabai -m rule --add app="Todoist" space=todo

      echo "yabai configuration loaded.."
    '';
  };
}
