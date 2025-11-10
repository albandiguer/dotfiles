{
  pkgs,
  ...
}:
{
  programs.alacritty = {
    enable = false;
    settings = {
      # Change font to monaco nerd font, find fonts with $> fc-list
      font = {
        family = "Monaco Nerd Font Complete Mono";
        size = 13;
        offset = {
          x = 0;
          y = 5;
        };
      };
    };
  };
}
