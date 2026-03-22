{ pkgs, ... }:
{
  programs.opencode = {
    enable = true;

    # Map your existing .agents subdirectories to opencode concepts
    # These will be symlinked from ~/.config/opencode/
    #
    # .agents/commands/ -> ~/.config/opencode/command/
    # .agents/skills/ -> ~/.config/opencode/skills/
    commands = ../dotfiles/.agents/commands;
    skills = ../dotfiles/.agents/skills;

    # Global configuration settings
    # See: https://opencode.ai/docs/config/
    settings = {
      theme = "opencode";
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
}
