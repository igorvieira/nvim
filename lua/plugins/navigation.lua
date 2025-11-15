return {
  -- Better visual indicators for references and definitions
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        providers = { "lsp", "treesitter" },
        delay = 200,
        filetypes_denylist = {
          "mason", "harpoon", "DressingInput", "NeogitCommitMessage", "qf", "dirvish",
          "fugitive", "alpha", "NvimTree", "lazy", "NeogitStatus", "Trouble", "lir",
          "Outline", "spectre_panel", "toggleterm", "DressingSelect", "TelescopePrompt",
        },
        under_cursor = true,
      })
      
      vim.keymap.set("n", "<leader>hr", function()
        require("illuminate").toggle()
      end, { desc = "Toggle highlight references" })
    end,
  },

  -- Enhanced navigation with marks and sessions
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
  },

  -- Better quickfix window for references
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        icons = true,
        fold_open = "",
        fold_closed = "",
        indent_lines = false,
        signs = {
          error = "󰅚",
          warning = "󰀪",
          hint = "󰌶",
          information = "",
        },
        use_diagnostic_signs = false,
      })

      vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
      vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
      vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
      vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
      vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
    end,
  },
}
