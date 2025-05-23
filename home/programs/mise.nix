{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.mise = {
    enable = true;
    # see this for dotfiles https://mise.jdx.dev/lang/ruby.html#default-gems
    globalConfig = {
      tools = {
        aws-cli = "latest";
        gcloud = "latest";
        node = "latest";
        postgres = "latest";
        ruby = "latest";
        rust = "latest"; # need rustup for aider-chat deps (tiktoken)
        terraform = "latest";
        uv = "latest"; # shall it be in nix instead?
      };
      
      # https://github.com/jdx/mise/blob/main/settings.toml
      settings = {
        idiomatic_version_file = true; # .ruby-version etc
        idiomatic_version_file_enable_tools = ["ruby" "node"];
      };

      tasks = {
        create-molten-venv = {
          run = [
            "mkdir -p ~/.virtualenvs"
            "uv venv --python $(which python3.13) ~/.virtualenvs/molten"
            ". ~/.virtualenvs/molten/bin/activate && uv pip install ipykernel pynvim jupyter_client jupytext cairosvg plotly kaleido pnglatex pyperclip pyperclip nbformat requests websocket-client"
            # register kernel
            ". ~/.virtualenvs/molten/bin/activate && python -m ipykernel install --user --name=molten --display-name \"Python 3.13\""
          ];
        };
      };
    };
  };
}
