return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
        layout = { position = "bottom", ratio = 0.4 },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-e>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = 'node',
      server_opts_overrides = {},
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "Painel do Copilot" })
    keymap.set("n", "<leader>cs", "<cmd>Copilot status<CR>", { desc = "Status do Copilot" })
    keymap.set("n", "<leader>ce", "<cmd>Copilot enable<CR>", { desc = "Habilitar Copilot" })
    keymap.set("n", "<leader>cd", "<cmd>Copilot disable<CR>", { desc = "Desabilitar Copilot" })
  end,
}
