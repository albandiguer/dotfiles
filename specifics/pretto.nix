{ lib, config, ... }:

{
  # this is not right but came from anterior install or smt
  ids.gids.nixbld = lib.mkForce 350;
  users.groups.nixbld.gid = lib.mkForce 350;

  home-manager.users.albandiguer = {
    programs.git.settings.user.email = lib.mkForce "alban.diguer@pretto.fr";
    home.sessionVariables.OBSIDIAN_VAULT_PATH = "/Users/albandiguer/Google Drive/My Drive/obsidian_vaults/Reliable Brain";
    home.sessionVariables.PRETTO_OBSIDIAN_VAULT_PATH = "/Users/albandiguer/Google Drive/My Drive/obsidian_vaults/Pretto";
    home.sessionVariables.CLAUDE_AGENTS_SUBFOLDER = "agents";
    # Use Claude Code on work laptop
    home.sessionVariables.DEFAULT_AI_AGENT = "claude";
    # Pretto-specific skill lock (adds linear-cli)
    home.file.".agents/.skill-lock.json".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "/Users/albandiguer/dev/dotfiles/home/dotfiles/.agents/.skill-lock-pretto.json"
    );
  };
}
