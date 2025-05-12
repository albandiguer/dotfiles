{pkgs, ...}: {
  programs.bash = {
    enable = true;

    initExtra = ''
      # include .profile if it exists
      [[ -f ~/.profile ]] && . ~/.profile
      alias docker=podman
      alias docker-compose=podman-compose
    '';
  };
}
