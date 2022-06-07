{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion =
      false; # bug atm, makes the tab clear term, let the zsh-nix-shell below handle

    initExtra = ''
      source <(kubectl completion zsh)
      source <(minikube completion zsh)
    '';

    sessionVariables = {
      ZSH_TMUX_AUTOSTART = "true";
      ZSH_TMUX_AUTOCONNECT = "true";
    };

    # shellInit = ''
    #   eval "$(mcfly init zsh)"
    # '';
    # shellInit = ''
    # if [ -n "${commands[fzf-share]}" ]; then
    # source "$(fzf-share)/key-bindings.zsh"
    # source "$(fzf-share)/completion.zsh"
    # fi
    # '';

    plugins = [{
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.5.0";
        sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      };
    }];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

  };
}
