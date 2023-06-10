{
  config,
  pkgs,
  lib,
  ...
}: {
  # NOTE not supported on darwin
  services.lorri.enable = true;
}
