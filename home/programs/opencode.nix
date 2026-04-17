{ pkgs, lib, ... }:
{
  programs.opencode = {
    enable = true;

    # Global configuration settings
    # See: https://opencode.ai/docs/config/
    settings = {
      autoupdate = true;
      autoshare = false;
      model = "moonshotai/kimi-k2.5";

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

  # TUI configuration - theme settings
  home.file.".config/opencode/tui.json".text = ''
    {
      "$schema": "https://opencode.ai/tui.json",
      "theme": "catppuccin-frappe"
    }
  '';

  # Plugins — loaded from source files
  home.file.".config/opencode/plugins/rtk.ts".text = builtins.readFile ./opencode/plugins/rtk.ts;

  home.file.".config/opencode/plugins/caveman.ts".text =
    builtins.readFile ./opencode/plugins/caveman.ts;

}
