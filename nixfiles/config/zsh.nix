{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      source <(kubectl completion zsh)
      source <(minikube completion zsh)
    '';

    sessionVariables = {
      ZSH_TMUX_AUTOSTART="true";
      ZSH_TMUX_AUTOCONNECT="true";
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
        rev = "v0.4.0";
        sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
      };
    }];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

  };
}
