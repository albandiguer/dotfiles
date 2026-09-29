{ ... }:
{
  programs.ghostty = {
    enable = true;
    # nixpkgs ghostty is linux-only; on darwin the app comes from homebrew/Brewfile
    package = null;
    settings = {
      # https://ghostty.org/docs/config/reference
      # matches home/programs/wezterm/wezterm.lua
      font-family = "VictorMono Nerd Font";
      font-style = "DemiBold";
      font-size = 14;
    };
  };
}
