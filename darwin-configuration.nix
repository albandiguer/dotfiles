{pkgs, ...}: {
  nix.package = pkgs.nix;
  environment.systemPackages = with pkgs; [yabai];
  services.yabai.enable = true;
}
