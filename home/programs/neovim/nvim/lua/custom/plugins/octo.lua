return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    picker = "telescope",
    enable_builtin = true,
  },
  keys = {
    { "<leader>Oi", "<CMD>Octo issue list<CR>", desc = "List GitHub Issues" },
    { "<leader>Op", "<CMD>Octo pr list<CR>", desc = "List GitHub PullRequests" },
    { "<leader>Od", "<CMD>Octo discussion list<CR>", desc = "List GitHub Discussions" },
    { "<leader>On", "<CMD>Octo notification list<CR>", desc = "List GitHub Notifications" },
    {
      "<leader>Os",
      function()
        require("octo.utils").create_base_search_command { include_current_repo = true }
      end,
      desc = "Search GitHub",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}
