{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    # `ghostty` (source) is linux-only; the darwin build is ghostty-bin
    package = pkgs.ghostty-bin;
    settings = {
      # https://ghostty.org/docs/config/reference
      # matches home/programs/wezterm/wezterm.lua
      font-family = "VictorMono Nerd Font";
      font-style = "SemiBold";
      font-size = 16;
    };
  };
}
