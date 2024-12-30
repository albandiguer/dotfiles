{...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

     # https://starship.rs/fr-FR/config/#invite

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      ruby.disabled = false;
      nodejs.disabled = true;
      package.disabled = true;
      docker_context.disabled = true;
      gcloud = {
        disabled = true;
        symbol = "🇬️ ";
      };
    };
  };
}
