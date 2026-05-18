{ workmux, pkgs, ... }:
{
  home.packages = [
    (workmux.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (_: { doCheck = false; }))
  ];

  programs.fish.interactiveShellInit = ''
    workmux completions fish | source
  '';

  xdg.configFile."workmux/config.yaml".source = ../dotfiles/workmux/config.yaml;
}
