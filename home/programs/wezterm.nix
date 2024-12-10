{
  pkgs,
  ...

}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Some fair configs here
      -- https://patagia.dev/dln/nixos-config/src/commit/c71739fcd9a927757a804fc198d9b9fc9acc7d4d/.config/wezterm/wezterm.lua

      local config = {};
      config.audible_bell = "Disabled"

      config.color_scheme = 'N0Tch2K (Gogh)'
      -- config.color_scheme = 'Harper'

      config.front_end = "WebGpu"; -- https://github.com/wez/wezterm/issues/5990#issuecomment-2295721814
      config.hide_tab_bar_if_only_one_tab = true;
      config.window_decorations = "RESIZE"; -- https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html

      -- wezterm ls-fonts --list-system|grep Monaco
      -- config.font = wezterm.font("Monaco Nerd Font Mono", {weight="Book", stretch="Normal", style="Normal"});
      -- config.font = wezterm.font("VictorMono Nerd Font", {weight="DemiBold", stretch="Normal", style="Normal"});
      config.font = wezterm.font("JetBrainsMono Nerd Font Mono", {weight="Medium", stretch="Normal", style="Normal"});
      config.font_size = 11.5;
      config.line_height = 1.2;

      config.window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
      };


      return config;
    '';
  };

}
