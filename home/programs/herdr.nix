{ config, lib, pkgs, herdr-worktreeinclude, ... }:

{
  programs.herdr = {
    enable = true;
    # package is the default herdr from nixpkgs
  };

  home.activation.linkHerdrWorktreeinclude =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD ${lib.getExe pkgs.herdr} plugin link ${herdr-worktreeinclude}
    '';
}
