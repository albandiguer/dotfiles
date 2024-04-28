{pkgs, ...}: {
  programs.fish = {
    enable = true;

    # Source here https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix

    shellAliases = {
      ls = "eza";
      cat = "bat";
      vim = "nvim";
      db = "nvim +DBUI";
    };

    # NOTE some config here https://discourse.nixos.org/t/how-to-use-completion-fish-with-home-manager/23356

    shellAbbrs = {
      bs = "brew search";
      c = "clear";
      cs = "gh copilot suggest";
      dk = "docker";
      dkc = "docker compose";
      g = "git";
      hk = "heroku";
      l = "ls -la";
      m = "make";
      ns = "nix search nixpkgs";
      nsn = "nix shell nixpkgs#";
      prettyjson = "python -m json.tool";
      td = "todoist";
      tf = "terraform";
      ghs = "gh status";
    };

    # functions = {};

    plugins = [
      # BUG makes `vim` cmd work somehow, nvim is borked to old version, not getting why
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];

    # https://stackoverflow.com/questions/34216850/how-to-prevent-fish-shell-from-closing-when-typing-ctrl-d-eof
    interactiveShellInit = ''
      set -g fish_eof none
    '';

    # https://github.com/budimanjojo/tmux.fish
  };
}
