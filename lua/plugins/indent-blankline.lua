return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  config = function()
    local ibl = require("ibl")
    
    ibl.setup({
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = true,
        show_end = true,
        injected_languages = false,
        highlight = { "Function", "Label" },
        priority = 500,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "nvim-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = { "terminal", "nofile" },
      },
    })
    
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4252" })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#BD93F9" })
    end)
  end,
}
