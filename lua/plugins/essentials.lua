return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },
  {
    "szw/vim-maximizer",
    keys = { { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximizar/minimizar split" } },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup() end,
  },
  { "vim-scripts/ReplaceWithRegister", keys = { { "gr", mode = { "n", "v" } } } },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,
        ts_config = { 
          lua = { "string", "source" }, 
          javascript = { "string", "template_string" },
          typescript = { "string", "template_string" },
        },
      })
      
      local cmp = require("blink.cmp")
      if cmp and cmp.on_confirm_done then
        cmp.on_confirm_done(autopairs.on_confirm_done())
      end
    end,
  },
}
