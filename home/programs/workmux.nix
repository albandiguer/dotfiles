{ pkgs, ... }:
let
  version = "0.1.211";
  workmux = pkgs.stdenv.mkDerivation {
    pname = "workmux";
    inherit version;
    src = pkgs.fetchurl {
      url = "https://github.com/raine/workmux/releases/download/v${version}/workmux-darwin-arm64.tar.gz";
      hash = "sha256-dsl8c3OC2OtvQxzkzCxS0wDdG7Q+C9CZRh0mjtkc2Vo=";
    };
    sourceRoot = ".";
    installPhase = ''
      install -Dm755 workmux $out/bin/workmux
    '';
    meta.platforms = [ "aarch64-darwin" ];
  };
in
{
  home.packages = [ workmux ];

  programs.fish.interactiveShellInit = ''
    workmux completions fish | source
  '';

  xdg.configFile."workmux/config.yaml".source = ../dotfiles/workmux/config.yaml;
}
