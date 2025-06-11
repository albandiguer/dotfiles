return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  enabled = false,
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = 'copilot_claude', -- active model, builtins list here https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua#L47
    cursor_applying_provider = 'copilot_claude',
    behaviour = {
      enable_cursor_planning_mode = true, -- enable cursor planning mode! https://github.com/yetone/avante.nvim/blob/main/cursor-planning-mode.md
    },
    -- https://github.com/yetone/avante.nvim?tab=readme-ov-file#rag-service
    rag_service = {
      enabled = false, -- Enables the RAG service
      host_mount = vim.fn.getcwd, -- current directory
      provider = 'ollama', -- The provider to use for RAG service (e.g. openai or ollama)
      endpoint = 'http://localhost:11434', -- as described here https://github.com/yetone/avante.nvim?tab=readme-ov-file#rag-service
    },
    -- custom providers https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua#L304
    providers = {
      gemini = {
        model = 'gemini-2.5-pro-preview-05-06', -- overload config for FOTM gemini 2.5 https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua#L263
      },
      deepseek = { -- https://github.com/yetone/avante.nvim/pull/1038
        __inherited_from = 'openai',
        api_key_name = 'DEEPSEEK_API_KEY',
        endpoint = 'https://api.deepseek.com',
        model = 'deepseek-coder',
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
        timeout = 10000,
      },
      copilot_claude = { -- https://github.com/yetone/avante.nvim/issues/1566
        __inherited_from = 'copilot',
        model = 'claude-3.7-sonnet',
        extra_request_body = {
          temperature = 0.3,
          max_tokens = 10000,
        },
      },
      copilot_claude_thought = {
        __inherited_from = 'copilot',
        model = 'claude-3.7-sonnet-thought',
        extra_request_body = {
          temperature = 0.3,
          max_tokens = 10000,
        },
      },
      copilot_openai = {
        __inherited_from = 'copilot',
        model = 'gemini-2.0-flash-001',
      },
    },
    web_search_engine = {
      provider = 'tavily',
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    'ibhagwan/fzf-lua', -- for file_selector provider fzfim-web-devicons', -- or echasnovski/mini.icons
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'stevearc/dressing.nvim',
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
