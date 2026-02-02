return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Basic Mason configuration
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
      max_concurrent_installers = 4,
      github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
      }
    })

    -- LSPs configuration
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "rust_analyzer",
        "pyright",
        "clangd",
        "elixirls",
        "astro"
      },
      automatic_installation = true,
    })

    -- List of tools to install manually
    local tools_to_install = {
      "prettier",
      "stylua",
      "eslint_d",
      "black",
      "isort",
      "rustfmt",
      "clang-format",
      "pylint",
    }

    -- Function to install tools individually
    local function install_tools()
      local registry = require("mason-registry")
      
      for _, tool in ipairs(tools_to_install) do
        local p = registry.get_package(tool)
        if not p:is_installed() then
          vim.notify("Installing " .. tool .. "...", vim.log.levels.INFO)
          p:install()
        else
          vim.notify(tool .. " is already installed", vim.log.levels.INFO)
        end
      end
    end

    -- Custom command to install all tools
    vim.api.nvim_create_user_command("MasonInstallTools", function()
      install_tools()
    end, { desc = "Install all necessary tools" })

    -- Auto-install tools on startup (optional)
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonRegistryReady",
      callback = function()
        -- Uncomment the line below if you want automatic installation
        -- install_tools()
      end,
    })
  end,
}
