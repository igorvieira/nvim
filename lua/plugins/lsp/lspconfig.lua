return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap

        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, blink = pcall(require, 'blink.cmp')
    if ok and blink.get_lsp_capabilities then
      capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
    end

    local servers = {
      html = {},
      cssls = {},
      ts_ls = {},
      tailwindcss = {},
      emmet_ls = {
        filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false }
          }
        },
      }
    }

    for name, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[name].setup(config)
    end
  end,
}
