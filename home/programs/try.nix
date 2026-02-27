{ try, ... }:
{
  imports = [ try.homeModules.default ];

  programs.try = {
    enable = true;
    path = "~/dev/experiments";
  };
}
