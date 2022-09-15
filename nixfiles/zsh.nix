{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;

    enableCompletion =
      false; # bug atm, makes the tab clear term, let the zsh-nix-shell below handle

    initExtra = ''
      # Add local directory ./node_modules/.bin
      # + a global directory for `npm i -g` https://matthewrhone.dev/nixos-npm-globally
      export PATH="./bin:./node_modules/.bin:$HOME/.npm-packages/bin:$PATH";
      export NODE_PATH=~/.npm-packages/lib/node_modules

      source <(kubectl completion zsh)
      if [ -f minikube ]; then
        source <(minikube completion zsh)
      fi

      alias nixsearch="nix search nixpkgs"

      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      __conda_setup="$('/Users/albandiguer/dev/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__conda_setup"
      else
          if [ -f "/Users/albandiguer/dev/miniforge3/etc/profile.d/conda.sh" ]; then
              . "/Users/albandiguer/dev/miniforge3/etc/profile.d/conda.sh"
          else
              export PATH="/Users/albandiguer/dev/miniforge3/bin:$PATH"
          fi
      fi
      unset __conda_setup
      # <<< conda initialize <<<

      alias condaenvs="conda env list"

      alias prettyjson="python3 -mjson.tool"
      # use: conda activate mlp | base to activate an environment
      # use: conda deactivate to deactivate environment

      # not closing shell on ctrl+d
      setopt ignore_eof

      # docker-compose
      # alias docker-compose="dkc"

      # todoist
      alias td="todoist"
      alias tdl="todoist l"
      alias tda="todoist a"
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
