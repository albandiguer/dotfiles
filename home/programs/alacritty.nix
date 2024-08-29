{
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = false;
    settings = {
      # Change font to monaco nerd font
      font = {
        family = "Monaco Nerd Font Mono";
        size = 15;
      };
    };
  };
}
