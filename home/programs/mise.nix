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
    };
  };
}
