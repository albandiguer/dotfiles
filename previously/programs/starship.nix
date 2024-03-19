{...}: {
  programs.starship = {
    enable = false;
    settings = {
      add_newline = false;

      # https://starship.rs/fr-FR/config/#invite

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      ruby.disabled = true;
      nodejs.disabled = true;
      package.disabled = true;
      docker_context.disabled = true;
      gcloud = {
        disabled = false;
        symbol = "🇬️ ";
      };
    };
  };
}
