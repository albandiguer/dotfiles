{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    # `ghostty` (source) is linux-only; the darwin build is ghostty-bin
    package = pkgs.ghostty-bin;
    settings = {
      # https://ghostty.org/docs/config/reference
      font-family = "VictorMono Nerd Font";
      font-style = "SemiBold";
      font-size = 15;
      adjust-cell-height = "20%";
    };
  };
}
