{ config, lib, ... }:

let
  cfg = config.programs.mise;
in
{
  options.programs.mise.nodeDefaultPackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    # Empty on purpose: the common packages below are a *definition*, not a default,
    # so per-machine lists in specifics/<machine>.nix concatenate instead of replacing.
    default = [ ];
    description = ''
      npm packages installed globally for every installed node version.
      Per-machine additions go in specifics/<machine>.nix (list options merge).
    '';
  };

  config = {
    programs.mise.nodeDefaultPackages = [
      "yarn"
      "diffity"
      "@mariozechner/pi-coding-agent"
    ];

    # mise reads exactly one file, so generate it from the merged list (common + per-machine).
    # ponytail: node.default_packages_file is deprecated upstream (they point at the `npm:`
    # backend / tool postinstall hooks); migrate when mise stops reading it.
    home.file.".default-node-packages".text = lib.concatStringsSep "\n" cfg.nodeDefaultPackages + "\n";

    programs.mise = {
      enable = true;
      # see this for dotfiles https://mise.jdx.dev/lang/ruby.html#default-gems
      globalConfig = {
        tools = {
          "github:onlyati/quadlet-lsp" = "latest";
          aws-cli = "latest";
          node = "latest";
          ruby = "latest";
          rust = "latest";
          terraform = "latest";
          pitchfork = "latest";
          hk = "latest";
          uv = "latest";
          # Tools installed via uv (not declared here, installed imperatively):
          #   uv tool install git+https://github.com/cpatrickalves/plane-cli.git
          #   uv tool install graphifyy
          pnpm = "latest";
        };

        # https://github.com/jdx/mise/blob/main/settings.toml
        settings = {
          idiomatic_version_file = true; # .ruby-version etc
          idiomatic_version_file_enable_tools = [
            "ruby"
            "node"
          ]; # check out all settings: mise settings ls -a
        };

        # tasks = {
        #   create-molten-venv = {
        #     run = [
        #       "mkdir -p ~/.virtualenvs"
        #       "uv venv --python $(which python3.13) ~/.virtualenvs/molten"
        #       ". ~/.virtualenvs/molten/bin/activate && uv pip install ipykernel pynvim jupyter_client jupytext cairosvg plotly kaleido pnglatex pyperclip pyperclip nbformat requests websocket-client"
        #       # register kernel
        #       ". ~/.virtualenvs/molten/bin/activate && python -m ipykernel install --user --name=molten --display-name \"Python 3.13\""
        #     ];
        #   };
        # };
      };
    };
  };
}
