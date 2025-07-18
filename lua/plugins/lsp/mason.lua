return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        width = 0.8,
        height = 0.8,
      }
    })
    
    require("mason-lspconfig").setup({
      ensure_installed = { "ts_ls", "html", "cssls", "tailwindcss", "lua_ls", "emmet_ls" },
      automatic_installation = true,
    })
    
    require("mason-tool-installer").setup({
      ensure_installed = { "prettier", "stylua", "eslint_d" },
      auto_update = false,
      run_on_start = false,
    })
  end,
}
