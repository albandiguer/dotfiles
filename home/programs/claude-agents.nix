{rails-ai-agents, ...}: {
  home.file.".claude/agents" = {
    source = "${rails-ai-agents}/agents";
    recursive = true;
  };
}
