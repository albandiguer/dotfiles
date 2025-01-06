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
        node = "latest";
        gcloud = "latest";
        ruby = "latest";
        terraform = "latest";
        # postgres = "14.15";
        aws-cli = "latest";
      };
    };
  };
}
