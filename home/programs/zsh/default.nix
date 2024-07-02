{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = false;

    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    enableCompletion = false; # bug atm, makes the tab clear term, let the zsh-nix-shell below handle

    initExtra = builtins.readFile ./init.zsh;

    sessionVariables = {
      # NOTE Both vars not doing anything as tmux plugin is not in the list?
      # https://blog.wescale.fr/tmux-diviser-pour-mieux-regner
      # ZSH_TMUX_AUTOSTART = "true";
      # ZSH_TMUX_AUTOCONNECT = "true";
      
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];

    # NOTE plugins redundant when completion is enabled directly from tool
    # check what's implemented by plugins..
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "aws"
        "docker"
        "docker-compose"
        "minikube"
        "kubectl"
        "terraform"
      ];
      theme = "robbyrussell";
    };
  };
}
