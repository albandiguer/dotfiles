{pkgs, ...}: {
  programs.fish = {
    enable = true;

    # Source here https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix

    shellAliases = {
      ls = "eza";
      cat = "bat";
      vim = "nvim";
    };

    # NOTE some config here https://discourse.nixos.org/t/how-to-use-completion-fish-with-home-manager/23356

    shellAbbrs = {
      bs = "brew search";
      c = "clear";
      condaenvs = "conda env list";
      dk = "docker";
      dkc = "docker compose";
      g = "git";
      gst = "git status";
      l = "ls -la";
      m = "make";
      ns = "nix search nixpkgs";
      prettyjson = "python -m json.tool";
      td = "todoist";
    };

    functions = {
      gri = "git merge-base $(git rev-parse --abbrev-ref origin/HEAD) HEAD|xargs git rebase -i";
      diffib = "git merge-base $(git rev-parse --abbrev-ref origin/HEAD) HEAD|xargs -I _ git diff _ -- $argv[1]";
    };

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

    # https://github.com/budimanjojo/tmux.fish
  };
}
