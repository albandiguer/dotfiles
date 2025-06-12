{ lib, ... }:

{
	# this is not right but came from anterior install or smt
  ids.gids.nixbld = lib.mkForce 350;
  users.groups.nixbld.gid = lib.mkForce 350;
  
  home-manager.users.albandiguer = {
    programs.git.userEmail = lib.mkForce "alban.diguer@pretto.fr";
    home.sessionVariables.OBSIDIAN_VAULT_PATH = 
      "/Users/albandiguer/Google Drive/My Drive/obsidian_vaults/Reliable Brain";
  };
}
