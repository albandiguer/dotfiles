{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      # https://starship.rs/fr-FR/config/#invite

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      directory = {
        format = "[ $path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
      };

      ruby.disabled = false;
      nodejs.disabled = false;
      package.disabled = true;
      docker_context.disabled = false;
      gcloud = {
        disabled = true;
        symbol = "🇬️ ";
      };
    };
  };
}
