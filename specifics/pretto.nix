{ lib, pkgs, ... }:

{
  # this is not right but came from anterior install or smt
  ids.gids.nixbld = lib.mkForce 350;
  users.groups.nixbld.gid = lib.mkForce 350;

  # Work-only system packages
  environment.systemPackages = with pkgs; [
    _1password-cli
    bruno
    ssm-session-manager-plugin # aws ecs execute-command  https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
  ];

  home-manager.users.albandiguer = { config, ... }: {
    imports = [
      ../home/programs/claude.nix
    ];
    programs = {
      git.settings.user.email = lib.mkForce "alban.diguer@pretto.fr";
      mise.globalConfig.tools.gcloud = "latest";
      # Work-only: added on top of the common list in programs/mise.nix
      mise.nodeDefaultPackages = [ "@schpet/linear-cli" ];
      fish.shellAbbrs = {
        cc = "claude"; # claude code
        dk = "docker";
        dkc = "docker compose";
        dkcd = "docker compose down";
        dkcud = "docker compose up -d";
      };
    };
    home.sessionVariables = {
      OBSIDIAN_VAULT_PATH = "/Users/albandiguer/Google Drive/My Drive/obsidian_vaults/Reliable Brain";
      PRETTO_OBSIDIAN_VAULT_PATH = "/Users/albandiguer/Google Drive/My Drive/obsidian_vaults/Pretto";
      CLAUDE_AGENTS_SUBFOLDER = "agents";
      # Use Claude Code on work laptop
      DEFAULT_AI_AGENT = "claude";
    };
    # Pretto-specific skill lock (adds linear-cli)
    home.file.".agents/.skill-lock.json".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "/Users/albandiguer/dev/dotfiles/home/dotfiles/.agents/.skill-lock-pretto.json"
    );
  };
}
