return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "folke/neodev.nvim", opts = {} },
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

    -- Auto-organize imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("OrganizeImportsOnSave", { clear = true }),
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.py", "*.go" },
      callback = function(args)
        -- Check if LSP is attached
        local clients = vim.lsp.get_clients({ bufnr = args.buf })
        if #clients == 0 then return end

        -- Try TypeScript-specific organize imports
        for _, client in ipairs(clients) do
          if client.name == "ts_ls" or client.name == "tsserver" then
            local params = {
              command = "_typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(0) },
            }
            pcall(vim.lsp.buf.execute_command, params)
            return
          end
        end

        -- Fallback to generic organize imports code action
        pcall(vim.lsp.buf.code_action, {
          context = {
            only = { "source.organizeImports" },
            diagnostics = {},
          },
        })
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
        commands = {
          OrganizeImports = {
            function()
              local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
              }
              vim.lsp.buf.execute_command(params)
            end,
            description = "Organize Imports",
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
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false }
          }
        },
      }
    }

    local lspconfig = require("lspconfig")
    for name, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[name].setup(config)
    end
  end,
}
