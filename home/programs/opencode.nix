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
    rules = ''
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

  # RTK plugin for token-efficient command rewriting
  home.file.".config/opencode/plugins/rtk.ts".text = ''
    import type { Plugin } from "@opencode-ai/plugin"

    // RTK OpenCode plugin — rewrites commands to use rtk for token savings.
    // Requires: rtk >= 0.23.0 in PATH.
    //
    // This is a thin delegating plugin: all rewrite logic lives in `rtk rewrite`,
    // which is the single source of truth (src/discover/registry.rs).

    export const RtkOpenCodePlugin: Plugin = async ({ $ }) => {
      try {
        await $`which rtk`.quiet()
      } catch {
        console.warn("[rtk] rtk binary not found in PATH — plugin disabled")
        return {}
      }

      return {
        "tool.execute.before": async (input, output) => {
          const tool = String(input?.tool ?? "").toLowerCase()
          if (tool !== "bash" && tool !== "shell") return
          const args = output?.args
          if (!args || typeof args !== "object") return

          const command = (args as Record<string, unknown>).command
          if (typeof command !== "string" || !command) return

          try {
            const result = await $`rtk rewrite ''${command}`.quiet().nothrow()
            const rewritten = String(result.stdout).trim()
            if (rewritten && rewritten !== command) {
              ;(args as Record<string, unknown>).command = rewritten
            }
          } catch {
            // rtk rewrite failed — pass through unchanged
          }
        },
      }
    }
  '';

  # Caveman plugin — auto-activate caveman mode on session start
  home.file.".config/opencode/plugins/caveman.ts".text =
    builtins.readFile ./opencode/plugins/caveman.ts;

}
