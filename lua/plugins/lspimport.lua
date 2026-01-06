return {
  "stevanmilic/nvim-lspimport",
  event = "LspAttach",
  config = function()
    require("lspimport").setup()

    -- Keymap to auto-import missing symbol under cursor
    vim.keymap.set("n", "<leader>ai", function()
      require("lspimport").import()
    end, { desc = "Auto-import symbol under cursor" })
  end,
}
