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
    podman-tui
    podlet # docker/compose -> quadlet
  ];

}
