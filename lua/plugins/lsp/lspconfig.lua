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

        -- LSP Navigation - atalhos padrão
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { buffer = ev.buf, silent = true, desc = "Show references" })
        keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, silent = true, desc = "Go to declaration" })
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = ev.buf, silent = true, desc = "Go to definition" })
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { buffer = ev.buf, silent = true, desc = "Go to implementation" })
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { buffer = ev.buf, silent = true, desc = "Go to type definition" })

        -- Atalhos alternativos mais fáceis de lembrar para componentes
        keymap.set("n", "<leader>cd", "<cmd>Telescope lsp_definitions<CR>", { buffer = ev.buf, silent = true, desc = "Go to Component Definition" })
        keymap.set("n", "<leader>cr", "<cmd>Telescope lsp_references<CR>", { buffer = ev.buf, silent = true, desc = "Find Component References (where it's used)" })
        keymap.set("n", "<leader>ci", "<cmd>Telescope lsp_implementations<CR>", { buffer = ev.buf, silent = true, desc = "Go to Component Implementation" })
        keymap.set("n", "<leader>cb", "<C-o>", { buffer = ev.buf, silent = true, desc = "Go Back to previous location" })
        keymap.set("n", "<leader>cf", "<C-i>", { buffer = ev.buf, silent = true, desc = "Go Forward in jump list" })

        -- LSP Actions
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, silent = true, desc = "Code action" })
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, silent = true, desc = "Rename" })
        keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, silent = true, desc = "Hover documentation" })
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", { buffer = ev.buf, silent = true, desc = "Restart LSP" })
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
