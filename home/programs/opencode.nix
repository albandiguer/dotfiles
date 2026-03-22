{ pkgs, lib, ... }:
{
  programs.opencode = {
    enable = true;

    # Global configuration settings
    # See: https://opencode.ai/docs/config/
    settings = {
      theme = "catppuccin-frappe";
      autoupdate = true;
      autoshare = false;
      model = "kimi/k2.5";

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
    rules = ''
      # OpenCode Global Rules

      You are an AI coding assistant helping with software development tasks.
      Follow the existing code style and conventions in the project.
      Always prefer explicit, clear code over clever one-liners.
      When making changes, ensure you maintain backward compatibility when possible.
    '';
  };

  # Symlink skills to OpenCode's skills directory
  home.file.".config/opencode/skills/find-skills" = {
    source = lib.cleanSource ../dotfiles/.agents/skills/find-skills;
    recursive = true;
  };
}
