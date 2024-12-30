{
  config,
  pkgs,
  lib,
  ...
}: 
{
  programs.kitty = {
    enable = false;
    settings = {
      # Font configuration
      font_family = "JetBrainsMono Nerd Font";
      font_size = "12.0";
      adjust_line_height = "120%";
      
      # Window layout
      window_padding_width = "4";
      hide_window_decorations = "yes";
      confirm_os_window_close = "0";

      # Tab bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      
      # Color scheme
      background_opacity = "0.95";
      
      # Performance
      repaint_delay = "10";
      input_delay = "3";
      sync_to_monitor = "yes";
      
      # Bell
      enable_audio_bell = "no";
      visual_bell_duration = "0.0";
      window_alert_on_bell = "yes";
      
      # Shell integration
      shell_integration = "enabled";
      
      # URLs
      url_style = "curly";
      open_url_with = "default";
      copy_on_select = "yes";
    };
    
    # Extra configuration can be added directly
    extraConfig = ''
      # MacOS specific
      macos_option_as_alt yes
      macos_quit_when_last_window_closed yes
      macos_window_resizable yes
    '';
  };
}
