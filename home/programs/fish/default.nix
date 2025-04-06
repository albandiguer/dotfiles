{pkgs, ...}: {
  programs.fish = {
    enable = true;

    # Source here https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix

    shellAliases = {
      cat = "bat";
      db = "nvim +DBUI";
      ls = "eza";
      vim = "nvim";
      # docker = "podman";
    };

    # NOTE some config here https://discourse.nixos.org/t/how-to-use-completion-fish-with-home-manager/23356

    shellAbbrs = {
      aider = "uvx --from aider-chat aider --watch-files"; # same as: uv tool run --from aider-chat aider";
      b = "bin/bundle";
      bs = "brew search";
      c = "clear";
      cs = "gh copilot suggest";
      dk = "docker";
      dkc = "docker compose";
      dkcd = "docker compose down";
      dkcud = "docker compose up -d";
      g = "git";
      hk = "heroku";
      interpret = "mise x python@3.11 -- interpreter"; # -- pip install open-interpreter
      l = "ls -la";
      ld = "lazydocker";
      lg = "lazygit";
      m = "make";
      n = "nix";
      ns = "nix search nixpkgs";
      nsn = "nix shell nixpkgs#";
      prettyjson = "python -m json.tool";
      r = "bin/rails";
      tf = "terraform";
    };

    functions = {
      alogs = ''
        function alogs
          echo "Enter AWS profile (default: pretto-prod):"
          read -l aws_profile
          if not set -q aws_profile
            set aws_profile pretto-prod
          end
          echo "Verifying AWS SSO session..."
          if not aws sso list-accounts --profile $aws_profile --config ~/.aws/config > /dev/null 2>&1
            aws sso login --profile $aws_profile
          end
          echo "Select log group..."
          set selected_group (awslogs groups --profile pretto-prod | fzf)
          echo "Add any filters you like..."
          read -l filters
          echo "Fetching logs..."
          awslogs get $selected_group --timestamp --profile pretto-prod $filters
        end
      '';
      miserefresh = ''
        mise cache clean
        mise ls-remote ruby
      '';
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
      # it's also packaged in nixpkgs, TODO: find syntax
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
    ];

    # https://stackoverflow.com/questions/34216850/how-to-prevent-fish-shell-from-closing-when-typing-ctrl-d-eof
    interactiveShellInit = ''
      set -g fish_eof none
      set -gx LANG en_AU.UTF-8
      set -gx PATH /Users/albandiguer/.local/share/mise/shims $PATH
      set -gx PATH /Users/albandiguer/.npm-packages/bin $PATH
      set -gx BAT_THEME "1337"
    
      # Set DOCKER_HOST from podman machine if available
      if command -v podman > /dev/null
        and podman machine list --format json | jq -e '.[].Running' > /dev/null 2>&1
        set -gx DOCKER_HOST (podman machine inspect | jq -r '.[0].ConnectionInfo.PodmanSocket.Path | sub("^"; "unix://")')
      end
    '';

    # https://github.com/budimanjojo/tmux.fish
  };
}
