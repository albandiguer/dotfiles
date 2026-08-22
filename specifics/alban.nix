{ pkgs, ... }:
{
  # Personal-machine only packages
  environment.systemPackages = with pkgs; [
    # httpie # http client (CLI)
    bruno
  ];

}
