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
  home-manager.users.albandiguer = {
    imports = [ ../home/programs/archon.nix ];
    # Container runtime is podman here (docker abbrs live on the work machine)
    programs.fish.shellAbbrs = {
      dk = "podman";
      dkc = "podman-compose";
      dkcd = "podman-compose down";
      dkcud = "podman-compose up -d";
    };
  };
}
