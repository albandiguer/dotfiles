{ pkgs, ... }:
let
  ponytail-src = builtins.fetchGit {
    url = "https://github.com/DietrichGebert/ponytail.git";
    ref = "main";
    rev = "6da37bfa7d0282522c7785759f4d2f1544015354";
  };
in
{
  programs.opencode = {
    enable = true;

    # Global configuration settings
    # See: https://opencode.ai/docs/config/
    settings = {
      autoupdate = true;
      autoshare = false;
      model = "deepseek/deepseek-v4-pro";
      plugin = [ "${ponytail-src}/.opencode/plugins/ponytail.mjs" ];

      # MCP servers configuration
      mcp = {
        serena = {
          type = "local";
          command = [
            "uvx"
            "--from"
            "git+https://github.com/oraios/serena"
            "serena"
            "start-mcp-server"
            "--context=claude-code"
            "--project-from-cwd"
            "--open-web-dashboard"
            "False"
          ];
          enabled = true;
        };
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
          enabled = true;
        };
      };
    };

    # Global rules written to ~/.config/opencode/AGENTS.md
    context = ''
      # OpenCode Global Rules

      You are an AI coding assistant helping with software development tasks.
      Follow the existing code style and conventions in the project.
      Always prefer explicit, clear code over clever one-liners.
      When making changes, ensure you maintain backward compatibility when possible.
    '';
  };

  # TUI config + plugins + ponytail commands — merged into single home.file set
  home.file = {
    ".config/opencode/tui.json".text = ''
      {
        "$schema": "https://opencode.ai/tui.json",
        "theme": "catppuccin-frappe"
      }
    '';

    ".config/opencode/plugins/rtk.ts".text = builtins.readFile ./opencode/plugins/rtk.ts;

    ".config/opencode/plugins/caveman.ts".text = builtins.readFile ./opencode/plugins/caveman.ts;

    ".config/opencode/plugins/ponytail.mjs".source = "${ponytail-src}/.opencode/plugins/ponytail.mjs";
  }
  # Dynamically link all ponytail commands from repo directory
  // builtins.listToAttrs (
    map (name: {
      name = ".config/opencode/command/${name}";
      value = {
        source = "${ponytail-src}/.opencode/command/${name}";
      };
    }) (builtins.attrNames (builtins.readDir "${ponytail-src}/.opencode/command"))
  );

}
