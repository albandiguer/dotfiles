{ pkgs, ... }:
{
  # Personal-machine only packages
  environment.systemPackages = with pkgs; [
    httpie # http client (CLI)
  ];

  # Personal-machine only Homebrew packages
  homebrew = {
    taps = [
      "coleam00/archon"
    ];
    brews = [
      "podman" # linux-only in nixpkgs; brew ships the darwin client + podman machine
      "archon"
      "qrencode"
      "sandvault"
    ];
    casks = [
      "httpie-desktop" # GUI; the httpie CLI comes from nix
    ];
  };
}
