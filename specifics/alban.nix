{ pkgs, ... }:
{
  # Personal-machine only packages
  environment.systemPackages = with pkgs; [
    # httpie # http client (CLI)
    bruno

    # Kubernetes in Docker — needs the podman/docker runtime, so personal only
    k3d

    # Podman toolchain (the client itself is brew: podman is linux-only in nixpkgs)
    podman-compose
    podlet # docker/compose -> quadlet
  ];

  # Archon config lives here: the binary is personal-only (Brewfile.Albans-MacBook-Air)
  home-manager.users.albandiguer = { config, ... }: {
    imports = [ ../home/programs/archon.nix ];
    # Custom planecli skill — canonical in repo, linked live so edits apply without reapply
    home.file = {
      ".agents/skills/planecli".source =
        config.lib.file.mkOutOfStoreSymlink "/Users/albandiguer/dev/dotfiles/home/dotfiles/.agents/skills/planecli";
      ".pi/agent/skills/planecli".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.agents/skills/planecli";
    };
    # Container runtime is podman here (docker abbrs live on the work machine)
    programs.fish.shellAbbrs = {
      dk = "podman";
      dkc = "podman-compose";
      dkcd = "podman-compose down";
      dkcud = "podman-compose up -d";
      a = "archon";
      aw = "archon workflow";
    };
  };
}
