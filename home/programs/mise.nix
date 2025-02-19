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
        # postgres = "14.15";
        aws-cli = "latest";
        gcloud = "latest";
        node = "latest";
        ruby = "latest";
        terraform = "latest";
        uv = "latest";
      };

      tasks = {
        setup-molten = {
          run = [
            "mkdir -p ~/.virtualenvs"
            "uv venv --python $(which python3.13) ~/.virtualenvs/molten"
            ". ~/.virtualenvs/molten/bin/activate && uv pip install ipykernel pynvim jupyter_client jupytext cairosvg plotly kaleido pnglatex pyperclip pyperclip nbformat requests websocket-client"
            # register that kernel
            ". ~/.virtualenvs/molten/bin/activate && python -m ipykernel install --user --name=molten --display-name \"Python 3.13\""
          ];
        };
      };
    };
  };
}
