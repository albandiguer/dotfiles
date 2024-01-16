{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;

    # Source here https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix

    shellAliases = {
      vim = "nvim";
      td = "todoist";
      dk = "docker";
      dkc = "docker-compose";
      condaenvs = "conda env list";
      prettyjson = "python3 -mjson.tool";
      nixsearch = "nix search nixpkgs";
    };

    # NOTE some config here https://discourse.nixos.org/t/how-to-use-completion-fish-with-home-manager/23356

    shellAbbrs = {
      condaenvs = "conda env list";
      dk = "docker";
      dkc = "docker-compose";
      g = "git";
      gst = "git status";
      l = "ls -la";
      m = "make";
      ns = "nixsearch";
      prettyjson = "python -m json.tool";
      td = "todoist";
    };

    # functions = ''
    #   {
    #     gri = git merge-base origin/master HEAD|xargs git rebase -i;
    #     diffib = 	git merge-base origin/master HEAD|xargs -I _ git diff _ -- $1;
    #   }
    # '';

    # https://github.com/budimanjojo/tmux.fish
  };
}
