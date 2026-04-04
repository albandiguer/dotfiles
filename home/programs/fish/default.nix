{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    # Source here https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix

    shellAliases = {
      cat = "bat";
      vim = "nvim";
      diff = "nvim -d";
      gsd-up = "npx get-shit-done-cc@latest"; # maj gsd
      # docker = "podman";
    };

    # NOTE some config here https://discourse.nixos.org/t/how-to-use-completion-fish-with-home-manager/23356

    shellAbbrs = {
      b = "bin/bundle";
      bd = "bin/dev";
      be = "bundle exec";
      br = "bin/rspec";
      bs = "brew search";
      c = "clear";
      cc = "claude"; # claude code
      cs = "claude-squad";
      db = "nvim +DBUI";
      dk = "docker";
      dkc = "docker compose";
      dkcd = "docker compose down";
      dkcud = "docker compose up -d";
      g = "git";
      gd = "gh dash";
      interpret = "mise x python@3.11 -- interpreter"; # -- pip install open-interpreter
      l = "eza -la";
      ld = "lazydocker";
      lg = "lazygit";
      m = "make";
      mrd = "mise run dev";
      n = "nix";
      ns = "nix search nixpkgs";
      nsn = "nix shell nixpkgs#";
      oc = "opencode";
      prettyjson = "python -m json.tool";
      ptui = "podman-tui";
      r = "bin/rails";
      s = "bin/rspec";
      sff = "bin/rspec --fail-fast";
      skills = "npx skills";
      tf = "terraform";
      y = "yarn";
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
      wt = ''
        				if test (count $argv) -ge 2; and test $argv[1] = "create"
        					# Get worktrees before creation
        					set -l before_worktrees (git worktree list --porcelain 2>/dev/null | grep "^worktree" | string replace "worktree " "")
        					
        					# Create the worktree
        					command wt switch -c $argv[2] --no-cd
        					set -l wt_status $status
        					
        					# If successful, find and add new worktree to zoxide
        					if test $wt_status -eq 0
        						set -l after_worktrees (git worktree list --porcelain 2>/dev/null | grep "^worktree" | string replace "worktree " "")
        						for wt_path in $after_worktrees
        							if not contains $wt_path $before_worktrees
        								zoxide add $wt_path
        								break
        							end
        						end
        					end
        				else
        					command wt $argv
        				end
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
      # Replaced by zoxide (faster Rust implementation)
      # {
      #   name = "z";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "jethrokuan";
      #     repo = "z";
      #     rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
      #     sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
      #   };
      # }
    ];

    # https://stackoverflow.com/questions/34216850/how-to-prevent-fish-shell-from-closing-when-typing-ctrl-d-eof
    interactiveShellInit = ''
      			set -g fish_eof none
      			set -gx LANG en_AU.UTF-8
      			set -gx PATH /Users/albandiguer/.local/share/mise/shims $PATH
      			set -gx PATH /Users/albandiguer/.npm-packages/bin $PATH
      			set -gx PATH /opt/homebrew/opt/icu4c/bin $PATH
      			set -gx BAT_THEME "1337"

      			# Build deps required for mise to install postgres (and similar tools)
      			set -gx PKG_CONFIG_PATH /opt/homebrew/opt/icu4c/lib/pkgconfig /opt/homebrew/opt/curl/lib/pkgconfig /opt/homebrew/opt/zlib/lib/pkgconfig $PKG_CONFIG_PATH
      			set -gx MACOSX_DEPLOYMENT_TARGET (sw_vers -productVersion)

      			# Set DOCKER_HOST from podman machine if available
      			if command -v podman > /dev/null
      				and podman machine list --format json | jq -e '.[].Running' > /dev/null 2>&1
      				set -gx DOCKER_HOST (podman machine inspect | jq -r '.[0].ConnectionInfo.PodmanSocket.Path | sub("^"; "unix://")')
      			end

      			# git-spice (gs) shell completion
      			function __complete_gs
      				set -lx COMP_LINE (commandline -cp)
      				test -z (commandline -ct)
      				and set COMP_LINE "$COMP_LINE "
      				/etc/profiles/per-user/albandiguer/bin/gs
      			end
      			complete -f -c gs -a "(__complete_gs)"
      		'';

    # https://github.com/budimanjojo/tmux.fish
  };
}
