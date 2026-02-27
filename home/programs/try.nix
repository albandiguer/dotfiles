{ try, ... }:
{
  imports = [ try.homeManagerModules.default ];

  programs.try = {
    enable = true;
    path = "~/dev/experiments";
  };
}
