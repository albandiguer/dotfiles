{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = false;

    # https://github.com/budimanjojo/tmux.fish
  };
}
