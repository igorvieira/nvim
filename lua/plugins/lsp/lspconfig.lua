return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap

        -- LSP Navigation - default shortcuts
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { buffer = ev.buf, silent = true, desc = "Show references" })
        keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, silent = true, desc = "Go to declaration" })
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = ev.buf, silent = true, desc = "Go to definition" })
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { buffer = ev.buf, silent = true, desc = "Go to implementation" })
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { buffer = ev.buf, silent = true, desc = "Go to type definition" })

        -- Alternative shortcuts easier to remember for components
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

        -- Organize imports
        keymap.set("n", "<leader>oi", function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.organizeImports" },
              diagnostics = {},
            },
          })
        end, { buffer = ev.buf, silent = true, desc = "Organize imports" })
      end,
    })

    -- Auto-organize imports on save (ts_ls only; blocks briefly so it runs before formatting)
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("OrganizeImportsOnSave", { clear = true }),
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
      callback = function(args)
        local client = vim.lsp.get_clients({ bufnr = args.buf, name = "ts_ls" })[1]
        if not client then return end
        client:request_sync("workspace/executeCommand", {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(args.buf) },
        }, 1000, args.buf)
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, blink = pcall(require, "blink.cmp")
    if ok and blink.get_lsp_capabilities then
      capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
    end
    vim.lsp.config("*", { capabilities = capabilities })

    -- Base configs come from nvim-lspconfig's lsp/*.lua; these are merged on top
    local servers = {
      html = {},
      cssls = {},
      ts_ls = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
            },
          },
        },
      },
      tailwindcss = {},
      emmet_ls = {
        filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
      rust_analyzer = {},
      pyright = {},
      clangd = {},
      astro = {},
    }

    -- Servers that require an external runtime - only enabled when it is available
    local conditional_servers = {
      elixirls = function() return vim.fn.executable("elixir") == 1 and vim.fn.executable("elixir-ls") == 1 end,
    }

    for name, config in pairs(servers) do
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end

    for name, condition in pairs(conditional_servers) do
      if condition() then
        vim.lsp.enable(name)
      end
    end
  end,
}
