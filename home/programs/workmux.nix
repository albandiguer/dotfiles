{ workmux, pkgs, ... }:
{
  home.packages = [
    workmux.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.fish.interactiveShellInit = ''
    workmux completions fish | source
  '';
}
